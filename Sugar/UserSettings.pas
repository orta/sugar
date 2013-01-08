﻿namespace RemObjects.Oxygene.Sugar;
{$HIDE W0} //supress case-mismatch errors
interface

type
  {$IF COOPER}
  UserSettings = public class mapped to java.util.prefs.Preferences
  public
    method ReadString(Key: String; DefaultValue: String): String; mapped to get(Key, DefaultValue);
    method ReadInteger(Key: String; DefaultValue: Integer): Integer; mapped to getInt(Key, DefaultValue);
    method ReadBoolean(Key: String; DefaultValue: Boolean): Boolean; mapped to getBoolean(Key, DefaultValue);
    method ReadDouble(Key: String; DefaultValue: Double): Double; mapped to getDouble(Key, DefaultValue);

    method WriteString(Key: String; Value: String); mapped to put(Key, Value);
    method WriteInteger(Key: String; Value: Integer); mapped to putInt(Key, Value);
    method WriteBoolean(Key: String; Value: Boolean); mapped to putBoolean(Key, Value);
    method WriteDouble(Key: String; Value: Double); mapped to putDouble(Key, Value);

    method Save; mapped to flush;
    method Clear; mapped to clear;
    method &Remove(Key: String); mapped to remove(Key);
    property Keys: array of String read mapped.keys;

    class method &Default: UserSettings; mapped to userRoot;
  end;
  {$ELSEIF ECHOES}
  UserSettings = public class mapped to System.Configuration.Configuration
  public
    method ReadString(Key: String; DefaultValue: String): String;
    method ReadInteger(Key: String; DefaultValue: Integer): Integer;
    method ReadBoolean(Key: String; DefaultValue: Boolean): Boolean;
    method ReadDouble(Key: String; DefaultValue: Double): Double;

    method WriteString(Key: String; Value: String);
    method WriteInteger(Key: String; Value: Integer);
    method WriteBoolean(Key: String; Value: Boolean);
    method WriteDouble(Key: String; Value: Double);

    method Save; mapped to Save(System.Configuration.ConfigurationSaveMode.Modified);
    method Clear;
    method &Remove(Key: String);
    property Keys: array of String read mapped.AppSettings.Settings.AllKeys;

    class method &Default: UserSettings;
  end;
  {$ELSEIF NOUGAT}
  UserSettings = public class mapped to Foundation.NSUserDefaults
  private
    method Exists(Key: String): Boolean;
    method GetKeys: array of String;
  public
    method ReadString(Key: String; DefaultValue: String): String;
    method ReadInteger(Key: String; DefaultValue: Integer): Integer;
    method ReadBoolean(Key: String; DefaultValue: Boolean): Boolean;
    method ReadDouble(Key: String; DefaultValue: Double): Double;

    method WriteString(Key: String; Value: String); mapped to setObject(Value) forKey(Key);
    method WriteInteger(Key: String; Value: Integer); mapped to setInteger(Value) forKey(Key);
    method WriteBoolean(Key: String; Value: Boolean); mapped to setBool(Value) forKey(Key);
    method WriteDouble(Key: String; Value: Double); mapped to setDouble(Value) forKey(Key);

    method Save; mapped to synchronize;
    method Clear; mapped to removePersistentDomainForName(Foundation.NSBundle.mainBundle.bundleIdentifier);
    method &Remove(Key: String); mapped to removeObjectForKey(Key);
    property Keys: array of String read GetKeys;

    class method &Default: UserSettings; mapped to standardUserDefaults;
  end;
  {$ENDIF}

implementation

{$IF ECHOES}
method UserSettings.ReadString(Key: String; DefaultValue: String): String;
begin
  if mapped.AppSettings.Settings[Key] = nil then
    exit DefaultValue;

  exit mapped.AppSettings.Settings[Key].Value;
end;

method UserSettings.ReadInteger(Key: String; DefaultValue: Integer): Integer;
begin
  if not Integer.TryParse(mapped.AppSettings.Settings[Key]:Value, out Result) then
    exit DefaultValue;
end;

method UserSettings.ReadBoolean(Key: String; DefaultValue: Boolean): Boolean;
begin
  if not Boolean.TryParse(mapped.AppSettings.Settings[Key]:Value, out Result) then
    exit DefaultValue;
end;

method UserSettings.ReadDouble(Key: String; DefaultValue: Double): Double;
begin
  if not Double.TryParse(mapped.AppSettings.Settings[Key]:Value, out Result) then
    exit DefaultValue;
end;

method UserSettings.WriteString(Key: String; Value: String);
begin
  mapped.AppSettings.Settings.Add(Key, Value);
end;

method UserSettings.WriteInteger(Key: String; Value: Integer);
begin
  WriteString(Key, Value.ToString);
end;

method UserSettings.WriteBoolean(Key: String; Value: Boolean);
begin
  WriteString(Key, Value.ToString);
end;

method UserSettings.WriteDouble(Key: String; Value: Double);
begin
  WriteString(Key, Value.ToString);
end;

method UserSettings.Clear;
begin
  mapped.AppSettings.Settings.Clear;
end;

method UserSettings.Remove(Key: String);
begin
  mapped.AppSettings.Settings.Remove(Key);
end;

class method UserSettings.&Default: UserSettings;
begin
  exit System.Configuration.ConfigurationManager.OpenExeConfiguration(System.Configuration.ConfigurationUserLevel.None);
end;
{$ELSEIF NOUGAT}
method UserSettings.Exists(Key: String): Boolean;
begin
  exit mapped.objectForKey(Key) <> nil;
end;

method UserSettings.ReadString(Key: String; DefaultValue: String): String;
begin
  //result := iif(Exists(Key), mapped.stringForKey(Key), DefaultValue);
  if Exists(Key) then
    exit mapped.stringForKey(Key)
  else
    exit DefaultValue;
end;

method UserSettings.ReadInteger(Key: String; DefaultValue: Integer): Integer;
begin
  result := iif(Exists(Key), mapped.integerForKey(Key), DefaultValue);
end;

method UserSettings.ReadBoolean(Key: String; DefaultValue: Boolean): Boolean;
begin
  result := iif(Exists(Key), mapped.boolForKey(Key), DefaultValue);
end;

method UserSettings.ReadDouble(Key: String; DefaultValue: Double): Double;
begin
  result := iif(Exists(Key), mapped.doubleForKey(Key), DefaultValue);
end;

method UserSettings.GetKeys: array of String;
begin
  var lValues := mapped.dictionaryRepresentation.allKeys;
  result := new String[lValues.count];
  for i: Integer := 0 to lValues.count - 1 do
    result[i] := lValues.objectAtIndex(i);
end;
{$ENDIF}

end.