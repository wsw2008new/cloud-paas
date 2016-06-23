<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@page import="com.primeton.paas.manage.api.service.JettyService"%>

<%
	String clusterId = request.getParameter("clusterId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/dictEntry.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/common.js" type="text/javascript"></script>
    <style type="text/css">
    .asLabel .nui-textbox-border,
    .asLabel .nui-textbox-input,
    .asLabel .nui-buttonedit-border,
    .asLabel .nui-buttonedit-input,
    .asLabel .nui-textboxlist-border
    {
        border:0;background:none;cursor:default;
    }
    .asLabel .nui-buttonedit-button,
    .asLabel .nui-textboxlist-close
    {
        display:none;
    }
    .asLabel .nui-textboxlist-item
    {
        padding-right:8px;
    }    
 	</style>
	<script type="text/javascript">
    	var datas = [{ id: 'true', text: '是'}
		, { id: 'false', text: '否'}
         ];
	</script>
</head>
<body>
	<form id="form1" method="post" action="<%=request.getContextPath() %>/srv/service/getMemcachedClusterDetail">
       	<fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >集群基本信息</legend>
            <div style="padding:5px;">
		        <table style="width:100%">
		            <tr>
	                    <td style="width:10%;" align="right">集群标识：</td>
	                    <td style="width:80%;">    
	                         <input name="id" id="id" class="nui-textbox asLabel" width="100%"/>
	                    </td>
	                </tr>
	                <tr>
	                    <td style="width:10%;"  align="right">显示名称：</td>
	                    <td style="width:80%;">    
	                         <input name="name" class="nui-textbox asLabel" width="100%"/>
	                    </td>
                	</tr>      
	                <tr>
	                    <td style="width:10%;"  align="right">集群类型：</td>
	                    <td style="width:80%;">    
	                         <input name="type" class="nui-textbox asLabel" width="100%"/>
	                    </td>
                	</tr>      
	                <tr>
	                    <td style="width:10%;"  align="right">共享存储：</td>
	                    <td style="width:80%;">    
	                         <input name="attributes.storageSize" class="nui-textbox asLabel" width="100%"/>
	                    </td>
                	</tr>      
	                <tr>
	                    <td style="width:10%;"  align="right">存储路径：</td>
	                    <td style="width:80%;">    
	                         <input name="attributes.storagePath" class="nui-textbox asLabel" width="100%"/>
	                    </td>
                	</tr>      
	                <tr>
	                    <td style="width:10%;"  align="right">启动参数：</td>
	                    <td style="width:80%;">    
	                         <input name="attributes.vmArgs" class="nui-textbox asLabel" width="100%"/>
	                    </td>
                	</tr>      
	                <tr>
	                    <td style="width:10%;"  align="right">启用会话服务：</td>
	                    <td style="width:80%;">    
	                         <input name="attributes.enableSession" class="nui-combobox asLabel" data="datas" valueField="id" textField="text" width="100%"/>
	                    </td>
                	</tr>      
	                <tr>
	                    <td style="width:10%;"  align="right">所有者：</td>
	                    <td style="width:80%;">    
	                         <input name="owner" class="nui-textbox asLabel" width="100%"/>
	                    </td>
                	</tr>      
		        </table>            
            </div>
        </fieldset>
    </form>
	<br/>
	<div style="width:100%;">
        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                    	<a class="nui-button" onclick="increase()">新增实例</a><span class="separator"></span>
						<a class="nui-button" onclick="decrease()">移除实例</a>
                    </td>
                    <td style="white-space:nowrap;">
                        <a class="nui-button" iconCls="icon-reload" onclick="reFresh()">刷新</a>
                        <span class="separator"></span>
						<a class="nui-button" iconCls="icon-upgrade" onclick="goBack()">返回</a>
                    </td>
                </tr>
            </table>           
        </div>
    </div>
	<div id="datagrid" class="nui-datagrid" style="width:100%;height:120px" allowResize="true"
         idField="id" multiSelect="true" url="<%=request.getContextPath() %>/srv/service/jettyService/<%=clusterId %>" showPager="false" onloaderror="onLoadErrorRenderer">
        <div property="columns">
            <!-- <div type="checkcolumn" ></div> -->        
            <div field="id" width="50" headerAlign="center" align ="center" allowSort="false" renderer="onActionRenderer">服务标识</div>    
            <div field="name" width="150" headerAlign="center" align ="center" allowSort="false">服务名称</div>    
            <div field="ip" width="100" headerAlign="center" align ="center" allowSort="false">主机IP</div>    
            <div field="port" width="50" headerAlign="center" align ="center" allowSort="false">端口</div>    
            <div field="state" width="50" headerAlign="center" align ="center" renderer="onServiceStateRenderer">状态</div>    
            <div field="appName" width="100" headerAlign="center" align ="center" allowSort="false">应用名</div> 
            <div name="memorySize" width="100" headerAlign="center" align ="center" allowSort="false" renderer="onMemorySizeActionRenderer">内存</div>        
            <div field="createdDate" width="150" headerAlign="center" align ="center" allowSort="false" renderer="onDateRenderer">创建时间</div> 
            <div field="owner" width="100" headerAlign="center" align ="center" allowSort="false">所有者</div>    
			<div name="action" width="150" headerAlign="center" align="center" renderer="onServiceActionRenderer" cellStyle="padding:0;">操作</div>    
        </div>
    </div>
    <script type="text/javascript">        
        nui.parse();
        
        var grid = nui.get("datagrid");
        var form = new nui.Form("form1");
        initForm();
        grid.load();
        
        function initForm() {
        	var clusterId = '<%=clusterId%>';
        	form.loading("操作中，请稍后......");
        	$.ajax({
                url: "<%=request.getContextPath() %>/srv/service/getJettyClusterDetail/" + clusterId,
                success: function (text) {
                	form.unmask();
                    var o = nui.decode(text);
                    o.data.type = o.data.type + " 集群";//for display
                    o.data.attributes.storageSize = o.data.attributes.storageSize + " G";
                    if (o.data.attributes.enableSession == ''
                    		|| o.data.attributes.enableSession == null) {
                    	o.data.attributes.enableSession = false;
                    }
                    setNUIForm(form, true, true); // see common.js
                    form.setData(o.data);
                    form.setChanged(false);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	form.unmask();
                    nui.alert(jqXHR.responseText);
                 }
            });
        }
        
        function reFresh() {
        	grid.reload();
        }
        
        function onMemorySizeActionRenderer(e) {
	        var grid = e.sender;
	        var record = e.record;
	        return record.minMemorySize + "-" + record.maxMemorySize;
        }
        
        function goBack() {
        	window.location = "jettyClusterMgr.jsp";
        }
        
		function increase() {
			var clusterId = '<%=clusterId%>';
			nui.alert("increase-"+clusterId);
			if (clusterId == '') {
				nui.alert("jetty集群标识为空,操作取消.");
			}
			if (!confirm("新增实例过程耗时较久，需采用异步处理方式，确定新增集群" + clusterId + "的服务实例?")) {
				return;
			}
			nui.mask({el: document.body,cls: 'mini-mask-loading',html: '正在停止，请稍后...'});
			var num=1;
			var type='<%=JettyService.TYPE%>';
			$.ajax({
				url: "<%=request.getContextPath() %>/srv/service/srvManulIncStretch",
				data: {num:num, type:type, clusterId:clusterId},
				type: "post",
                success: function (text) {
                	nui.unmask();
                	var o = nui.decode(text);
                	nui.alert(o.result);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	nui.unmask();
                    nui.alert("系统错误！请稍后重试!"+jqXHR.responseText);
                }
            });
		}
		
		function decrease(){
			var clusterId = '<%=clusterId%>';
			nui.alert("decrease-" + clusterId);
			if (clusterId == '') {
				nui.alert("jetty集群标识为空,操作取消.");
			}
			
			if (!confirm("该过程不可逆，将会移除服务及其所在主机，因过程耗时较久，故采用异步处理方式，确定移除该服务实例?")) {
				return;
			}
			var num = 1;
			var type = '<%=JettyService.TYPE%>';
			$.ajax({
				url: "<%=request.getContextPath() %>/srv/service/srvManulDecStretch",
				data: {num:num, type:type, clusterId:clusterId},
				type: "post",
                success: function (text) {
                	nui.unmask();
                	var o = nui.decode(text);
                	nui.alert(o.result);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	nui.unmask();
                    nui.alert("系统错误！请稍后重试!"+jqXHR.responseText);
                }
            });
			
		}
		
    </script>
</body>
</html>
 