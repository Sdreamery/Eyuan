<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--右侧样式 uer_info，包含界面-->
   <div class="right_style">
	  <div class="user_address_style">
	    <div class="title_style"><em></em>用户信息</div> 
	      <!--用户信息样式-->
	     <!--个人信息-->
	      <div class="Personal_info" id="Personal">
	         <ul class="xinxi">
	         <form id="userInfoForm"  action="userinfo" method ="post" enctype="multipart/form-data" >
	         <input type="hidden" name="action" value="updateUserInfo"/>
	         <li><label>用 户 名：</label>  <span><input name="userNick" id="userNick" type="text" value="${user.nick }"  class="text"  disabled="disabled"/></span></li>
	         <li><label>真实姓名：</label>  <span><input name="userName" id="userName" type="text" value="${user.uname }"  class="text"  disabled="disabled"/></span></li>
	          <li><label>出身日期：</label> <span class="time" id="userBirthDay">${user.year }年${user.month }月${user.day }日</span>
	           <div class="add_time">
	              <select name="userYear" id="userYear">
	              </select>
	              <select name="userMonth" id="userMon">
	              </select>
	              <select name="userDay" id="userDay"></select>
	           </div>
	          </li>
	          <li>
	         	 <label>用户性别：</label> 
				 <span class="sex"> <c:if test="${user.sex== '1' }">男</c:if> <c:if test="${user.sex== '2' }">女</c:if>  <c:if test="${user.sex== '0' }">保密</c:if> </span>
		         <div class="add_sex">
		          	<input type="radio" name="userSex" <c:if test="${user.sex== '0' }"> checked="checked" </c:if> value="0" >保密&nbsp;&nbsp;
		          	<input type="radio" name="userSex" <c:if test="${user.sex== '1' }"> checked="checked" </c:if>  value="1">男&nbsp;&nbsp;
		            <input type="radio" name="userSex" <c:if test="${user.sex== '2' }"> checked="checked" </c:if> value="2">女&nbsp;&nbsp;
		        </div>
	          </li>
	          <li>
	          	<label>电子邮箱：</label>  
	          	<span>
	          		<input name="usrEmail" id="usrEmail" type="text" value="${user.email }"  class="text"  disabled="disabled"/>
	          	</span>
	          </li>
	          <!-- 注释用户QQ 
	          	<li><label>用户QQ：</label>  <span><input name="" type="text" value="455656565"  class="text"  disabled="disabled"/></span></li>        
	          -->
	          <li><label>移动电话：</label>  <span><input name="userPhone" id="userPhone" type="text" value="${user.phone }"  class="text"  disabled="disabled"/></span></li>
	          <!-- 注释固定电话 
	         	 <li ><label>固定电话：</label> <span><input name="" type="text" value="455656565"  class="text"  disabled="disabled"/></span></li>
	          -->
	          <div class="bottom">
		          <input name="editBtn" id="editBtn" type="button" value="修改信息"  class="modify" />
		          <input name="subBtn" id="subBtn" type="submit" value="确认修改"  class="confirm"/ onlick="editUserInfo()">
	          	  <!-- 返回msg信息显示 -->
	          	  <span id="msg" style="font-size:15px; ">${resultInfo.msg }</span>
	          </div>
	          
	         </ul>
	         
	         <ul class="Head_portrait">
          			<li class="User_avatar"><img src="userinfo?action=userHeadInfo&imageName=${user.head }" style="height: 210px; width: 210px" /></li>
         		 <li><input name="head" type="file" value=""  /></li>
         		</ul>
	         </form>
	         
	      </div>    
	   </div>
  </div>
  <script>

  //昵称失焦事件，判断不为空，发送ajax请求
  //昵称聚焦事件
	 $("#userNick").blur(function(){//失焦
	 	//1、得到昵称文本框的值
	 	var userNick = $("#userNick").val();
	 	
	 	//2、判断昵称是否为空
	 	if(isEmpty(userNick.trim())){
	 		//提示用户不能为空，禁用修改按钮
	 		$("#msg").css("color","red");
	 		$("#msg").html("用户名不能为空！");
	 		$("#subBtn").pop("disable",false);
	 		return;
	 	}
	 	
	 	//3、不为空发送ajax请求
	 	$.ajax({
	 		url:"userinfo",
	 		data:{action:"checkNick",userNick:userNick},
	 		success:function(code){
	 			// 1代表可用,提示昵称可用，启用修改按钮
	 			if(code == 1){
	 				$("#msg").css("color","green");
	 				$("#msg").html("用户名可用.")
	 				$("#subBtn").pop("disable",false);
	 			}else{
	 				//0代表不可用,提示昵称不可用
	 				$("#msg").css("color","red")
	 				$("#msg").html("用户名，不可用！");
	 				$("#subBtn").pop("disable",true);
	 			}
	 		}	
	 	});
	 	
	 }).focus(function editUserInfo(){//聚焦事件
	  	    //清空提示信息，启用修改按钮
	  		$("#msg").html("");
	  		$("#subBtn").prop("disable",false);
	  	});
//===============================================
	//真实姓名不为空判断： 
	$("#userName").blur(function(){//失焦
	 	//1、得到真实姓名文本框的值
	 	var userNick = $("#userName").val();
	 	
	 	//2、判断昵称是否为空
	 	if(isEmpty(userNick.trim())){
	 		//提示用户 真实姓名不能为空，禁用修改按钮
	 		$("#msg").css("color","red");
	 		$("#msg").html("真实姓名不能为空！");
	 		$("#subBtn").pop("disable",false);
	 	} 	
	 }).focus(function editUserInfo(){//聚焦事件
	  	    //清空提示信息，启用修改按钮
	  		$("#msg").html("");
	  		$("#subBtn").prop("disable",false);
	  	});
	
//================================================================== 
		//邮箱唯一性后台判断
	 	$("#usrEmail").blur(function(){//失焦
	  		//1、得到邮箱文本框的值
	  		var usrEmail=$("#usrEmail").val();
	  		//2、判断邮箱是否为空
	  		if(isEmpty(usrEmail.trim())){//为空
	  			//提示用户 邮箱不能为空
	  			$("#msg").css("color","red");
	  			$("#msg").html("邮箱不能为空！");
	  			//禁用修改按钮
	  			$("#subBtn").prop("disable",true);
	  		}
	  		
	  	    //3、邮箱不为空发送ajax请求
		 	$.ajax({
		 		url:"userinfo",
		 		data:{action:"checkEmail",usrEmail:usrEmail},
		 		success:function(code){
		 			// 1代表可用,提示昵称可用，启用修改按钮
		 			if(code == 1){
		 				$("#msg").css("color","green");
		 				$("#msg").html("usrEmail可用.")
		 				$("#subBtn").pop("disable",false);
		 			}else{
		 				//0代表不可用,提示邮箱不可用
		 				$("#msg").css("color","red")
		 				$("#msg").html("usrEmail，不可用！");
		 				$("#subBtn").pop("disable",true);
		 			}
		 		}	
		 	});
	  	}).focus(function editUserInfo(){//聚焦事件
	  	    //清空提示信息，启用修改按钮
	  		$("#msg").html("");
	  		$("#subBtn").prop("disable",false);
	  	}); 
  
//==================================================================  
	//手机号唯一性判断
  	$("#userPhone").blur(function(){//失焦
  		//1、得到手机号文本框的值
  		var userPhone=$("#userPhone").val();
  		//2、判断手机号是否为空
  		if(isEmpty(userPhone.trim())){//为空
  			//提示用户不能为空
  			$("#msg").css("color","red");
  			$("#msg").html("手机号不能为空！");
  			//禁用修改按钮
  			$("#subBtn").prop("disable",true);
  		}
  		
  	    //3、手机号不为空发送ajax请求
	 	$.ajax({
	 		url:"userinfo",
	 		data:{action:"checkPhoenNum",userPhone:userPhone},
	 		success:function(code){
	 			// 1代表可用,提示手机号可用，启用修改按钮
	 			if(code == 1){
	 				$("#msg").css("color","green");
	 				$("#msg").html("手机号可用.")
	 				$("#subBtn").pop("disable",false);
	 			}else{
	 				//0代表不可用,提示昵称不可用
	 				$("#msg").css("color","red")
	 				$("#msg").html("手机号，不可用！");
	 				$("#subBtn").pop("disable",true);
	 			}
	 		}	
	 	});
  	}).focus(function editUserInfo(){//聚焦事件
  	    //清空提示信息，启用修改按钮
  		$("#msg").html("");
  		$("#subBtn").prop("disable",false);
  	});
  
		
//==================================================================  	
 //年月日三级联动
function creatDate(){
	////生成1900年-2100年
	for(var i =2030;i>=1970;i--){
		//创建select项
		$("#userYear").append('<option id="option_'+i+'" value="' + i+'" >'+i+'</option>');
		

	}
	//生成1月-12月
	for(var i=1;i<=12;i++){
		$("#userMon").append('<option id="option_'+i+'" value="' + i+'" >'+i+'</option>');

	}
	//生成1日—31日
	for(var i = 1; i <=31; i++){

		$("#userDay").append('<option id="option_'+i+'" value="' + i+'" >'+i+'</option>');
	}
}
creatDate();  	

//保存某年某月的天数
var days;

//年份点击 绑定函数
userYear.onclick = function()
{
    //月份显示默认值
    //document.getElementById("userMon").options[0].selected = true;
    
    //天数显示默认值
   //document.getElementById("userDay").options[0].selected = true;
}
//月份点击 绑定函数
var clicknum =0
userMon.onclick = function()
{
	//获取选中年份的对象
	var optionsYear=$("#userYear option:selected")
	//拿到选中项的value值，即选中的年份值
	yearNum=optionsYear.val();
	
	//获取选中月份的对象
	var options=$("#userMon option:selected")
	//拿到选中项的value值，即选中的月份值
	monNum=options.val();
	
    //计算天数的显示范围
    if(monNum == 2)//如果是2月
    {
        //判断闰年
        if((yearNum % 4 === 0 && yearNum % 100 !== 0)  || yearNum % 400 === 0)
        {
            days = 29;
        }
        else
        {
            days = 28;
        }
        //判断小月
    }else if(monNum == 4 || monNum == 6 ||monNum == 9 ||monNum == 11){
        days = 30;
    }else{
        days = 31;
    }

    //获取当前day的select控件有多少option（天）
    var userDaySize=document.getElementById("userDay").length;

    //操作之前，保证option为31天
    if(userDaySize!=31){
    	//去除最后4天的option
    	for(var i=userDaySize;i>27; i--){
    		$("#userDay option:last").remove();
    	}
    	//获取最新的day的select控件有多少option（天）
    	userDaySize=document.getElementById("userDay").length;
    	//day的select控件有保持到31个option（天），每月有31天，根据月份调整天数
    	for(var a=userDaySize;i<=31;i++ ){
    		$("#userDay").append('<option id="option_'+i+'" value="' + i+'" >'+i+'</option>');
    	}
    }
    
    
    //增加或删除天数
    
    if(days == 28  ){//一个月如果是28天，则删除29、30、31天
    	for(var i=31;i>28;i--){
    		//删除使用标准提供的$("#select_id option:last").remove(); //删除Select中索引值最大Option(最后一个) 
    		$("#userDay option:last").remove();
    	}
    }else if(days == 29 ){//如果是29天
    	for(var i=31;i>29;i--){
    		$("#userDay option:last").remove();
    	}
    }else if(days == 30){//如果是30天
    	for(var i=31;i>30;i--){
    		$("#userDay option:last").remove();
    	}
    }
} 


//点击选择日，给日期显示赋值
userDay.onclick = function(){
	var birthDate=$("#userYear").val()+"年"+$("#userMon").val()+"月"+$("#userDay").val()+"日";
	$("#userBirthDay").val(birthDate);
	var aa =$("#userBirthDay").val();
}
  </script>