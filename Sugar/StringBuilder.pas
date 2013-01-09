﻿namespace RemObjects.Oxygene.Sugar;
{$HIDE W0} //supress case-mismatch errors
interface

type

  {$IF COOPER}
  StringBuilder = public class mapped to java.lang.StringBuilder
  public
    method Append(value: String): StringBuilder; mapped to append(value);
    method Append(value: String; startIndex, count: Integer): StringBuilder; mapped to append(value, startIndex, count);
    method Append(value: Char; repeatCount: Integer): StringBuilder;
    method AppendLine(): StringBuilder;
    method AppendLine(value: String): StringBuilder;

    method Clear; mapped to setLength(0);
    method Delete(Start, &End: Integer): StringBuilder; mapped to delete(Start, &End);
    method Replace(Start, &End: Integer; Value: String): StringBuilder; mapped to Replace(Start, &End, Value);
    method Substring(Start: Integer): String; mapped to substring(Start);
    method Substring(Start, &End: Integer): String; mapped to substring(Start, &End);
    method Insert(Offset: Integer; Value: String): StringBuilder; mapped to Insert(Offset, Value);

    property Length: Integer read mapped.length;
  {$ELSEIF ECHOES}
  StringBuilder = public class mapped to System.Text.StringBuilder
  public
    method Append(value: String): StringBuilder; mapped to Append(value);
    method Append(value: String; startIndex, count: Integer): StringBuilder; mapped to Append(value, startIndex, count);
    method Append(value: Char; repeatCount: Integer): StringBuilder; mapped to Append(value, repeatCount);
    method AppendLine(): StringBuilder; mapped to AppendLine();
    method AppendLine(value: String): StringBuilder; mapped to AppendLine(value);

    method Clear;
    method Delete(Start, &End: Integer): StringBuilder; mapped to &Remove(Start, &End);
    method Replace(Start, &End: Integer; Value: String): StringBuilder;
    method Substring(Start: Integer): String; mapped to ToString(Start, Length);
    method Substring(Start, &End: Integer): String; mapped to ToString(Start, &End);
    method Insert(Offset: Integer; Value: String): StringBuilder; mapped to Insert(Offset, Value);

    property Length: Integer read mapped.Length;
  {$ELSEIF NOUGAT}
  StringBuilder = public class mapped to Foundation.NSMutableString
  public
    method Append(value: String): StringBuilder;
    method Append(value: String; startIndex, count: Integer): StringBuilder;
    method Append(value: Char; repeatCount: Integer): StringBuilder;
    method AppendLine(): StringBuilder; 
    method AppendLine(value: String): StringBuilder; 
    method ToString(): String;
  {$ENDIF}
  end;

implementation

{$IF COOPER}
method StringBuilder.Append(value: Char; repeatCount: Integer): StringBuilder;
begin
  for i: Int32 := 1 to repeatCount do mapped.append(value);
  exit mapped;
end;

method StringBuilder.AppendLine(): StringBuilder;
begin
  mapped.append(Environment.NewLine);
  exit mapped;
end;

method StringBuilder.AppendLine(value: String): StringBuilder;
begin
  mapped.append(value);
  mapped.append(Environment.NewLine);
  exit mapped;
end;
{$ELSEIF ECHOES}
method StringBuilder.Clear;
begin
  mapped.Length := 0;
end;

method StringBuilder.Replace(Start: Integer; &End: Integer; Value: String): StringBuilder;
begin
  mapped.Remove(Start, &End);
  exit mapped.Insert(Start, Value);
end;
{$ELSEIF NOUGAT}
method StringBuilder.Append(value: String): StringBuilder;
begin
  mapped.appendString(value);
  exit mapped;
end;

method StringBuilder.Append(value: Char; repeatCount: Integer): StringBuilder;
begin
  for i: Int32 := 1 to repeatCount do
    mapped.appendString(value);
  exit mapped;
end;

method StringBuilder.Append(value: String; startIndex: Integer; count: Integer): StringBuilder;
begin
  //Append(value.Substring(startIndex, count)); // 59477: Nougat: Compiler NRE on nested mapped call
  mapped.appendString(value.Substring(startIndex, count));
  exit mapped;
end;

method StringBuilder.AppendLine(): StringBuilder;
begin
  mapped.appendString(Environment.NewLine);
  exit mapped;
end;

method StringBuilder.AppendLine(value: String): StringBuilder;
begin
  mapped.appendString(value);
  mapped.appendString(Environment.NewLine);
  exit mapped;
end;

method StringBuilder.ToString(): String;
begin
  exit Foundation.NSString.stringWithString(mapped);
end;
{$ENDIF}

end.
