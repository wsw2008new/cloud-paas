<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="../../common/nui/nui.js" type="text/javascript"></script>
    <script src="../../common/cloud/dictEntry.js" type="text/javascript"></script>
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
</head>
<body>    
     
    <form id="form1" method="post">
        <input name="id" class="nui-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:100px;" align="right">角色代码：</td>
                    <td style="width:700px;">    
                         <input name="roleCode" class="nui-textbox asLabel" style="width:100%"/>
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;" align="right">角色名称：</td>
                    <td style="width:700px;">    
                         <input name="roleName" class="nui-textbox"  vtype="rangeLength:4,15;" onvalidation="onRoleNameValidation"/> *长度为4-15位。
                    </td>
                </tr>
                <tr>
                    <td style="width:100px;" align="right">角色描述：</td>
                    <td style="width:700px;">    
                         <input name="roleDesc" vtype="rangeLength:0,255;" class="nui-textarea" style="width:100%"/>
                    </td>
                </tr>
            </table>
        </div>
       
        <div style="text-align:center;padding:10px;">               
            <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    <script type="text/javascript">
        nui.parse();

        var form = new nui.Form("form1");
        
        function onRoleNameValidation(e) {
        	if (!e.value) {
        		e.errorText = "不能为空！";
        		e.isValid = false;
        	}
        }
        
        function SetData(data) {
            // 跨页面传递的数据对象，克隆后才可以安全使用
            data = nui.clone(data);
            var form = new nui.Form("form1");
            form.setData(data.row);
            form.setChanged(false);
        }
        
        function saveData() {
            var o = form.getData();            
            form.validate();
            if (form.isValid() == false) return;
            var json = nui.encode(o);
            form.loading("正在修改,请稍后......");
            $.ajax({
                url: "<%=request.getContextPath() %>/srv/authrole/updateCapRole",
                type: "post",
                data: { keyData: json },
                success: function (text) {
                	var o = nui.decode(text);
                	if (o.result==true) {
                		nui.alert("修改角色成功");
                    	closeWindow("ok");
                	} else {
                		nui.alert("修改角色失败");
                    	closeWindow("failed");
                	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	nui.alert(jqXHR.responseText);
                	form.unmask();
                    closeWindow("failed");
                }
            });
        }
        
        function closeWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow) 
            	return window.CloseOwnerWindow(action);
            else 
            	window.close();            
        }
        
        function onOk(e) {
            saveData();
        }
        
        function onCancel(e) {
            closeWindow("cancel");
        }
        
    </script>
</body>
</html>