Class IRISLOG.Demo.BO.HLHTSyncResp Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SOAP.OutboundAdapter";

Property Adapter As EnsLib.SOAP.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method ReturnSuccess(pRequest As Ens.StringRequest, Output pResponse As EnsLib.EDI.XML.Document) As %Status
{
	Set tSC = $$$OK
	Set pResponse=##class(EnsLib.EDI.XML.Document).%New()
	Set xdataID="IRISLOG.Demo.BO.HLHTSyncResp||HL7V3Response"
    Set compiledXdata=##class(%Dictionary.CompiledXData).%OpenId(xdataID)
    Set tStream=compiledXdata.Data
    If '$IsObject(tStream) Set tSC=%objlasterror Quit
	Set pResponse = pResponse.ImportFromLibraryStream(tStream,.tSC)
	Quit $$$OK
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StringRequest"> 
		<Method>ReturnSuccess</Method>
	</MapItem>
</MapItems>
}

XData HL7V3Response
{
<MCCI_IN000002UV01 ITSVersion="XML_1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3" xsi:schemaLocation="urn:hl7-org:v3 ../multicacheschemas/MCCI_IN000002UV01.xsd">
	<id root="2.16.156.10011.2.5.1.1" extension="9070E693CAE04D00A35946E23015027E"/>
	<creationTime value="20170106151903"/>
	<interactionId root="2.16.156.10011.2.5.1.2" extension="MCCI_IN000002UV01"/>
	<processingCode code="P"/>
	<processingModeCode/>
	<acceptAckCode code="AL"/>
	<receiver typeCode="RCV">
		<device classCode="DEV" determinerCode="INSTANCE">
			<id>
				<item root="2.16.156.10011.2.5.1.3" extension="BKIP"/>
			</id>
		</device>
	</receiver>
	<sender typeCode="SND">
		<device classCode="DEV" determinerCode="INSTANCE">
			<id>
				<item root="2.16.156.10011.2.5.1.3" extension="HIS"/>
			</id>
		</device>
	</sender>
	<acknowledgement typeCode="AA">
		<!--请求消息ID-->
		<targetMessage>
			<id root="2.16.156.10011.2.5.1.1" extension="630D96C7AAF942DFBAF67C6929986740"/>
		</targetMessage>
		<acknowledgementDetail>
			<text value="消息处理成功"/>
		</acknowledgementDetail>
	</acknowledgement>
</MCCI_IN000002UV01>
}

}
