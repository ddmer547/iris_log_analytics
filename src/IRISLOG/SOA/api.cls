Class IRISLOG.SOA.api Extends IRISLOG.SOA.EventLog.rest
{

Parameter SpecificationClass = "petstore.spec";

/// 此应用程序的默认内容类型。
Parameter CONTENTTYPE = "application/json";

/// 默认情况下，将输入流转换为Unicode
Parameter CONVERTINPUTSTREAM = 1;

Parameter HandleCorsRequest = 1;

/// 默认响应字符集是utf-8
Parameter CHARSET = "utf-8";

XData UrlMap
{
<Routes>

<!--事件日志 -->
<Route Url="/GetEventLog" Method="POST" Call="GetEventLog"/>
<Route Url="/GetEventTypeNum" Method="POST" Call="GetEventTypeNum"/>
<Route Url="/GetConfigEventNum" Method="POST" Call="GetConfigEventNum"/>
<Route Url="/Get7DaysEventNum" Method="POST" Call="Get7DaysEventNum"/>

</Routes>
}

}
