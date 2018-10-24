<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="statics/dist/notice.js"></script>
<link href="statics/dist/noticejs.css" rel="stylesheet" type="text/css">
<link href="statics/dist/animate.css" rel="stylesheet" type="text/css">  
<style type="text/css">
	input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }
    input[type="number"]{
        -moz-
</style>
 <div class="right_style">
  <!--地址管理-->
  <div class="user_address_style">
    <div class="title_style"><em></em>地址管理</div> 
   <div class="add_address">
    <span class="name">添加送货地址</span>
    <form action="">
    <table cellpadding="0" cellspacing="0" width="100%">
    <tr><td><input type="hiiden" name="aid" id="aid" value=""/></td></tr>
     <tr><td class="label_name">收&nbsp;货&nbsp;&nbsp;人：</td><td><input name="r_name" id="name" type="text"  class="add_text" style=" width:100px" oninput="checkName()"/><i id="msg_name">*</i></td></tr>
     <tr><td class="label_name">所在地区：</td><td>
             	<select name="r_province" id="province" onchange="checkLocat()">
					<option value="请选择">请选择</option>
				</select>
				<select name="r_city" id="city" onchange="checkLocat()">
					<option value="请选择" id="city2">请选择</option>
				</select>
				<select name="r_district" id="town" onchange="checkLocat()">
					<option value="请选择" id="town2">请选择</option>
				</select>

            <i id="msg_loact">*</i></td></tr>
     <tr><td class="label_name">街道地址：</td><td><textarea name="r_address" id="address" cols="" rows="" style=" width:500px; height:100px; margin:5px 0px" oninput="checkAddr()"></textarea><i id="msg_addr">*</i></td></tr>
     <tr><td class="label_name">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编：</td><td><input name="r_zip" id="zip" type="number" class="add_text" style=" width:100px" oninput="checkZip()"/><i id="msg_zip" >*</i></td></tr>
     <tr><td class="label_name">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</td><td><input name="r_mobile" id="mobile" type="number" class="add_text" style=" width:200px" oninput="checkMobile()"/>&nbsp;&nbsp;(必填)<i id="msg_mobile" >*</i></td></tr>
     <tr><td class="label_name">固定电话：</td>
     <td><input name="r_phone" id="phone" type="number" class="add_text" style=" width:200px" onkeypress='return( /[\d]/.test(String.fromCharCode(event.keyCode) ) )'/>&nbsp;&nbsp;(选填)</td></tr>
     <tr class="moren_dz" style="color: #999"><td class="label_name"></td><td><label><input name="" type="checkbox" value="" />设置为默认地址</label></td></tr>
     <tr><td colspan="2" class="center"><input name="" type="button" value="保存" onclick="saveAddr()" class="add_dzbtn"/>
     <input name="reset" type="reset" id="reset" value="清空"  class="reset_btn"/></td></tr>
    </table>
    </form>
   </div>

   <!--用户地址-->
   <div class="address_content">
   
    <table cellpadding="0" cellspacing="0" class="user_address" width="100%" id="table" >
    <thead>
    	<tr class="label"><td width="80px;">收货人</td><td width="220px;">收件地址</td><td width="80px;">邮编</td><td width="120px;">手机号码</td><td width="80px;">操作</td></tr>
    </thead>
    <tbody id="tbody">
    <c:if test="${empty addrList }"><h1>暂未添加地址</h1></c:if>
	<c:if test="${!empty addrList }">
		<c:forEach items="${addrList }" var="item" >
	    	<tr id="tr_${item.aid }">
		    	<td>${item.r_name }</td>
		    	<td>${item.r_province },${item.r_city },${item.r_district },${item.r_address }</td>
		    	<td>${item.r_zip }</td>
		    	<td>${item.r_mobile }</td>
		    	<td>
		    		<input  type="button" onclick="updateAddr(${item.aid })" value="修改"> &nbsp;|
			      	<input type="button" onclick="deleteAddr(${item.aid })" value="删除"> 
		    	</td>
		    	<td><input type="hidden"  value="${item.r_phone }"/></td>
	    	</tr>
	    </c:forEach>
    </c:if>
    </tbody>
    </table>
   </div>  
  </div>
 </div>
 </div>
 </div>
<script src="/eyuan/statics/js/area.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/select.js" type="text/javascript"></script>
 <script type="text/javascript">

 
 	//添加收货地址
	function saveAddr(){
		//表单验证
		if (checkName()&&checkLocat()&&checkAddr()&&checkZip()&&checkMobile()) {
	 		//获取表单中的值
			var name = document.getElementById("name").value; 
			var province = document.getElementById("province").value; 
			var city = document.getElementById("city").value; 
			var town = document.getElementById("town").value; 
			var address = document.getElementById("address").value; 
			var zip = document.getElementById("zip").value; 
			var mobile =  document.getElementById("mobile").value;
			var phone =  document.getElementById("phone").value; 
			var aid = document.getElementById("aid").value; 
			//验证车成功发送ajax请求
			$.ajax({
				url:"user_addr",
				type:"get",
				dataType:"json",
				data:{action:"saveAddr",aid:aid,name:name,province:province,city:city,district:town,address:address,zip:zip,mobile:mobile,phone:phone},
				success:function(resultInfo) {
					// code=1代表成功
					if (resultInfo.code == 1) {
						// 1、弹出框提示更新成功
						new NoticeJs({
						    text: '保存成功！',
						    position: 'topCenter',
						     animation: {
						        open: 'animated bounceIn',
						        close: 'animated bounceOut'
						    } 
						}).show();
						//2、dom操作更新地址表格
						if($("#tbody").find("tr").length==0){//之前表格无数据
							$("#tbody").html("");
						}
						var str = "";
						for (var int = 0; int < resultInfo.result.length; int++) {
							var addr = resultInfo.result[int];
							 str +='<tr id="tr_'+addr.aid+'">'+
						    	'<td>'+addr.r_name+'</td>'+
						    	'<td>'+addr.r_province+','+addr.r_city+','+addr.r_district+','+addr.r_address+'</td>'+
						    	'<td>'+addr.r_zip+'</td>'+
						    	'<td>'+addr.r_mobile+'</td>'+
						    	'<td>'+
						    		'<input type="button" onclick="updateAddr('+addr.aid+')" value="修改"> &nbsp;|'+
							      	'<input type="button" onclick="deleteAddr('+addr.aid+')" value="删除"> '+
						    	'</td>'+
						    	'<td>'+'<input type="hidden" id="hiddenPhone" value="'+addr.r_phone+'"/>'+'</td>'+
					    		'</tr>'
						}
						$("#tbody").html(str);
							
						//3、清空表单
						$("input[name='reset']").click();
					} else { // code=0代表失败
						// 弹出框提示更新失败
						new NoticeJs({
						    text: resultInfo.msg,
						    position: 'topCenter',
						     animation: {
						        open: 'animated bounceIn',
						        close: 'animated bounceOut'
						    } 
						}).show();
					}
				}
			}); 
		}

		
	}
	
	
	//修改收货地址
	function updateAddr(aid){
		//获取tr
		var tr = $("#tr_" + aid);
		//获取资源数
		var tds = tr.children();
		//通过下标获取元素
		var one = tds.eq(0);
		var two = tds.eq(1);
		var three = tds.eq(2);
		var four = tds.eq(3);
		var five = tds.eq(5).children().eq(0);
		//赋值
		$("#name").val(one.text());
		var addr = two.text().split(",")
		$("#province").val(addr[0]);
		$("#city").val(addr[1]);
		$("#town").val(addr[2]);
		$("#city2").html(addr[1]);
		$("#town2").html(addr[2]);
		$("#city2").val(addr[1]);
		$("#town2").val(addr[2]);
		$("#address").val(addr[3]);
		$("#zip").val(three.text());
		$("#mobile").val(four.text());
		$("#aid").val(aid);
		$("#aid").attr("type","hidden");
		$("#phone").val(five.val());
	}
	
	//ajax删除修改地址
	function deleteAddr(aid){
		//发送ajax请求
		$.ajax({
			url:"user_addr",
			type:"get",
			dataType:"json",
			data:{action:"deleteAddr",aid:aid},
			success:function(code) {
				// code=1代表成功
				if (code == 1) {
					// 弹出框提示删除成功
					new NoticeJs({
					    text:"删除成功!",
					    position: 'topCenter',
					     animation: {
					        open: 'animated bounceIn',
					        close: 'animated bounceOut'
					    } 
					}).show();
					//删除该行记录
					$("#tr_"+aid).remove();
				} else {
					// 弹出框提示删除失败
					new NoticeJs({
					    text:"删除成功!",
					    position: 'topCenter',
					     animation: {
					        open: 'animated bounceIn',
					        close: 'animated bounceOut'
					    } 
					}).show();
				}
			}
		});
	}
	/*************用户输入事件***************/

	function checkName (){//验证用户名汉字、英文、非数字、非其他特殊符号
		var regExp =  /^[\u4E00-\u9FA5A-Za-z]+$/ ;
		var r_name = $("#name").val();
		if(r_name != ""){
			if(r_name.match(regExp)==null){
				$("#msg_name").html("*非法用户名");
				return false;
			}else{
				$("#msg_name").html("*");
				return true;
			}
		}else{
			$("#msg_name").html("*用户名不能为空");
			return false;
		}
	}
	function checkLocat(){//验证下拉地址选项必须选择
		//if(document.getElementById("province").selectedIndex==0||document.getElementById("city").selectedIndex==0||document.getElementById("town").selectedIndex==0){
		if(document.getElementById("province").value=="请选择"||document.getElementById("city").value=="请选择"||document.getElementById("town").value=="请选择"){
			$("#msg_loact").html("*请选择所有地区选项");
			return false;
		}else{
			$("#msg_loact").html("*");
			return true;
		}
	}
	function checkAddr(){//验证街道地址不能为空
		if ($("#address").val()!="") {
			$("#msg_addr").html("*");
			return true;
		}else{
			$("#msg_addr").html("*街道地址不能为空");
			return false;
		}
	}
	function checkZip (){//验证6位数的邮编
		var regExp =  /^\d{6}$/ ;
		var zip = $("#zip").val();
		if(zip != ""){
			if(zip.match(regExp)==null){
				$("#msg_zip").html("*非法的邮编号");
				return false;
			}else{
				$("#msg_zip").html("*");
				return true;
			}
		}else{
			$("#msg_zip").html("*邮编号不能为空");
			return false;
		}
	}
	function checkMobile(){//验证合法的手机号
		var regExp =  /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/ ;
		var mobile = $("#mobile").val();
		if(mobile != ""){
			if(mobile.match(regExp)==null){
				$("#msg_mobile").html("*非法的手机号");
				return false;
			}else{
				$("#msg_mobile").html("*");
				return true;
			}
		}else{
			$("#msg_mobile").html("*手机号不能为空");
			return false;
		}
	}
</script>
