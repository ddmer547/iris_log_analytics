Class IRISLOG.SOA.EventLog.MSG.EventLogQueryResp Extends (Ens.Response, %JSON.Adaptor)
{

/// XMLNAME
Parameter XMLNAME = "Response";

/// 状态码 
Property Code As %Integer;

/// 消息信息 
Property Msg As %String(MAXLEN = 300);

/// 条数
Property Total As %Integer;

/// 数据
Property Data As list Of IRISLOG.SOA.EventLog.MSG.EventLogRespData;

Storage Default
{
<Data name="EventLogQueryRespDefaultData">
<Subscript>"EventLogQueryResp"</Subscript>
<Value name="1">
<Value>Code</Value>
</Value>
<Value name="2">
<Value>Msg</Value>
</Value>
<Value name="3">
<Value>Total</Value>
</Value>
<Value name="4">
<Value>Data</Value>
</Value>
</Data>
<DefaultData>EventLogQueryRespDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
