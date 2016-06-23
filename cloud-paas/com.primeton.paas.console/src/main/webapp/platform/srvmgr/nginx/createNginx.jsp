<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@page import="com.primeton.paas.console.common.SystemVariable"%>
<%@page import="com.primeton.paas.manage.api.model.OrderItemAttr"%>
<%@page import="com.primeton.paas.manage.api.model.OrderItem"%>
<%@page import="com.primeton.paas.manage.api.service.NginxService"%>

<%
	String hostTemplatesJSON = SystemVariable.getHostTemplatesJSON();
	String proessesJSON = SystemVariable.getNginxProcessesJSON();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/dictEntry.js" type="text/javascript"></script>
</head>
<body>         
	<form id="form1" method="post" >
       	<fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >新增Nginx服务向导</legend>
            <div style="padding:5px;">
            	<input name="order.itemList[0].itemType" value="<%=OrderItem.ITEM_TYPE_NGINX %>" class="nui-hidden" />
		        <table border="0">
		            <tr>
	                    <td style="width:18%;" align="right">是否主备：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[0].attrName" value="<%=OrderItemAttr.ATTR_IS_BACKUP%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[0].attrValue"  class="nui-radiobuttonlist"  textField="text" valueField="id" value="N" data=" [{ id: 'Y', text: '是'}, { id: 'N', text: '否'}]" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">*是否主备.</td>
	                </tr>	
		            <tr>
	                    <td style="width:15%;" align="right">独占主机：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[1].attrName" value="<%=OrderItemAttr.ATTR_IS_STANDALONE%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[1].attrValue"  class="nui-radiobuttonlist"  textField="text" valueField="id" value="N" data=" [{ id: 'Y', text: '是'}, { id: 'N', text: '否'}]" onvalidation="onNullValidation" width="90%"/>
	                    </td>
	                    <td align="left">*服务独占主机或者使用共享主机.</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">服务名称：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[2].attrName" value="<%=OrderItemAttr.ATTR_DISPLAY_NAME%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[2].attrValue"  class="nui-textbox" onvalidation="onNullValidation" value="<%=NginxService.TYPE %>-default" width="90%"/>
	                    </td>
	                    <td align="left">*资源库服务名称，仅用于展示。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">主机套餐：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[3].attrName" value="<%=OrderItemAttr.ATTR_HOSTPKG_ID%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[3].attrValue"  class="nui-combobox" data='<%=hostTemplatesJSON %>' value="20130517J001" width="90%"/>
	                    </td>
	                    <td align="left">*选择需要创建的主机机型。</td>
	                </tr>
		            <tr>
	                    <td style="width:15%;" align="right">工作线程个数：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[4].attrName" value="<%=OrderItemAttr.ATTR_NGINX_WORKER_PROCESSES%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[4].attrValue"  class="nui-combobox" data='<%=proessesJSON %>' value="1" width="90%"/>
	                    </td>
	                    <td align="left">*建议设置为接近CPU的核心数。</td>
	                </tr>
	                <tr>
	                    <td style="width:15%;" align="right">工作线程连接池大小：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[5].attrName" value="<%=OrderItemAttr.ATTR_NGINX_WORKER_CONNECTIONS%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[5].attrValue"  class="nui-textbox" onvalidation="onNullValidation" vtype="range:1024,8192" value="1024" width="90%"/>
	                    </td>
	                    <td align="left">*连接池总大小 = 工作线程个数 * 工作线程连接池大小。</td>
	                </tr>
	                <tr>
	                    <td style="width:15%;" align="right">长连接超时时间：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[6].attrName" value="<%=OrderItemAttr.ATTR_NGINX_KEEPALIVE_TIMEOUT%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[6].attrValue"  class="nui-textbox" onvalidation="onNullValidation" vtype="int" value="65" width="90%"/>
	                    </td>
	                    <td align="left">*长连接超时时间，单位：秒。</td>
	                </tr>
	                <tr>
	                    <td style="width:15%;" align="right">管理主机列表：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[7].attrName" value="<%=OrderItemAttr.ATTR_NGINX_ALLOW_ACCESS_HOSTS%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[7].attrValue" class="nui-textbox" onvalidation="onNginxHostValidation" value="127.0.0.1" width="90%"/>
	                    </td>
	                    <td align="left">*允许访问/查看Nginx监控信息的的主机列表。（以英文逗号分隔） </td>
	                </tr>
	                
	                <tr>
	                    <td style="width:15%;" align="right">数据大小限制：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[8].attrName" value="<%=OrderItemAttr.ATTR_NGINX_CLIENT_MAX_BODY_SIZE%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[8].attrValue" class="nui-textbox" onvalidation="onNullValidation" value="100" width="90%"/>
	                    </td>
	                    <td align="left">*限制HTTP请求发送的数据大小，如限制上传文件的大小，单位：MB。 </td>
	                </tr>
	                <tr>
	                    <td style="width:15%;" align="right">SSL证书存放根路径：</td>
	                    <td style="width:35%;">    
	                         <input name="order.itemList[0].attrList[9].attrName" value="<%=OrderItemAttr.ATTR_NGINX_SSL_CERTIFICATE_PATH%>" class="nui-hidden" />
	                    	 <input name="order.itemList[0].attrList[9].attrValue"  class="nui-textbox" value="/storage/ssl" width="90%"/>
	                    </td>
	                    <td align="left">*SSL证书存放根路径。</td>
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
        
        function onNginxHostValidation(e) {
        	if (!e.value) {
        		e.errorText = "不能为空！";
        		e.isValid = false;
        		return;
        	}
        	var hosts = e.value;
        	var reg = /^[^%\*\^~\'\"\/\\\<\>\|]+$/g;
    		if (!reg.test(hosts)) {
    			e.errorText = "格式不正确！";
        		e.isValid = false;
        		return;
    		}
    		
        	$.ajax({
				url: "<%=request.getContextPath() %>/srv/service/validateNginxHosts/" + hosts,
				async: false,
                success: function (text) {
                	var o = nui.decode(text);
                	if (o.result == false){
                    	e.errorText="格式不正确！";
                		e.isValid=false;
                    } else {
                    	e.isValid=true;
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	e.errorText = "未知错误！";
                	e.isValid = false;
                	nui.alert("系统错误！请稍后重试！" + jqXHR.responseText);
                }
            });
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
            
        	if (!confirm("你确定要提交Nginx服务创建申请？")) {
    	        return false;
    	    }
            var data = form.getData().order;
            var json = nui.encode(data);
            
            $.ajax({
				url: "<%=request.getContextPath() %>/srv/service/createNginx",
				contentType: "application/json; charset=utf-8",
				data: json,
				type: "PUT",
                success: function (text) {
                	nui.alert("订单已提交，请到订单管理中查看处理结果！");
                }
            });
            closeWindow("ok");
        }
    	
        function onCancel(){
        	closeWindow("cancel");
        }
       
    </script>
</body>
</html>