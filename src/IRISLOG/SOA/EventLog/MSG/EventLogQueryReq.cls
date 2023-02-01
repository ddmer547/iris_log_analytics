Class IRISLOG.SOA.EventLog.MSG.EventLogQueryReq Extends (%Persistent, %JSON.Adaptor)
{

/// ID
Property ID As %String;

/// 类型
Property Type As %String;

/// 错误详情
Property Text As %String;

/// 记录时间
Property TimeLogged As %String;

/// 当前页码
Property Page As %Integer;

/// 每页显示最大条数
Property Rows As %Integer;

/// 时间下限
Property StartTime As %String;

/// 时间上限
Property EndTime As %String;

/// 会话ID
Property SessionID As %String;

/// 组件名称
Property ConfigName As %String;

Storage Default
{
<Data name="EventLogQueryReqDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ID</Value>
</Value>
<Value name="3">
<Value>Type</Value>
</Value>
<Value name="4">
<Value>Text</Value>
</Value>
<Value name="5">
<Value>TimeLogged</Value>
</Value>
<Value name="6">
<Value>Page</Value>
</Value>
<Value name="7">
<Value>Rows</Value>
</Value>
<Value name="8">
<Value>StartTime</Value>
</Value>
<Value name="9">
<Value>EndTime</Value>
</Value>
<Value name="10">
<Value>SessionID</Value>
</Value>
<Value name="11">
<Value>ConfigName</Value>
</Value>
</Data>
<DataLocation>^IRISLOG.SO9F58.EventLogQue6313D</DataLocation>
<DefaultData>EventLogQueryReqDefaultData</DefaultData>
<IdLocation>^IRISLOG.SO9F58.EventLogQue6313D</IdLocation>
<IndexLocation>^IRISLOG.SO9F58.EventLogQue6313I</IndexLocation>
<StreamLocation>^IRISLOG.SO9F58.EventLogQue6313S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
