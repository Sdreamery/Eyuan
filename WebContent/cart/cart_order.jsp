<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URL"%>
<%@page import="com.eyuan.po.UserInfoPo"%>
<%@page import="java.net.HttpURLConnection"%>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="statics/css/common.css" rel="stylesheet" type="text/css" />
<link href="statics/css/style.css" rel="stylesheet" type="text/css" />
<link href="statics/css/user_style.css" rel="stylesheet" type="text/css" />
<link href="statics/skins/all.css" rel="stylesheet" type="text/css" />
<script src="statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="statics/js/common_js.js" type="text/javascript"></script>
<script src="statics/js/footer.js" type="text/javascript"></script>
<script src="statics/layer/layer.js" type="text/javascript"></script>
<script src="statics/js/iCheck.js" type="text/javascript"></script>
<script src="statics/js/custom.js" type="text/javascript"></script>
<script src="statics/dist/notice.js"></script>
<link href="statics/dist/noticejs.css" rel="stylesheet" type="text/css">
<link href="statics/dist/animate.css" rel="stylesheet" type="text/css">  
<style type="text/css">
	.tophead {
	position: absolute;
	   /*  z-index: 2; */
	    width: 30px;
	    height: 30px;
	    top: 0px;
	    left:50px;
	    border-radius:50%;
	    overflow:hidden;
	}
	.div1{
		margin: auto;
		margin-bottom: 10px;
		margin-top: 10px;
		width: 950px;
		height: 30px;
		background-color: #ececec;
		padding-top:2px
	}
	.div4{
		text-align:center;
		margin: auto;
		margin-bottom: 10px;
		margin-top: 10px;
		width: 950px;
		height: 300px;
		background-color: white;
		padding-top:2px
	}
	.div2{
		text-align: center;
	}
	.div3{
		text-align: right;
		margin: auto;
		margin-bottom: 10px;
		margin-top: 10px;
		width: 950px;
		height: 30px;
		background-color: #ececec;
		padding-top:2px;
		
	}
	table tr th{
		background-color:#ececec ;
		text-align:center;//水平居中
		vertical-align:middle;//垂直居中
		}
	table tr td{
		text-align:center;
		vertical-align:middle;//垂直居中
		border: solid red 1px;
		}
	td dt {
	    width: 85px;
	    height: 85px;
	    border: #CCC 1px solid;
	    float: left;
	}
	td dd {
	    width: 300px;
	    float: left;
	    margin-left: 10px;
	    line-height: 16px;
	    text-align: left;
	    padding-top: 30px;
	}	
</style>
<link rel="icon" href="/eyuan/statics/images/logo.png"> 
<title>Eyuan购物车——订单</title>
</head>
<%
boolean exist = false;
if((UserInfoPo)request.getSession().getAttribute("user")!=null){
   	String head = ((UserInfoPo)request.getSession().getAttribute("user")).getHead();
  	String filePath = "http://localhost:8080/eyuan/userinfo?action=userHeadInfo&imageName="+head;
   	try {
   		  URL url = new URL(filePath); // 检验文件是否存在
   		  HttpURLConnection urlcon = (HttpURLConnection)url.openConnection();
   		  InputStream is = url.openStream();
   		  if(is.read()>0){
   			exist = true;
   		  }
   		 } catch (Exception e) {
   			 
   		 }
}
%>
<body>
<head>
 <div id="header_top">
  <div id="top">
    <div class="Inside_pages">
      <c:if test="${empty user }">
		      <div class="Collection"><a href="login.jsp" class="green">请登录</a>
		      <a href="register.jsp" class="green">免费注册</a></div>
		      </c:if>
		      <c:if test="${!empty user }">
		      <div class="Collection">
		      <img  class="tophead" src="<c:if test="<%=exist %>">userinfo?action=userHeadInfo&imageName=${user.head }</c:if><c:if test="<%=!exist %>">statics/images/people.png</c:if>" />
		      <a href="user.jsp" class="green">&nbsp;Hi! ${user.nick }</a>
		      <a href="user?action=logOut" class="green">退出</a></div>
		      </c:if>
	<div class="hd_top_manu clearfix">
	  <ul class="clearfix">
	   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/index">首页</a></li> 
	   <li class="hd_menu_tit" data-addclass="hd_menu_hover"> <a href="/eyuan/user.jsp">我的Eyuan</a> </li>
	   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="#">消息中心</a></li>
       <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/index?action=listAll">商品分类</a></li>
        <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/cart?action=cartOrderList">我的购物车<b>${cartCount }</b></a></li>	
	  </ul>
	</div>
    </div>
  </div>
  
  <div id="header"  class="header page_style">
  <div class="logo"><a href="index"><img src="statics/images/logo.png" /></a></div>
  <!--结束图层-->
  <div class="Search">
        <div class="search_list">
            <ul>
                <li class="current"><a href="#">产品</a></li>
                <li><a href="#">信息</a></li>
            </ul>
        </div>
        <div class="clear search_cur">
           <input name="searchName" id="searchName" class="search_box" onkeydown="keyDownSearch()" type="text">
           <input name="" type="submit" value="搜 索"  class="Search_btn"/>
        </div>
        <div class="clear hotword">热门搜索词：香醋&nbsp;&nbsp;&nbsp;茶叶&nbsp;&nbsp;&nbsp;草莓&nbsp;&nbsp;&nbsp;葡萄&nbsp;&nbsp;&nbsp;菜油</div>
</div>
 <!--购物车样式-->

</div>
<!--菜单栏-->
	<div class="Navigation" id="Navigation">
		 <ul class="Navigation_name">
			<li><a href="index">首页</a></li>
			<li><a href="/eyuan/other/map2.jsp">你身边的超市</a></li>
			<li><a href="#">预售专区</a><em class="hot_icon"></em></li>
			<li><a href="/eyuan/index?action=listAll">商城</a></li>
			<li><a href="#">半小时生活圈</a></li>
			<li><a href="/eyuan/user.jsp">个人中心</a></li>
			<li><a href="#">热销活动</a></li>
			<li><a href="/eyuan/other/map.jsp">联系我们</a></li>
		 </ul>			 
		</div>
	<script>$("#Navigation").slide({titCell:".Navigation_name li",trigger:"click"});</script>
    </div>
</head>
<div class="div1"><h2 >当前进度</h2></div>
<div id="mian">

	<c:if test="${!empty mySubOrder }">
		<jsp:include page="${mySubOrder }"></jsp:include>
	</c:if>
	<c:if test="${empty mySubOrder }">
		<jsp:include page="subOrder1.jsp"></jsp:include>
	</c:if>

</div>

	

   <script>
            $(document).ready(function(){
              $('.moren_dz input').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
              });
            });
   </script>
 <!--网站地图-->
<div class="fri-link-bg clearfix">
    <div class="fri-link">
        <div class="logo left margin-r20"><img src="statics/images/logo.png" width="152" height="81" /></div>
        <div class="left"><img src="statics/images/qd.jpg" width="90"  height="90" />
            <p>扫描下载APP</p>
        </div>
       <div class="">
    <dl>
	 <dt>新手上路</dt>
	 <dd><a href="#">售后流程</a></dd>
     <dd><a href="#">购物流程</a></dd>
     <dd><a href="#">订购方式</a> </dd>
     <dd><a href="#">隐私声明 </a></dd>
     <dd><a href="#">推荐分享说明 </a></dd>
	</dl>
	<dl>
	 <dt>配送与支付</dt>
	 <dd><a href="#">保险需求测试</a></dd>
     <dd><a href="#">专题及活动</a></dd>
     <dd><a href="#">挑选保险产品</a> </dd>
     <dd><a href="#">常见问题 </a></dd>
	</dl>
	<dl>
	 <dt>售后保障</dt>
	 <dd><a href="#">保险需求测试</a></dd>
     <dd><a href="#">专题及活动</a></dd>
     <dd><a href="#">挑选保险产品</a> </dd>
     <dd><a href="#">常见问题 </a></dd>
	</dl>
	<dl>
	 <dt>支付方式</dt>
	 <dd><a href="#">保险需求测试</a></dd>
     <dd><a href="#">专题及活动</a></dd>
     <dd><a href="#">挑选保险产品</a> </dd>
     <dd><a href="#">常见问题 </a></dd>
	</dl>	
    <dl>
	 <dt>帮助中心</dt>
	 <dd><a href="#">保险需求测试</a></dd>
     <dd><a href="#">专题及活动</a></dd>
     <dd><a href="#">挑选保险产品</a> </dd>
     <dd><a href="#">常见问题 </a></dd>
	</dl>
     <dl>
	 <dt>帮助中心</dt>
	 <dd><a href="#">保险需求测试</a></dd>
     <dd><a href="#">专题及活动</a></dd>
     <dd><a href="#">挑选保险产品</a> </dd>
     <dd><a href="#">常见问题 </a></dd>
	</dl>
	   
   </div>
    </div>
</div>
<!--网站地图END-->
<!--网站页脚-->
<div class="copyright">
    <div class="copyright-bg">
        <div class="hotline">为生活充电在线 <span>招商热线：****-********</span> 客服热线：400-******</div>
        <div class="hotline co-ph">
            <p>版权所有Copyright ©***************</p>
            <p>*ICP备***************号 不良信息举报</p>
            <p>总机电话：****-*********/194/195/196 客服电话：4000****** 传 真：********
                
                <a href="http://www.mycodes.net/" target="_blank">源码之家</a></p>
        </div>
    </div>
</div>

<script type="text/javascript">
$("input[name=myck]").click(function() {//动态根据勾选的复选框凭借id字符串和计算总价
	var str = "";
	var total = 0.0;
	$("input[name='myck']:checkbox").each(function() { 
		if($(this).is(":checked")){ 
			str += $(this).attr("value")+"-"; 
			total+=parseFloat($(this).parent().parent().children().eq(3).attr("price"));
			} 
		});
	if(str.substr(str.length-1,1)=="-"){
		str = str.substring(0, str.length-1);
	}
	console.log(str);
	$("#cartid").val(str);
	$("#total").html("总计：￥"+total);
});



function order() {//拼接已勾选的复选框的购物车id
	var str = "";
	$("input[class ='myck']:hidden").each(function() { 
			str += $(this).attr("value")+"-"; 
		});
	if(str.substr(str.length-1,1)=="-"){
		str = str.substring(0, str.length-1);
	}	
	/* $.ajax({
		type: "POST",
		   url: "cart",
		   data: {"action":"order","cartid":str},
		   success: function(resultInfo){
			   alert(resultInfo.code);
			   $('.main').load('cart/cart_order.jsp',{'mySubOrder':"subOrder3.jsp"},function(){ });  
		   }
	}); */
}
function hasChecked(aid){
	$("#aid").val(aid);
}
function hasAddr(){//判断用户是否勾选了地址
	var addrs = $("[name=addr]");
	for(var i = 0;i<addrs.length;i++){
		
		if (addrs[i].checked) {
			return true;
		}
	}
	new NoticeJs({
	    text: '您还未添加任何收货地址！',
	    position: 'topCenter',
	     animation: {
	        open: 'animated bounceIn',
	        close: 'animated bounceOut'
	    } 
	}).show();
	return false;
}
</script>
</body>
</html>
