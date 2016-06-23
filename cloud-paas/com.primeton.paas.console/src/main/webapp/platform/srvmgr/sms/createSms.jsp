<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@page import="com.primeton.paas.console.common.SystemVariable"%>
<%@page import="com.primeton.paas.manage.api.model.OrderItemAttr"%>
<%@page import="com.primeton.paas.manage.api.model.OrderItem"%>
<%@page import="com.primeton.paas.manage.api.service.SmsService"%>


<%
	String hostTemplatesJSON = SystemVariable.getHostTemplatesJSON();
	Object instNumsJSON = SystemVariable.getServiceInstNumJSON(SmsService.TYPE)
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>新增短信服务向导</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/dictEntry.js" type="text/javascript"></script>
</head>
<body>         
	<form id="form1" method="post" action="<%=request.getContextPath() %>/srv/service/createSms">
       	<fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >新增短信服务向导</legend>
            <div style="padding:5px;">
            	<input name="order.itemList[0].itemType" value="<%=OrderItem.ITEM_TYPE_SMS %>" class="nui-hidden" />
		        <table border="0">
		            <tr>
	                    <td style="width:20%;" align="right">独占主机：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[0].attrName" value="<%=OrderItemAttr.ATTR_IS_STANDALONE%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[0].attrValue"  class="nui-radiobuttonlist"  textField="text" valueField="id" value="N" data=" [{ id: 'Y', text: '是'}, { id: 'N', text: '否'}]" onvalidation="onNullValidation" width="80%"/>
	                    </td>
	                    <td align="left">*服务独占主机或者使用共享主机.</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">服务名称：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[1].attrName" value="<%=OrderItemAttr.ATTR_DISPLAY_NAME%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[1].attrValue" class="nui-textbox" onvalidation="onNullValidation" value="<%=SmsService.TYPE %>-default" width="80%"/>
	                    </td>
	                    <td align="left">*资源库服务名称，仅用于展示。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">主机套餐：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[2].attrName" value="<%=OrderItemAttr.ATTR_HOSTPKG_ID%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[2].attrValue"  class="nui-combobox" data='<%=hostTemplatesJSON %>' value="20130517J001" width="80%"/>
	                    </td>
	                    <td align="left">*选择需要创建的主机机型。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">最大实例数：</td>
	                    <td style="width:50%;">    
	                         <input name="order.itemList[0].attrList[3].attrName" value="<%=OrderItemAttr.ATTR_CLUSTER_MAX_SIZE%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[3].attrValue"  class="nui-combobox" data='<%=instNumsJSON %>' value="1" width="80%"/>
	                    </td>
	                    <td align="left">*集群所允许的最大实例数。</td>
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
        
        function onNullValidation(e) {
        	if (!e.value) {
        		e.errorText = "不能为空！";
        		e.isValid = false;
        	}
        }
        
        function closeWindow(action) {            
            if (window.CloseOwnerWindow) {
            	return window.CloseOwnerWindow(action);
            } else {
            	window.close();            
            }
        }
        
        function onAdd(){
        	if (!confirm("你确定要提交短信服务创建申请？")) {
    	        return false;
    	    }
        	form.validate();
            if (form.isValid() == false) {
            	return;
            }
            
            var data = form.getData().order;
            var json = nui.encode(data);
            
            $.ajax({
				url: "<%=request.getContextPath() %>/srv/service/createSms",
				contentType: "application/json; charset=utf-8",
				data: json,
				type: "PUT",
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