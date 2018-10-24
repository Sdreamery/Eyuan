<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Eyuan超市——登陆</title>
<link rel="icon" href="statics/images/logo.png"> 
<link href="statics/css/base.css" rel="stylesheet" type="text/css">
<link href="statics/css/css.css" rel="stylesheet" type="text/css">
<script src="statics/myJS/config.js" type=text/javascript></script>
<script src="statics/js/jquery-2.1.1.min.js"></script>
<script src="statics/myJS/util.js" type="text/javascript"></script>
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
.conlist {padding:30px; border:1px solid #ccc; width:300px;}
.conbox {
	display: none;
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

<body>
<div class="login-top" style="height: 60px">
    <div class="wrapper">
        <div class="fl font30"><a href="index"><img src="statics/images/logo.png" /></a></div>
        <div class="fr">您好，欢迎为生活充电在线！</div>
    </div>
</div>
<div class="l_main">
    <div class="l_bttitle2"> 
        <!-- <h2>登录</h2>-->
        <h2><a href="index">< 返回首页</a></h2>
    </div>
    <div class="fr margin-r100 margin-t45" style="float: left;"><img src="statics/images/login-pic.jpg" width="507" height="325"></div>
    <div class="loginbox fl" style="margin-top:-30px">
        <div class="tab">
            <ul>
                <li class="on">密码登录</li>
            </ul>
        </div>
        <div class="conlist">
            <div class="conbox" style="display:block;">
            <form id="loginForm" action="user" method="post" style="margin-left: -15px">
            		<input type="hidden" name="action" value="login"/>
                <p>
                    <input type="text" class="loginusername" id="userName"  name="userName" value="${resultInfo.result.uname}"	 />
                </p>
                <p>
                    <input type="password" class="loginuserpassword" id="userPwd" name="userPwd" value="${resultInfo.result.upwd }" />
                </p>
                <div  style="text-align: left;margin-top: 6px;margin-bottom: 6px"><input name="rem" value="1" type="checkbox"  class="inputcheckbox" /> <label>记住我&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><span id="msg" style="color: red">${resultInfo.msg }</span></div>
                <span style="float: left;"><a href="register.jsp" style="color:#ff6000 ; " >立即注册</a></span>
                <span style="float: right;"><a href="#">忘记密码？</a></span>
                <p>
                   <input  type="button" class="loginbtn" value="登  录" onclick= "checkLogin()" />
                </p>
            </form>
            </div>
            <div class="conbox">
            	<p>
                    <input type="text" class="loginusername">
                </p>
                <p>
                    <input type="password" class="loginuserpassword">
                </p>
                <p><span class="fl fntz14 margin-t10"><a href="register.jsp" style="color:#ff6000">立即注册</a></span><span class="fr fntz12 margin-t10"><a href="#">忘记密码？</a></span></p>
                <p>
                    <input type="button" class="loginbtn" value="登  录">
                </p>
            </div>
        </div>
    </div>
    
    
</div>
</body>
</html>
