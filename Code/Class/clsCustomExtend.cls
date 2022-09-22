VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ZLCE"
Attribute VB_GlobalNameSpace = True
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'�汾: 1.0.6
'ʱ��:  2022.08.23
'����:  wds.�����
'A.�޸��漰:
'ZLCE_GetJsonByDictionary �����ж�: objType = "Variant()"
'ZLCE_GetXMLsByDictionary �����ж�: objType = "Variant()"
'ZLCE_StringAppend ���ӿ�ѡ����:  IsSideAddSplitStr  , checkSame, Ĭ��ΪFasle
 
'B.�����漰:
'TrimLeft  TrimRight TrimEdge XML_SetKeyValue

'�汾: 1.0.7
'ʱ��:  2022.08.31
'����:  wds.�����
'����:GetCustomSetting

'1.08
'ʱ��:  2022.08.31
'����:  wds.�����
'HttpRequest   DateGetUnixTimeStamp Exec_DBPro  ArrayGetStrCount


Private gSysName As String

'Http��������
Public Enum HttpRequestType
    HttpRequestType_XML = 0
    HttpRequestType_Text = 1
    HttpRequestType_Body = 2
    HttpRequestType_BodyText = 3
End Enum


'���󷵻ص�������ʽ
Public Enum HttpResponseType
    HttpResXML = 0
    HttpResText = 1
    HttpResBody = 2
End Enum


'��������
Public Property Let SysName(ByVal asysName As String)
    gSysName = asysName
    ZLCE_SysName = asysName
End Property
'
Public Property Get SysName() As String
    SysName = gSysName
End Property


'-------------------------------------ZLmdlDBSetting-------------------------------------
Public Function GetPluginSetting(ByVal execKey As String, Optional fetchColumn As String = "����", Optional fetchTable As String = "ZLPlugin���ñ�") As String
      GetPluginSetting = ZLCE_GetPluginSetting(execKey, fetchColumn, fetchTable)
End Function
'
Public Function GetCustomSetting(ByVal tableName As String, ByVal whereColumnName As String, ByVal whereColumnValue As String, ByVal getColumn As String) As String
    GetCustomSetting = ZLCE_GetCustomSetting(tableName, whereColumnName, whereColumnValue, getColumn)
End Function
'
Public Function GetExecSQL(execKey As String, Optional fetchColumn As String = "����", Optional fetchTable As String = "ZLPLUGINSQL��ѯ��") As String
     GetExecSQL = ZLCE_GetExecSQL(execKey, fetchColumn, fetchTable)
End Function
'-------------------------------------ZLmdlDBSetting-------------------------------------


'-------------------------------------ZLmdlINI-------------------------------------
Public Function INI_GetValue(ByVal filename As String, ByVal AppName As String, ByVal KeyName As String) As String
    INI_GetValue = ZLCE_GetINI(filename, AppName, KeyName)
End Function
'
Public Function INI_SetValue(ByVal filename As String, ByVal AppName As String, ByVal KeyName As String, ByVal Entry As String) As Boolean
    INI_SetValue = ZLCE_SetINI(filename, AppName, KeyName, Entry) <> 0
End Function

'-------------------------------------ZLmdlINI-------------------------------------

'-------------------------------------ZLmdlLog-------------------------------------
'
Public Function Log_Write(ByVal strLogPath As String, ByVal strFunc As String, Optional ByVal strInput As String = "", Optional ByVal strOutPut As String = "") As Boolean
    '���ܣ���¼��־�ļ�����Ҫ���ڽӿڵ���
    Log_Write = ZLCE_WriteLog(strLogPath, strFunc, CurrentDateTime, strInput, strOutPut)
End Function
'
Public Function Log_Set�༶Ŀ¼(ByVal str�ļ�·�� As String) As Boolean
    Log_Set�༶Ŀ¼ = ZLCE_Set�༶Ŀ¼(str�ļ�·��)
End Function

'
Public Function Log_GetFullPath(ByVal strPath As String) As String
    Log_GetFullPath = ZLCE_GetFullPath(strPath)
End Function
'
Public Function Log_AppendPath(ByVal strPath As String, ByVal strAppend As String) As String
    Log_AppendPath = ZLCE_AppendPath(strPath, strAppend)
End Function
'-------------------------------------ZLmdlLog-------------------------------------

'-------------------------------------ZLMdlPublic-------------------------------------
Public Function GetComputerName() As String
'=ȡ�ü������
    GetComputerName = ZLCE_GetComputerName
End Function
 
'
Function GetComputerIP() As String
'ȡ�ü����IP��ַ
    GetComputerIP = ZLCE_GetComputerIP
End Function

'-------------------------------------GObj-------------------------------------
Public Function CurrentDateTime(Optional ByVal timeStyle As String = "yyyy-MM-dd HH:mm:ss") As String
    CurrentDateTime = Format(Now, "yyyy-MM-dd HH:mm:ss")
End Function
  
'-------------------------------------GObj-------------------------------------

'������ݼ��Ƿ��м�¼
Function ChkRsState(rs As ADODB.Recordset) As Boolean
    ChkRsState = ZLCE_ChkRsState(rs)
End Function
'
Public Function RsValue(ByVal rs As ADODB.Recordset, field As String) As String
'==================================================================================================
'=���ܣ���ȡ�ֶ���ֵ
'=���ã��������ȡ��¼���ֶ�ֵʱ
'=���ߣ������}
'=ʱ�䣺2021-04-16
'=��Σ�
'=  rs ADO�����
'=  key �ֶ�����
'==================================================================================================
 RsValue = ZLCE_RsValue(rs, field)
End Function

'-----------------------------------------------SQL---------------------------------------------------
 
'
Public Function Exec_DBAction( _
                ByVal gcnObj As ADODB.Connection, _
                ByVal execPro_Name As String, _
                ByVal execPro_InName As String, ByVal execPro_OutName As String, _
                             ByVal XmlStr_In As String, ByRef XmlStr_Out As String, _
                             Optional execPro_OutCode As String = "Res/Code", Optional execPro_OutMsg As String = "Res/Msg") As Boolean
        Exec_DBAction = ZLCE_DBAction(gcnObj, execPro_Name, execPro_InName, execPro_OutName, XmlStr_In, XmlStr_Out, execPro_OutCode, execPro_OutMsg)
End Function
'

'����ʵ�ֶ�ִ�����ݿ����SQL
Public Function Exec_DBPro(ByVal gcnObj As ADODB.Connection, ByVal proName As String, _
                        ByRef inputKeys() As String, ByRef inputValues() As String, _
                        ByVal outputKey As String, ByRef outputValue As String, _
                        Optional outCode As String = "Res/Code", Optional outMsg As String = "Res/Msg") As Boolean
    Exec_DBPro = ZLCE_DBProExec(gcnObj, proName, inputKeys, inputValues, outputKey, outputValue, outCode, outMsg)
End Function
 
'--------------------------------------------String-------------------------------------------------------
'
Public Function Split(mStr As String, splitChar As String, index As Integer) As String
'���ַ����и�,��ȡָ��λ�õ�����,�и�������ٴ�����
    Split = ZLCE_Split(mStr, splitChar, index)
End Function
'
Public Function SplitIndex(ByVal str As String, ByVal SplitStr As String, ByVal index As Integer) As String
'���ַ����и�,��ȡָ��λ�õ�����,ֱ�ӽ�ȡ���Ӹ�Ч
    SplitIndex = ZLCE_SplitIndex(str, SplitStr, index)
End Function

'
Public Function strAppend(ByRef mainStr As String, ByVal SplitStr As String, ByVal appendStr As String, Optional ByVal IsCheckNull As Boolean = False, _
                            Optional ByVal IsTrim As Boolean = False, Optional ByVal IsSideAddSplitStr As Boolean = False, Optional ByVal checkSame As Boolean = False) As String
    strAppend = ZLCE_StringAppend(mainStr, SplitStr, appendStr, IsCheckNull, IsTrim, IsSideAddSplitStr, checkSame)
End Function
'
Public Function ReplaceParamString(ByVal mainStr As String, ParamArray Items()) As String
''����[1] [2] �����滻��Ϣ
''�����}
On Error GoTo ErrH
    Dim i
    Dim index As Integer, tmpStr As String
    
    tmpStr = mainStr
    '�������(ֱ���滻,�������������͵�����)
    For Each i In Items
        index = index + 1
        '        Select Case TypeName()
        '            Case "String", "String()"
        '            Case Else
        '        End Select
        tmpStr = Replace(tmpStr, "[" & index & "]", i)
    Next
    
    ''��ȡ�滻�ַ���
    ReplaceParamString = tmpStr
    Exit Function
ErrH:
    ReplaceParamString = mainStr
End Function
 
'Public Function GetXMLByDictionary(ByVal dict As Dictionary, Optional ByVal show���� As Boolean = True) As String
'����2022-05-06
''==================================================================================================
''=���ܣ���DictתΪString(ֻ��һ���Dict)
''=���ã�
''=��Σ�
''=  dict �ֵ�
''= ���Σ�
''= XML�����ַ���
'    GetXMLByDictionary = ZLCE_GetXMLByDictionary(dict, show����)
'End Function
'
Public Function GetXMLsByDictionary(ByVal dict As Dictionary, Optional ByVal show���� As Boolean = True) As String
'==================================================================================================
'=���ܣ���DictתΪString(����Dict����л�)
'=���ã�
'=��Σ�
'=  dict �ֵ�
'= ���Σ�
'= XML�����ַ���
    GetXMLsByDictionary = ZLCE_GetXMLsByDictionary(dict, show����)
End Function
'
''��ȡjson����
Public Function GetJSONValue(ByVal JSONString As String, ByVal JSONPath As String) As Variant
    GetJSONValue = ZLCE_JSONParse(JSONString, JSONPath)
End Function
'
Public Function GetJsonByDictionary(ByVal dict As Dictionary) As String
'==================================================================================================
'=���ܣ���DictתΪString
'=��Σ�
'=  dict �ֵ�
'= ���Σ�Json�����ַ���
    GetJsonByDictionary = ZLCE_GetJsonByDictionary(dict)
End Function

'
Public Function Lpad(ByVal strCode As String, lngLen As Long, Optional strChar As String = " ") As String
 '-----------------------------------------------------------------------------------------------------------
'--��  ��:��ָ���������ƿո�
'--�����:
'--������:
'--��  ��:�����ִ�
    Lpad = ZLCE_Lpad(strCode, lngLen, strChar)
End Function
'
Public Function Rpad(ByVal strCode As String, lngLen As Long, Optional strChar As String = " ") As String
'-----------------------------------------------------------------------------------------------------------
'--��  ��:��ָ���������ƿո�
'--�����:
'--������:
'--��  ��:�����ִ�
    Rpad = ZLCE_Rpad(strCode, lngLen, strChar)
End Function
'
Public Function SubString(ByVal strInfor As String, ByVal lngStart As Long, ByVal lngLen As Long) As String
'-----------------------------------------------------------------------------------------------------------
'--��  ��:��ȡָ���ִ���ֵ,�ִ��п��԰�������
'--�����:strInfor-ԭ��
'         lngStart-ֱʼλ��
'         lngLen-����
'--������:
'--��  ��:�Ӵ�
    SubString = ZLCE_SubString(strInfor, lngStart, lngLen)
End Function

'
Public Function Nvl(ByVal varValue As Variant, Optional DefaultValue As Variant = "") As Variant
'���ܣ��൱��Oracle��NVL����Nullֵ�ĳ�����һ��Ԥ��ֵ
    Nvl = ZLCE_Nvl(varValue, DefaultValue)
End Function
'
Public Function ToLower(ByRef Expression) As String
'==================================================================================================
'=���ܣ�StringתСд
'=���ã�String����
'=��Σ�
'=  Expression ����ʽ
'= ���Σ�
'= Сд�ַ���
'-------------------------
    ToLower = ZLCE_ToLower(Expression)
End Function

'
Public Function ToUpper(ByRef Expression) As String
'==================================================================================================
'=���ܣ�StringתСд
'=���ã�String����
'=��Σ�
'=  Expression ����ʽ
'= ���Σ�
'= Сд�ַ���
'-------------------------
    ToUpper = ZLCE_ToUpper(Expression)
End Function
'
Public Function ToStr(ByRef Expression) As String
'==================================
'=���ܣ�תString
'=���ã�String����
'=��Σ�
'=  Expression ����ʽ
'= ���Σ�
'= �ַ���
    ToStr = ZLCE_ToStr(Expression)
End Function
'
Public Function ToNum(ByRef Expression) As Double
'==================================
'=���ܣ�תNumber
'=���� Number����
'=��Σ�
'=  Expression ����ʽ
'= ���Σ�
'=  Number
    ToNum = ZLCE_ToNum(Expression)
End Function
'
Public Function StrFitChar(ByVal str As String, ByVal IsLeft As Boolean, fixLen As Long, fixChar As String) As String
'����: ����String
'LoR : �������Ҳ�
'fixLen :��Ҫ����ĳ���
'fixChar: ������ַ���ʲô
     StrFitChar = ZLCE_StrFitChar(str, IsLeft, fixLen, fixChar)
End Function
'
Public Function Decode(ParamArray arrPar() As Variant) As Variant
Rem ZLCE_Decode�ݲ�ʹ��
    Dim varValue As Variant, i As Integer
    '���ܣ�ģ��Oracle��Decode����
    i = 1
    varValue = arrPar(0)
    Do While i <= UBound(arrPar)
        If i = UBound(arrPar) Then
            Decode = arrPar(i): Exit Function
        ElseIf varValue = arrPar(i) Then
            Decode = arrPar(i + 1): Exit Function
        Else
            i = i + 2
        End If
    Loop
End Function

'
Public Function Trim(ByVal str As String) As String
'���ܣ�ȥ���ַ�����\0�Ժ���ַ�������ȥ�����˵Ŀո�
    Trim = ZLCE_Trim(str)
End Function

'
Public Function TrimLeft(ByVal mStr As String, Optional leftStr As String = " ") As String
    TrimLeft = ZLCE_TrimLeft(mStr, leftStr)
End Function
'
Public Function TrimRight(ByVal mStr As String, Optional rightStr As String = " ") As String
    TrimRight = ZLCE_TrimRight(mStr, rightStr)
End Function
'
Public Function TrimEdge(ByVal mStr As String, Optional sideStr As String = " ") As String
    TrimEdge = ZLCE_TrimEdge(mStr, sideStr)
End Function
 
 Public Function StrContains(ByVal mainStr As String, ByVal subStr As String, Optional ByVal SplitStr As String = ",") As Boolean
 '���ܣ��Ƿ�����ַ���
     StrContains = ZLCE_ContainSubStr(mainStr, subStr, SplitStr)
 End Function
'-----------------------------------------------------------XML-----------------------------------------------------------
'
Public Function XML_GetLoadXMLObj(ByVal strXML As String) As Object
    Set XML_GetLoadXMLObj = ZLCE_GetLoadXMLObj(strXML)
End Function
'
Public Function XML_GetElemnetValue(ByVal doc As Object, ByVal name As String, Optional ByVal itemIndex As Integer = 0, Optional ByVal IsOrion As Boolean = False) As String
'���ܣ��õ�ָ��Ԫ�ص�ֵ
  XML_GetElemnetValue = ZLCE_GetElemnetValue(doc, name, itemIndex, IsOrion)
End Function

'��XML��ֵ�ӿ�
Public Function XML_GetXMLNode(ByVal doc As Object, ByVal key As String) As String
    XML_GetXMLNode = ZLCE_GetElemnetValue(doc, key, 0, True)
End Function

Public Function XML_GetXMLStrNode(ByVal strXML As String, ByVal key As String) As String
'��XML��ֵ�ӿ�
    XML_GetXMLStrNode = ZLCE_GetXMLStrNode(strXML, key)
End Function

'
'��XML��ֵ�ӿ�
Public Function XML_GetXMLSingleNode(ByVal doc As Object, ByVal keyPath As String) As String
    XML_GetXMLSingleNode = ZLCE_GetXMLSingleNode(doc, keyPath)
End Function
'
Public Function XML_GetXMLStrSingleNode(ByVal strXML As String, ByVal keyPath As String) As String
'��XML��ֵ�ӿ�
    XML_GetXMLStrSingleNode = ZLCE_GetXMLStrSingleNode(strXML, keyPath)
End Function

'
Public Function XML_SetKeyValue(ByVal xmlStr As String, ByVal key As String, ByVal value As String, Optional index As Integer = 0) As String
    XML_SetKeyValue = ZLCE_XMLSetKeyValue(xmlStr, key, value, index)
End Function

'1.0.8New ��ȡ�ڵ�LIST���ݻ��� �ӽڵ�����
Public Function XML_GetNodeByListIndex(ByVal doc As Object, ByVal ListKey As String, ByRef valueArray() As String, Optional subListKey As String = "", Optional idx As Integer = -1) As String
    XML_GetNodeByListIndex = ZLCE_XMLGetNodeByListIndex(doc, ListKey, valueArray, subListKey, idx)
End Function
  
 '---------------------------------------------------------Array 1.0.4------------------------------------------------
 '
 Public Function GetArrayByIndex(ByRef arr() As String, ByVal index As Integer) As String
    GetArrayByIndex = ZLCE_Str_GetArrayByIndex(arr, index)
End Function
'
 Public Function ArrayGetEntryByIndex(ByRef arr() As Variant, ByVal index As Integer) As Variant
    ArrayGetEntryByIndex = ZLCE_GetArrayByIndex(arr, index)
End Function
'
Rem ��ȡ��Сindex
Public Function ArrayGetMinIndex(ByRef arr() As Variant) As Long
    ArrayGetMinIndex = ZLCE_GetArrayMinIndex(arr)
End Function
'
Rem ��ȡ���index
Public Function ArrayGetMaxIndex(ByRef arr() As Variant) As Long
    ArrayGetMaxIndex = ZLCE_GetArrayMaxIndex(arr)
End Function
'
Rem ��ȡCount
Public Function ArrayGetCount(ByRef arr() As Variant) As Long
    ArrayGetCount = ZLCE_GetArrayCount(arr)
End Function

Rem 1.0.8
Public Function ArrayGetStrCount(ByRef arr() As String) As Long
   ArrayGetStrCount = ZLCE_GetStrArrayCount(arr)
End Function

'1.0.8New
Public Function ArrayInsertStrIndex(ByRef arr() As String, ByVal str As String, Optional index As Integer = -1) As Boolean
    ArrayInsertStrIndex = ZLCE_Str_ArrayInsertIndex(arr, str, index)
End Function

'1.0.8New
Public Function ArrayInsertIndex(ByRef arr() As Variant, ByVal var As Variant, Optional index As Integer = -1) As Boolean
    ArrayInsertIndex = ZLCE_ArrayInsertIndex(arr, var, index)
End Function
 
'---------------------------------------------------------Date 1.0.8----------------------------------------------------
Rem Date
Public Function DateGetUnixTimeStamp(ByVal strDate As String, Optional isMillis As Boolean = False) As String
    DateGetUnixTimeStamp = ZLCE_DateGetUnixTimeStamp(strDate, isMillis)
End Function
'---------------------------------------------------------Http 1.0.8----------------------------------------------------
Public Function HttpRequest(ByVal reqURL As String, ByVal reqContent As String, ByVal httpReqType As HttpRequestType, _
                                                                                    Optional Method As String = "POST", Optional reqHeaderKeyValues As Dictionary = Nothing) As String
    HttpRequest = ZLCE_XMLHTTPRequest(reqURL, reqContent, httpReqType, Method, reqHeaderKeyValues)
End Function