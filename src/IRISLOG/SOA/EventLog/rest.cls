Class IRISLOG.SOA.EventLog.rest Extends %CSP.REST
{

Parameter SpecificationClass = "petstore.spec";

/// 此应用程序的默认内容类型。
Parameter CONTENTTYPE = "application/json";

/// 默认情况下，将输入流转换为Unicode
Parameter CONVERTINPUTSTREAM = 1;

/// 默认响应字符集是utf-8
Parameter CHARSET = "utf-8";

/*
{
    "ID": "",
    "Type": "",
    "Text": "",
    "TimeLogged": "",
    "Page": 1,
    "Rows": 100,
    "StartTime": "2023-01-29 00:00:00",
    "EndTime": "2023-01-31 23:59:59",
    "SessionID": "",
    "ConfigName": ""
}
*/
/// 事件日志查询
ClassMethod GetEventLog() As %Status
{
	    Set req = ##class(IRISLOG.SOA.EventLog.MSG.EventLogQueryReq).%New()
  		Set data = %request.Content
  		Try {
   			 $$$TOE(tSC,req.%JSONImport(data))
  			}
  		Catch errObj {
     		Do ##class(IRISLOG.SOA.utils.baseresp).failResp("入参不合法")
     		Return $$$OK
  		}
 		Do $SYSTEM.SQL.SetSelectMode(1)
        #;确定入参查询字段 入参转字符串
        Set p = req.Page
        Set r = req.Rows
        Set Type = ##class(%String).LogicalToDisplay(req.Type)
        Set Text = ##class(%String).LogicalToDisplay(req.Text)
        Set TimeLogged = ##class(%String).LogicalToDisplay(req.TimeLogged)
        Set StartTime = ##class(%String).LogicalToDisplay(req.StartTime)
        Set EndTime = ##class(%String).LogicalToDisplay(req.EndTime)
        Set SessionID = ##class(%String).LogicalToDisplay(req.SessionID)
        Set ConfigName = ##class(%String).LogicalToDisplay(req.ConfigName)
        
        #;分页-最后一页
        Set maxPage = p*r 
        #;分页-第一页
        Set minPage = (p-1)*r +1
        #;拼出查询SQL
        Set strSql = " SELECT TOP 10000000"
        Set strSql = strSql_" s.ID ,"
        Set strSql = strSql_" s.Type ,"
        Set strSql = strSql_" s.ConfigName ,"
        Set strSql = strSql_" s.SessionID ,"
        Set strSql = strSql_" s.Text ,"
        Set strSql = strSql_" s.TimeLogged ,"
        Set strSql = strSql_" s.SourceMethod ,"
        Set strSql = strSql_" s.SourceClass "
        Set strSql = strSql_" From Ens_Util.Log s where 1=1"
        #;拼出SQL条件语句
        If $LENGTH(Type) '= 0 {    
        	Set strSql = strSql_" AND s.Type in ("_Type_")"
        }
        If $LENGTH(ConfigName) '= 0 {
        	Set strSql = strSql_" AND s.ConfigName = '"_ConfigName_"'"
        }
        If $LENGTH(SessionID) '= 0 {
        	Set strSql = strSql_" AND s.SessionID = '"_SessionID_"'"
        }
        If $LENGTH(Text) '= 0 {
        	Set strSql = strSql_" AND CHARINDEX('"_Text_"',s.Text)>0"
        }
        If $LENGTH(StartTime) '= 0 {
	        Set StartTime = $zdatetimeh(StartTime,3,1)
        	Set StartTime = $zdatetime(StartTime,3,1)_".000"	
        	Set strSql = strSql_" AND s.TimeLogged > '"_StartTime_"'"
        }
        If $LENGTH(EndTime) '= 0 {	
        	Set EndTime = $zdatetimeh(EndTime,3,1)
        	Set EndTime = $zdatetime(EndTime,3,1)_".999"
        	Set strSql = strSql_" AND s.TimeLogged < '"_EndTime_"'"
        } 
        Set strSql = strSql_" ORDER BY s.TimeLogged DESC"
		#;w strSql,!
        #;初始化返回消息内容
        Set Response = {}
        Set Response.Code = 200
        Set Response.Msg = "成功"
        Set Response.Total = 0
        #;计算查询数目
        Set countSQL = "select count(*) as total from ( "_strSql_" )"
        Set countRs = ##class(%SQL.Statement).%ExecDirect(,countSQL)
        If countRs.%Next(){
            Set Response.Total = countRs.%Get("total")
        }
        If (Response.Total = 0){
            Set Response.Code = 200
            Set Response.Msg = "成功"
            Set Response.Total = 0
        }Else{
            #;将SQL执行的结果赋值给rs并作相应判断
            Set setSql = "SELECT *,%VID from("_strSql_" )where %VID BETWEEN "_minPage_" AND "_maxPage_""
            Set rs = ##class(%SQL.Statement).%ExecDirect(,setSql)
            Set Data = []
            While rs.%Next() {
	            Do Data.%Push({
		            "ID":             (rs.%Get("ID")),
		            "Type":             (rs.%Get("Type")),
		            "ConfigName":             (rs.%Get("ConfigName")),
		            "SessionID":             (rs.%Get("SessionID")),
		            "Text":             (rs.%Get("Text")),
		            "TimeLogged":             (rs.%Get("TimeLogged")),
		            "SourceMethod":             (rs.%Get("SourceMethod")),
		            "SourceClass":             (rs.%Get("SourceClass"))
		           }) 
            }
            #;判断是否有数据，并作相应判断，并将返回结果转换成Json输出
            If rs.%ROWCOUNT =0{
        		Do ##class(IRISLOG.SOA.utils.baseresp).failResp("没有数据")
      		}Else{
        		Set Response.Data = Data
       		 Write Response.%ToJSON()
      		}
        }  

    Return $$$OK
}

/*
{
  "startTime": "2023-01-24 00:00:00",
  "endTime": "2023-01-31 23:59:59"
}
*/
/// 事件日志-统计事件类型数量
ClassMethod GetEventTypeNum() As %Status
{

  Set data = %request.Content
  Set obj = ##class(%DynamicObject).%FromJSON(data)
  Set startTime = obj.startTime
  Set endTime = obj.endTime
#;  Set startTime = $zdt($h-7,3)_" 00:00:00"
#;  Set endTime = $zdt($h,3)

  Set startTime = ##class(%String).LogicalToDisplay(startTime)
  Set endTime = ##class(%String).LogicalToDisplay(endTime)
  
  Set strSql = "select t.Type,count(*) as Num From Ens_Util.Log t where 1=1 "
            _" and {fn RIGHT(%EXTERNAL(t.TimeLogged),999)} > '"_startTime_"'"
            _" and {fn RIGHT(%EXTERNAL(t.TimeLogged),999)} < '"_endTime_"' group by t.Type" 
  
  Set Response = {}
  #;w strSql
  Set rs = ##class(%SQL.Statement).%ExecDirect(,strSql)
  If (rs.%SQLCODE<0) {
      Do ##class(IRISLOG.SOA.utils.baseresp).failResp("sql出错")
	    Return $$$OK
  }Else{
	   Set Response.status = 200
       Set Response.msg = "success"
       Set data = []
      	While rs.%Next() {
	            Do data.%Push({
		            "Type":             (rs.%Get("Type")),
		            "Num":             (rs.%Get("Num"))
		           }) 
            }
            #;判断是否有数据，并作相应判断，并将返回结果转换成Json输出
            If rs.%ROWCOUNT =0{
        		Do ##class(IRISLOG.SOA.utils.baseresp).failResp("没有数据")
      		}Else{
        		Set Response.data = data
       		 Write Response.%ToJSON()
      		}
  }
  Return $$$OK
}

/*
{
  "startTime": "2023-01-28 00:00:00",
  "endTime": "2023-01-31 23:59:59"
}
*/
/// 事件日志-统计组件事件数量
ClassMethod GetConfigEventNum() As %Status
{

  Set data = %request.Content
  Set obj = ##class(%DynamicObject).%FromJSON(data)
  Set startTime = obj.startTime
  Set endTime = obj.endTime
#;  Set startTime = $zdt($h-7,3)_" 00:00:00"
#;  Set endTime = $zdt($h,3)

  Set startTime = ##class(%String).LogicalToDisplay(startTime)
  Set endTime = ##class(%String).LogicalToDisplay(endTime)
  
  Set strSql = "select top 8 t.ConfigName,count(*) as Num From Ens_Util.Log t where 1=1 "
            _" and {fn RIGHT(%EXTERNAL(t.TimeLogged),999)} > '"_startTime_"'"
            _" and {fn RIGHT(%EXTERNAL(t.TimeLogged),999)} < '"_endTime_"' group by t.ConfigName order by Num desc" 
  
  Set Response = {}
  #;w strSql
  Set rs = ##class(%SQL.Statement).%ExecDirect(,strSql)
  If (rs.%SQLCODE<0) {
      Do ##class(IRISLOG.SOA.utils.baseresp).failResp("sql出错")
	    Return $$$OK
  }Else{
	   Set Response.status = 200
       Set Response.msg = "success"
       Set data = []
      	While rs.%Next() {
	      	Set configname = rs.%Get("ConfigName")
	      	If configname=""{
		      	Set configname = "Production"
		      	}
	            Do data.%Push({
		            "ConfigName":             (configname),
		            "Num":             (rs.%Get("Num"))
		           }) 
            }
            #;判断是否有数据，并作相应判断，并将返回结果转换成Json输出
            If rs.%ROWCOUNT =0{
        		Do ##class(IRISLOG.SOA.utils.baseresp).failResp("没有数据")
      		}Else{
        		Set Response.data = data
       		 Write Response.%ToJSON()
      		}
  }
  Return $$$OK
}

/// 事件日志-统计7天消息数量
ClassMethod Get7DaysEventNum() As %Status
{
  Set data = %request.Content
  Set obj = ##class(%DynamicObject).%FromJSON(data)
  Set startTime = obj.startTime
  Set endTime = obj.endTime

#;  Set startTime = $zdt($h-7,3)_" 00:00:00"
#;  Set endTime = $zdt($h,3)

#;  Set strSql = "SELECT t.TimeSlot, count(*) as Num FROM Ens_Activity_Data.Days t where 1=1 and t.TimeSlot > '"_startTime_"' group by t.TimeSlot"
  Set strSql = "select top 7 count(*) as num, timelog from (select to_char(t.TimeLogged, 'yyyy/mm/dd') as timelog,id From Ens_Util.Log t where 1=1 and t.TimeLogged between '"_startTime_"' and '"_endTime_"')b group by b.timelog"			
            
  
  Set Response = {}
  #;w strSql
  Set rs = ##class(%SQL.Statement).%ExecDirect(,strSql)
  If (rs.%SQLCODE<0) {
      Do ##class(IRISLOG.SOA.utils.baseresp).failResp("sql出错")
	    Return $$$OK
  }Else{
	   Set Response.status = 200
       Set Response.msg = "success"
       Set data = []
      	While rs.%Next() {
	      	
	            Do data.%Push({
		            "TimeSlot":             (rs.%Get("timelog")),
		            "Num":             (rs.%Get("num"))
		           }) 
            }
            #;判断是否有数据，并作相应判断，并将返回结果转换成Json输出
            If rs.%ROWCOUNT =0{
        		Do ##class(IRISLOG.SOA.utils.baseresp).failResp("没有数据")
      		}Else{
        		Set Response.data = data
       		 Write Response.%ToJSON()
      		}
  }
  Return $$$OK
}

}
