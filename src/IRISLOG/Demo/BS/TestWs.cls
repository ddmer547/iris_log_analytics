Class IRISLOG.Demo.BS.TestWs Extends EnsLib.SOAP.Service
{

Parameter ADAPTER;

/// Name of the WebService
Parameter SERVICENAME = "TestWs";

/// TODO: Change this to actual network address
/// URL for invoking the WebService
/// Parameter LOCATION = "http://127.0.0.1:8972/csp/ensemble";
/// TODO: Change this to actual SOAP namespace
/// SOAP namespace for the WebService
Parameter NAMESPACE = "http://tempuri.org";

Method Sample(pInput As %String) As %Status [ WebMethod ]
{
	$$$LOGINFO(pInput)
	Set req = ##class(Ens.StringRequest).%New()
	Set req.StringValue = pInput
	Set tSC=..ProcessInput(req,.tResponse,"Sample")
	If $$$ISERR(tSC) Do ..ReturnMethodStatusFault(tSC)
	Quit tResponse
}

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject, ByRef pHint As %String) As %Status
{
	Set tSC=..SendRequestSync("IRISLOG.Demo.BO.HLHTSyncResp",pInput,.pOutput)
	Quit tSC
}

}
