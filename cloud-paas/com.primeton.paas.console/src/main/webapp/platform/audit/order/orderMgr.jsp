<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath() %>/common/cloud/dictEntry.js" type="text/javascript"></script>
</head>
<body style="height:63%;">         
    <fieldset style="border:solid 1px #aaa;margin-top:8px;position:relative;">
        <legend>查询条件</legend>
        <div id="selForm" style="padding:5px;">
            <table style="width:100%;" border="0">
                <tr>
                    <td style="width:80px;" align="right">订单编码：</td>
                    <td style="width:150px;"><input id="orderId" name="orderId" class="nui-textbox" style="width:150px;"/></td>
                    <td style="width:80px;" align="right">订单类型：</td>
                    <td style="width:150px;"><input id="orderType" name="orderType" class="nui-combobox" data="CLD_OrderTypes" value="defaultValue" style="width:150px;"/></td>
                    <td style="width:100px;" align="right">提交时间：从:</td>
                    <td style="width:300px;" colspan="2">
                    	<input id="submitTimeBegin" name="submitTimeBegin" class="nui-datepicker" />
                    	到:
                    	<input id="submitTimeBegin" name="submitTimeEnd" class="nui-datepicker"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:80px;" align="right">申请人：</td>
                    <td style="width:150px;"><input id="owner" name="owner" class="nui-textbox" style="width:150px;"/></td>
                    <td style="width:80px;" align="right">订单状态：</td>
                    <td style="width:150px;"><input id="orderStatus" name="orderStatus" class="nui-combobox" data="CLD_OrderStatus" value="defaultValue" style="width:150px;"/></td>
                    <td style="width:100px;" align="right">处理时间：从:</td>
                    <td style="width:300px;" colspan="2">
                    	<input id="submitTimeBegin" name="handleTimeBegin" class="nui-datepicker" />
                    	到:
                    	<input id="submitTimeBegin" name="handleTimeEnd" class="nui-datepicker"/>
                    </td>
                </tr>
                <tr>
                	<td colspan="6" align="center">
                		<a class="nui-button" style="width:60px; " onclick="selForm">查询</a>
                	</td>
                </tr>
            </table>
        </div>
	</fieldset>
    
	<br/>
	<div style="width:100%;">
        <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                         <!--  
                         <a class="nui-button" iconCls="icon-add" onclick="add()">增加</a> 
                         <a class="nui-button" iconCls="icon-add" onclick="edit()">编辑</a> 
                         -->
                        <a class="nui-button" iconCls="icon-remove" onclick="remove()">删除</a>       
                    </td>
                </tr>
            </table>           
        </div>
	</div>

    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;" allowResize="true"
			idField="id" multiSelect="true" url="<%=request.getContextPath() %>/srv/orderMgr/list" onloaderror="onLoadErrorRenderer">
        <div property="columns">
			<!--             
			<div type="indexcolumn"></div>        
			-->
            <div type="checkcolumn" ></div>        
            <div field="orderId" width="150"    headerAlign="center" align ="center" allowSort="true" renderer="onActionRenderer">订单编号</div>    
            <div field="orderType" width="120"  headerAlign="center" allowSort="true" renderer="onOrderTypesRenderer">订单类型</div>    
			<div field="orderStatus" width="100" headerAlign="center" allowSort="true" renderer="onOrderStatusRenderer">订单状态</div>    
			<div field="submitTime" width="120" headerAlign="center" align ="center" allowSort="true" renderer="onDateRenderer">提交时间</div>    
			<div field="handleTime" width="120" headerAlign="center" align ="center" allowSort="true" renderer="onDateRenderer">处理时间</div>    
			<div field="owner" width="80" headerAlign="center" align ="center"  allowSort="true">申请人</div>                          
			<div field="handler" width="80" headerAlign="center" align ="center"  allowSort="true">处理人</div>                          
        </div>
    </div>

    <script type="text/javascript">        
        // parse DOM
    	nui.parse();
         
	    var grid = nui.get("datagrid1");
        grid.load();
        grid.sortBy("submitTime", "desc");

        function selForm() {
            var form = new nui.Form("#selForm");            
            var data = form.getData();      //获取表单多个控件的数据
            var json = nui.encode(data);   
        	grid.load({keyData:json});
        }
        
        function remove() {
            var rows = grid.getSelecteds();
            if (rows.length > 0) {
                if (confirm("确定删除选中记录？")) {
                    var ids = [];
                    for (var i = 0, l = rows.length; i < l; i++) {
                        var r = rows[i];
                        ids.push(r.orderId);
                    }
                    var id = ids.join(',');
                    grid.loading("操作中，请稍后......");
                    $.ajax({
                        url: "<%=request.getContextPath() %>/srv/orderMgr/delete/" +id,
                        success: function (text) {
                        	var o = nui.decode(text);
                        	if (o.result) {
                        		nui.alert('删除成功!');
                        		grid.load();
                        	} else {
                        		nui.alert('删除失败!');
                        	}
                        },
                        error: function () {
                        }
                    });
                }
            } else {
                nui.alert("请选中一条记录");
            }
        }
        
        function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var rowIndex = e.rowIndex;
            var orderId = record.orderId
            var s = '<a class="Edit_Button" href="javascript:detailsRow(\'' + orderId + '\')">'+orderId+'</a> ';
            return s;
        }
        
        function detailsRow(orderId){
        	if(null != orderId){
                nui.open({
                    url: "<%=request.getContextPath() %>/platform/audit/order/orderDetails.jsp",
                    title: "订单详情", width: 700, height: 500,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { action: "details", id: orderId };
                        iframe.contentWindow.SetData(data);
                        
                    },
                    ondestroy: function (action) {
                    	if (action == "ok") {
                        	grid.reload();
                    	}
                    }
                });
        	}
        }
    </script>
</body>
</html>