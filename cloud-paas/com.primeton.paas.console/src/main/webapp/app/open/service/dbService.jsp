<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/dictEntry.js" type="text/javascript"></script>
</head>
<body style="height:100%">         
		<fieldset style="border:solid 1px #aaa;padding:3px;height:95%">
           	<legend ><b>平台应用关联服务</b></legend>	       		
       		<div style="width:100%;">
		        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		            <table style="width:100%;">
		                <tr>
		                    <td style="width:100%;">
		                        <a class="nui-button" iconCls="icon-add" onclick="createMysql()">申请MySQL服务</a>
		                        <a class="nui-button" iconCls="icon-remove" onclick="remove('datagridMysql')">移除</a>       
		                    </td>
		                </tr>
		            </table>           
		        </div>
		    </div>
            <div id="datagridMysql" class="nui-datagrid" style="width:100%;height:85%;" allowResize="true"
        					idField="id" multiSelect="true" url="<%=request.getContextPath() %>/srv/myService/listMySQL" showPageInfo="false" onloaderror="onLoadErrorRenderer">
		        <div property="columns">
		            <div type="checkcolumn" ></div>        
		            <div field="id" width="60" headerAlign="center" align ="center" allowSort="true">集群标识</div>    
		            <div field="name" width="200"  headerAlign="center" align ="center" allowSort="true">服务名称</div>    
		            <div field="attributes.size" width="80"  headerAlign="center" align ="center"  allowSort="true">集群实例数</div>  
		           <div header="实例数范围" headerAlign="center" align ="center" >
		                <div property="columns" headerAlign="center" align ="center">
		                    <div field="minSize" width="50" headerAlign="center" align ="center">最小</div>
		                    <div field="maxSize" width="50" headerAlign="center" align ="center">最大</div>
		                </div>
		            </div>						
					  
					<div field="attributes.state" width="50" headerAlign="center" align ="center" allowSort="true" renderer="onSrvStatusRenderer">状态 </div>  
					<div field="desc" width="150" headerAlign="center" align ="center" allowSort="true" >描述 </div>   
					<!-- 						
					<div field="desc" width="150" headerAlign="center" align ="center" allowSort="true" >操作 </div>          
					-->
		        </div>
              </div>
         </fieldset>
         
    <script type="text/javascript">        
    	// parse DOM    
    	nui.parse();
         
		var gridMysql = nui.get("datagridMysql");
	    gridMysql.load();
	   
        function createMysql(){
	        nui.open({
	            url: "<%=request.getContextPath() %>/app/open/service/createMysql.jsp",
	            title: "申请MySQL服务", width: 800, height: 320,
	            onload: function () {
	                var iframe = this.getIFrameEl();
	                var data = { action: "details"};
	                iframe.contentWindow.SetData(data);
	                
	            },
	            ondestroy: function (action) {
	            	gridMysql.reload();
	                
	            }
	        });
        }
        
       	//移除服务
   		function remove(gName) {    		
            var rows = nui.get(gName).getSelecteds();
            var count = rows.length;
            if (count != 1) {
            	nui.alert('请选中一条记录!');
            	return;
            }
            var row = rows[0];
            
            var row = rows[0];
            if (row.attributes.state == 2) {
            	nui.alert('此服务已经是移除状态!');
            	return;
            }
    		
    		var id = row.id;
            
            nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: 'Loading...'
            });
            
	        $.ajax({
	        	 // appName , @PathParam("appType") String  appType
	             url: "<%=request.getContextPath() %>/srv/myService/removeService/" + id,
	             contentType: "application/json; charset=utf-8",
	             cache: false,
	             async: false,
	             success: function (text) {
	                	var o = nui.decode(text);
	                	if (o) {
	                		nui.alert('提交移除申请成功!');
	                		reload();
	                	} else {
	                		nui.alert('提交移除申请失败!');
	                	}
	                	nui.unmask(document.body);
		            }
		        });
    	    
    	}
       	
        function reload(){
        	gridMysql.load();
        }
        
    </script>
</body>
</html>