﻿<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0">
  <PropertyGroup>
    <RootNamespace>Sugar.Nougat.OSX.Test</RootNamespace>
    <ProjectGuid>{e05279de-3031-4a1d-8c31-ff14ba511f66}</ProjectGuid>
    <OutputType>Executable</OutputType>
    <AssemblyName>SugarTest</AssemblyName>
    <AllowGlobals>False</AllowGlobals>
    <AllowLegacyWith>False</AllowLegacyWith>
    <AllowLegacyOutParams>False</AllowLegacyOutParams>
    <AllowLegacyCreate>False</AllowLegacyCreate>
    <AllowUnsafeCode>False</AllowUnsafeCode>
    <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
    <SDK>OS X</SDK>
    <EntitlementsFile>Entitlements.entitlements</EntitlementsFile>
    <DeploymentTargetVersion>10.11</DeploymentTargetVersion>
    <Name>Sugar.Nougat.OSX.Test</Name>
    <DefaultUses>Foundation</DefaultUses>
    <StartupClass />
    <CreateHeaderFile>False</CreateHeaderFile>
    <BundleExtension />
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
    <Optimize>False</Optimize>
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE;</DefineConstants>
    <CaptureConsoleOutput>False</CaptureConsoleOutput>
    <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
    <Optimize>true</Optimize>
    <OutputPath>.\bin\Release</OutputPath>
    <GenerateDebugInfo>False</GenerateDebugInfo>
    <EnableAsserts>False</EnableAsserts>
    <TreatWarningsAsErrors>False</TreatWarningsAsErrors>
    <CaptureConsoleOutput>False</CaptureConsoleOutput>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="Foundation.fx" />
    <Reference Include="libEUnit.fx" />
    <Reference Include="libNougat.fx" />
    <Reference Include="libsqlite3.fx">
      <HintPath>C:\Program Files (x86)\RemObjects Software\Elements\Nougat\Libraries\libsqlite3\OS X\libsqlite3.fx</HintPath>
    </Reference>
    <Reference Include="libxml2.fx" />
    <Reference Include="rtl.fx" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="Main\OSX\Program.pas" />
    <None Include="Entitlements.entitlements" />
  </ItemGroup>
  <ItemGroup>
    <Folder Include="Main\" />
    <Folder Include="Main\OSX\" />
    <Folder Include="Properties\" />
  </ItemGroup>
  <ItemGroup>
    <ProjectReference Include="..\Sugar.Data\Sugar.Data.Nougat.OSX.oxygene">
      <Name>Sugar.Data.Nougat.OSX</Name>
      <Project>{0d5b253d-762b-42d9-bfd2-3c217e07cf52}</Project>
      <Private>True</Private>
      <HintPath>..\Sugar.Data\bin\OS X\libSugar.Data.fx</HintPath>
    </ProjectReference>
    <ProjectReference Include="..\Sugar\Sugar.Nougat.OSX.oxygene">
      <Name>Sugar.Nougat.OSX</Name>
      <Project>{ab7ab88b-2370-43bf-844b-54d015da9e57}</Project>
      <Private>True</Private>
      <HintPath>..\Sugar\bin\OS X\libSugar.fx</HintPath>
    </ProjectReference>
  </ItemGroup>
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Oxygene\RemObjects.Oxygene.Nougat.targets" />
  <PropertyGroup>
    <PreBuildEvent />
  </PropertyGroup>
  <Import Project="..\Sugar.Tests\Sugar.Shared.Test.projitems" Label="Shared" />
</Project>