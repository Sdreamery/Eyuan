<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Eyuan超市——注册</title>
<link rel="icon" href="statics/images/logo.png"> 
<link href="statics/css/base.css" rel="stylesheet" type="text/css">
<link href="statics/css/css.css" rel="stylesheet" type="text/css">
<script src="statics/js/jquery-2.1.1.min.js"></script>
<script src="statics/myJS/config.js"></script>
<style>
.tab {
	overflow: hidden;
	margin-top: 20px; margin-bottom:-1px;
}
.tab li {
	display: block;
	float: left;
	width: 100px;padding:10px 20px; cursor:pointer; border:1px solid #ccc; 
}
.tab li.on {
	background: #90B831; color:#FFF;padding:10px 20px;
}
.conlist {padding:30px; border:1px solid #ccc; width:390px;}
.conbox {
	display: none;
	width: 322px;
}

/* span{
	height:15px;
} */

input{
	padding: 0 15px;
}

</style>
<script>
$(function(){
	$(".tab li").each(function(i){
		$(this).click(function(){
		$(this).addClass("on").siblings().removeClass("on");
		$(".conlist .conbox").eq(i).show().siblings().hide();
		})
	})
})
</script>
</head>

<body class="l-bg">
<div class="login-top" style="height: 60px">
    <div class="wrapper">
        <div class="fl font30" ><a href="index"><img src="statics/images/logo.png" /></a></div>
        <div class="fr">您好，欢迎为生活充电在线！</div>
    </div>
</div>
<div class="l_main2" style="width: 730px;height: 550px">
  	<div class="l_bttitle"> 
        <h2>注册</h2>
        <span style="float: right;"><a href="login.jsp" >&lt;&nbsp;返回登录</a></span>
    </div>
    
    <div class="loginbox">
        <!-- <div class="tab">
            <ul>
                <li class="on">我是买家</li>
                <li>我是卖家</li>
            </ul>
        </div> -->
        <div class="conlist">
            <div class="conbox" style="display:block;">
            	<form action="user" method="post" id="registerForm">
            		<input type="hidden" name="action" value="checkName"/>
            		<input type="hidden" name="action" value="checkPhone"/>
            		<input type="hidden" name="action" value="checkEmail"/>
            		<input type="hidden" name="action" value="register"/>
                <p>
                    <div class="fl res-text">用户名：</div>
                    <input type="hidden" id="myint1" >
                    <div><input type="text" class="loginuser" id="userName" name="userName" placeholder="请设置用户名" onblur="check_userName()"></div>
                    <span id="err_name" style= "color: red"></span>
                </p>
                <p>
                   <div class="fl res-text">密码：</div>
                   <input type="hidden" id="myint2" >
                   <div><input type="password" class="loginuser" id="userPwd" name="userPwd" placeholder="请设置密码"  onblur="  check_pwd()"></div>
                   <span id="err_pwd" style= "color: red"></span>
                </p>
                <p>
                   <div class="fl res-text">确认密码：</div>
                   <input type="hidden" id="myint3" >
                   <div><input type="password" class="loginuser" id="userPwd2" name="userPwd2" placeholder="请再次输入密码" onblur="check_pwd2()"></div>
                   <span id="err_pwd2" style= "color: red"></span>
                </p>
                <p>
                   <div class="fl res-text">手机：</div>
                   <input type="hidden" id="myint4" >
                   <div><input type="text" class="loginuser" id="phone" name="phone" placeholder="输入您的手机号" onblur="check_phone()"></div>
                   <span id="err_phone" style= "color: red"></span>
                </p>
                <p>
                   <div class="fl res-text">邮箱：</div>
                   <input type="hidden" id="myint5" >
                   <div><input type="text" class="loginuser" id="email" name="email" placeholder="输入您的邮箱" onblur="check_email()"></div>
                   <span id="err_email" style= "color: red"></span>
                </p>
                <p>
                   <!-- <div class="fl res-text">验证码：</div> -->
                   <!--  <div class="fl"><input type="password" class="loginuser2"></div> -->
                   <!-- <div class="fl same-code">获取验证码</div> -->
                   <!--<div class="fl same-code2">60秒后重新获取</div>-->
                </p>
                <p>
                    <input  type="button" class="loginbtn" value="注 册" onclick="check_register();">
                </p>
                </form>
            </div>
            <div class="conbox">
            	<p>
                    <div class="fl res-text">用户名：</div><div><input type="text" class="loginuser"></div>
                </p>
                <p>
                   <div class="fl res-text">密码：</div><div><input type="password" class="loginuser"></div>
                </p>
                <p>
                   <div class="fl res-text">确认密码：</div><div><input type="password" class="loginuser"></div>
                </p>
                <p>
                   <div class="fl res-text">验证码：</div>
                   <div class="fl"><input type="password" class="loginuser2"></div>
                   <div class="fl same-code">获取验证码</div>
                   <!--<div class="fl same-code2">60秒后重新获取</div>-->
                </p>
                <p>
                    <input type="button" class="loginbtn" value="注 册">
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
