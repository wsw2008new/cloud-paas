<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.primeton.paas.console.common.SystemVariable"%>
<%@page import="com.primeton.paas.manage.api.model.OrderItemAttr"%>
<%@page import="com.primeton.paas.manage.api.model.OrderItem"%>
<%@page import="com.primeton.paas.manage.api.service.CardBinService"%>

<%
	String hostTemplatesJSON = SystemVariable.getHostTemplatesJSON();

	String instNumsJSON = SystemVariable.getServiceInstNumJSON(CardBinService.TYPE);

	List<Object> days = new ArrayList<Object>();
	for (int i = 1; i <= 31; i++) {
		Map<String, Object> temp = new HashMap<String, Object>();
		temp.put("id", i);
		temp.put("text", i);
		days.add(temp);
	}
	Object daysData = JSONArray.fromObject(days);

	List<Object> hours = new ArrayList<Object>();
	Map<String, Object> temp = new HashMap<String, Object>();
	temp.put("id", -1);
	temp.put("text", "不定时");
	hours.add(temp);
	for (int i = 1; i <= 24; i++) {
		temp = new HashMap<String, Object>();
		temp.put("id", i);
		temp.put("text", i);
		hours.add(temp);
	}
	Object hoursData = JSONArray.fromObject(hours);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/dictEntry.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/common.js" type="text/javascript"></script>
</head>
<body>         
	<form id="form1" method="post" action="<%=request.getContextPath() %>/srv/service/createMail">
       	<fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >新增CardBin服务向导</legend>
            <div style="padding:5px;">
            	<input name="order.itemList[0].itemType" value="<%=OrderItem.ITEM_TYPE_CARDBIN %>" class="nui-hidden" />
		        <table border="0">
		            <!-- <tr>
	                    <td style="width:25%;" align="right">是否主备：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[0].attrName" value="<%=OrderItemAttr.ATTR_IS_BACKUP%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[0].attrValue"  class="nui-radiobuttonlist"  textField="text" valueField="id" value="N" data=" [{ id: 'Y', text: '是'}, { id: 'N', text: '否'}]" onvalidation="onNullValidation" width="80%"/>
	                    </td>
	                    <td align="left">*服务独占主机或者使用共享主机.</td>
	                </tr> -->
		            <tr>
	                    <td style="width:25%;" align="right">独占主机：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[1].attrName" value="<%=OrderItemAttr.ATTR_IS_STANDALONE%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[1].attrValue"  class="nui-radiobuttonlist"  textField="text" valueField="id" value="N" data=" [{ id: 'Y', text: '是'}, { id: 'N', text: '否'}]" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">*服务独占主机或者使用共享主机.</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">服务名称：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[2].attrName" value="<%=OrderItemAttr.ATTR_DISPLAY_NAME%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[2].attrValue"  class="nui-textbox" onvalidation="onNullValidation" value="<%=CardBinService.TYPE %>-default" width="90%"/>
	                    </td>
	                    <td align="left">*资源库服务名称，仅用于展示。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">主机套餐：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[3].attrName" value="<%=OrderItemAttr.ATTR_HOSTPKG_ID%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[3].attrValue"  class="nui-combobox" data='<%=hostTemplatesJSON %>' value="20130517J001" width="90%"/>
	                    </td>
	                    <td align="left">*选择需要创建的主机机型。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">最大实例数：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[4].attrName" value="<%=OrderItemAttr.ATTR_CLUSTER_MAX_SIZE%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[4].attrValue"  class="nui-combobox" data='<%=instNumsJSON %>' value="1" width="90%"/>
	                    </td>
	                    <td align="left">*集群所允许的最大实例数。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">数据库连接：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[5].attrName" value="<%=OrderItemAttr.ATTR_JDBC_URL%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[5].attrValue"  class="nui-textbox" value="jdbc:mysql://10.11.10.119:4003/upaas?autoReconnect=true&autoReconnectForPools=true" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left"></td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">数据库驱动：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[6].attrName" value="<%=OrderItemAttr.ATTR_JDBC_DRIVER%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[6].attrValue"  class="nui-textbox" value="com.mysql.jdbc.Driver" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left"></td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">数据库用户名：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[7].attrName" value="<%=OrderItemAttr.ATTR_JDBC_USER%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[7].attrValue"  class="nui-textbox" value="root" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left"></td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">数据库密码：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[8].attrName" value="<%=OrderItemAttr.ATTR_JDBC_PASSWORD%>" class="nui-hidden" />
	                    	 <input id="mail_db_password" name="order.itemList[0].attrList[8].attrValue"  class="nui-password" vtype="rangeLength:4,20;" value="000000" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">*数据库密码</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">密码确认：</td>
	                    <td style="width:50%;">    
	                    	 <input id="mail_db_password2" class="nui-password" onblur="validatePassword()" value="000000" width="90%"/>
	                    </td>
	                    <td align="left">*密码确认</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">最小连接数：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[9].attrName" value="<%=OrderItemAttr.ATTR_JDBC_MIN_POOL_SIZE%>" class="nui-hidden" />
	                    	 <input id="jdbc_min_pool_size" name="order.itemList[0].attrList[9].attrValue"  class="nui-textbox" value="5" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">*数据库连接池数</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">最大连接数：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[10].attrName" value="<%=OrderItemAttr.ATTR_JDBC_MAX_POOL_SIZE%>" class="nui-hidden" />
	                    	 <input id="jdbc_max_pool_size" name="order.itemList[0].attrList[10].attrValue"  class="nui-textbox" value="10" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">*数据库连接池数</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">【数据同步】 - 是否启用：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[11].attrName" value="<%=OrderItemAttr.ATTR_SYNC_IS_ENABLE%>" class="nui-hidden" />
	                    	 <input id="order.itemList[0].attrList[11].attrValue" name="order.itemList[0].attrList[11].attrValue" class="nui-hidden"/>
	                         <div id="Is_Enable_Sync" class="nui-checkbox" checked="false" readOnly="false" onvaluechanged="enableSync"></div>
	                    </td>
	                    <td align="left"></td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">【数据同步】 - 远程文件系统地址：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[12].attrName" value="<%=OrderItemAttr.ATTR_SYNC_HDFS_FILE_URL%>" class="nui-hidden" />
	                    	 <input id="Cardbin_Asyn_HDFS_Url" name="order.itemList[0].attrList[12].attrValue" class="nui-textbox" value="hdfs://144.240.11.8:8020" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">* 远程卡Bin文件系统地址。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">【数据同步】 - 远程数据目录：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[13].attrName" value="<%=OrderItemAttr.ATTR_SYNC_REMOTE_FILE_PATH%>" class="nui-hidden" />
	                    	 <input id="Cardbin_Asyn_Remote_Path" name="order.itemList[0].attrList[13].attrValue"  class="nui-textbox" value="/user/hddtmn/structure/mcmgmdb_145_7_32_141_61701_MC_MGMDB.TBL_MCMGM_CARD_BIN" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">* 远程存放卡Bin数据文件临时目录。</td>
	                </tr>

		            <tr>
	                    <td style="width:15%;" align="right">【数据同步】 - 本地临时目录：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[14].attrName" value="<%=OrderItemAttr.ATTR_SYNC_TMP_FILE_PATH%>" class="nui-hidden" />
	                    	 <input id="Cardbin_Asyn_Local_Temp_Path" name="order.itemList[0].attrList[14].attrValue"  class="nui-textbox" value="/opt/upaas/temp/cardbin" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">* 本地存放卡Bin数据文件临时目录。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">【数据同步】 - 本地保存目录：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[15].attrName" value="<%=OrderItemAttr.ATTR_SYNC_DEST_FILE_PATH%>" class="nui-hidden" />
	                    	 <input id="Cardbin_Asyn_Local_Path" name="order.itemList[0].attrList[15].attrValue"  class="nui-textbox" value="/storage/sync" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">* 本地存放卡Bin数据文件的目录。</td>
	                </tr>
	                
		            <tr>
	                    <td style="width:18%;" align="right">【数据同步】 - 同步时间周期：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[16].attrName" value="<%=OrderItemAttr.ATTR_SYNC_DAY_OF_MONTH%>" class="nui-hidden" />
	                    	 每月&nbsp;<input id="Sel_Cardbin_Asyn_Day" name="order.itemList[0].attrList[16].attrValue"  class="nui-combobox" value="1" data='<%=daysData %>'/>&nbsp;号&nbsp;
	                         <input name="order.itemList[0].attrList[17].attrName" value="<%=OrderItemAttr.ATTR_SYNC_HOUR_OF_DAY%>" class="nui-hidden" />
	                    	 <input id="Sel_Cardbin_Asyn_Hour" name="order.itemList[0].attrList[17].attrValue"  class="nui-combobox" value="-1" data='<%=hoursData %>'/>&nbsp;时
	                    </td>
	                    <td align="left">* 同步时间周期设定(24小时制)</td>
	                </tr>
		        </table>            
            </div>
        </fieldset>
       
        <div style="text-align:center;padding:10px;">  
        	<a class="nui-button" style="width:8%; " onclick="onAdd">新增</a>  &nbsp;           
        	<a class="nui-button" style="width:8%; " onclick="onCancel">取消</a>             
        </div>        
    </form> 	
 	
    <script type="text/javascript">        
        nui.parse();
        var form = new nui.Form("form1"); 
        init();
        function init(){
        	enableSync();
        }
        
        function onNullValidation(e) {
        	if (!e.value) {
        		e.errorText = "不能为空！";
        		e.isValid = false;
        	}
        }
        
        function enableSync() {
    		//var isSync = document.getElementById("Is_Enable_Sync");
    		var isSync = nui.get("Is_Enable_Sync");
    		 if (isSync.checked) {
    			 //ie
    		 	document.getElementById("Cardbin_Asyn_HDFS_Url").disabled = false;
    		 	document.getElementById("Cardbin_Asyn_Remote_Path").disabled = false;
    		 	document.getElementById("Cardbin_Asyn_Local_Temp_Path").disabled = false;
    	   		document.getElementById("Cardbin_Asyn_Local_Path").disabled = false;
    	    	document.getElementById("Sel_Cardbin_Asyn_Day").disabled = false;
    	    	document.getElementById("Sel_Cardbin_Asyn_Hour").disabled = false;
    	    	//chrome &
    		 	nui.get("Cardbin_Asyn_HDFS_Url").allowInput=true;
    		 	nui.get("Cardbin_Asyn_Remote_Path").allowInput=true;
    		 	nui.get("Cardbin_Asyn_Local_Temp_Path").allowInput=true;
    	    	nui.get("Cardbin_Asyn_Local_Path").allowInput=true;
    	    } else {
    	    	//ie
    	    	document.getElementById("Cardbin_Asyn_HDFS_Url").disabled = true;
    	   		document.getElementById("Cardbin_Asyn_Remote_Path").disabled = true;
    	   		document.getElementById("Cardbin_Asyn_Local_Temp_Path").disabled = true;
    	   		document.getElementById("Cardbin_Asyn_Local_Path").disabled = true;
    	    	document.getElementById("Sel_Cardbin_Asyn_Day").disabled = true;
    	    	document.getElementById("Sel_Cardbin_Asyn_Hour").disabled = true;
    	    	//chrome &
    	    	nui.get("Cardbin_Asyn_HDFS_Url").allowInput=false;
    	    	nui.get("Cardbin_Asyn_Remote_Path").allowInput=false;
    	    	nui.get("Cardbin_Asyn_Local_Temp_Path").allowInput=false;
    	    	nui.get("Cardbin_Asyn_Local_Path").allowInput=false;
    	    	//document.getElementById("Cardbin_Asyn_HDFS_Url").style.color = "#aaaaaa";
    	    }
    	}
        
        //密码确认
        function validatePassword() {
        	var pwd1 = nui.get("mail_db_password").value;
    	    var pwd2 = nui.get("mail_db_password2").value;
    	    if (pwd1 == null || pwd1.length == 0) {
    	    	nui.get("mail_db_password").focus();
    	        return false;
    	    }
    	
    	    if (pwd2 == null || pwd2.length == 0) {
    	    	nui.get("mail_db_password2").focus();
    	        return false;
    	    }
    	
    	    if (pwd1 != pwd2) {
    	        nui.nui.alert('系统提示', "两次输入的密码不相同，请重新输入!");
    	        nui.get("mail_db_password").value = "";
    	        nui.get("mail_db_password2").value = "";
    	        nui.get("mail_db_password").focus();
    	        return false;
    	    }
    	    return true;
        }
        
        function validateJdbcPoolSize() {
        	var min = nui.get("jdbc_min_pool_size").getValue();
        	var max = nui.get("jdbc_max_pool_size").getValue();
        	if(parseInt(min)>parseInt(max)){
        		return false;
        	}
        	return true;
        }
        
        function closeWindow(action) {            
            if (window.CloseOwnerWindow) {
            	return window.CloseOwnerWindow(action);
            } else {
            	window.close();            
            }
        }
        
        function onAdd() {
        	form.validate();
            if (form.isValid() == false) {
            	return;
            }
            
        	if(!validateJdbcPoolSize()) {
       			nui.alert("连接数设置错误,最大连接数不能小于最小连接数 ！");
       			return;
        	}
        	if(!validatePassword()){
        		return;
        	}
            
        	if (!confirm("你确定要提交CardBin服务创建申请？")) {
    	        return false;
    	    }
        	
            var sync = nui.get("Is_Enable_Sync");
            //nui.alert(data.itemList.attrList.isSync);
			if(sync.checked){
            	nui.get("order.itemList[0].attrList[11].attrValue").value="Y";
            }else{
            	nui.get("order.itemList[0].attrList[11].attrValue").value="N";
            }
            var data = form.getData().order;
            var json = nui.encode(data);
            
            $.ajax({
				url: "<%=request.getContextPath() %>/srv/service/createCardBin",
				contentType: "application/json; charset=utf-8",
				data:json,
				type:"PUT",
                success: function (text) {}
            });
            nui.alert("订单已提交，请到订单管理中查看处理结果！");
            closeWindow("ok");
        }
        
        function onCancel(){
        	closeWindow("cancel");
        }
       
    </script>
</body>
</html>