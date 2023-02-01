Class IRISLOG.SOA.EventLog.MSG.EventLogRespData Extends (%SerialObject, %XML.Adaptor, %JSON.Adaptor)
{

/// XMLNAME
Parameter XMLNAME = "Data";

/// ID 
Property ID As %Integer;

/// 事件类型
Property Type As %String;

Property ConfigName As %String;

/// 会话ID
Property SessionID As %String;

/// 文本/记录内容
Property Text As %String(MAXLEN = "");

/// 记录时间
Property TimeLogged As %String(MAXLEN = 200);

/// 方法
Property SourceMethod As %String(MAXLEN = 200);

/// 代码类
Property SourceClass As %String(MAXLEN = 300);

Storage Default
{
<Data name="EventLogRespDataState">
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>Type</Value>
</Value>
<Value name="3">
<Value>ConfigName</Value>
</Value>
<Value name="4">
<Value>SessionID</Value>
</Value>
<Value name="5">
<Value>Text</Value>
</Value>
<Value name="6">
<Value>TimeLogged</Value>
</Value>
<Value name="7">
<Value>SourceMethod</Value>
</Value>
<Value name="8">
<Value>SourceClass</Value>
</Value>
</Data>
<State>EventLogRespDataState</State>
<StreamLocation>^IRISLOG.SO9F58.EventLogResBEC9S</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
