<%@page import="java.util.Arrays"%>
<%@page import="com.eyuan.po.Product"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eyuan.po.Pclass"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
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
<link href="/eyuan/statics/css/common.css" rel="stylesheet" type="text/css" />
<link href="/eyuan/statics/css/style.css" rel="stylesheet" type="text/css" />
<script src="/eyuan/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/common_js.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/footer.js" type="text/javascript"></script>
<script src="/eyuan/statics/dist/notice.js"></script>
<link href="/eyuan/statics/dist/noticejs.css" rel="stylesheet" type="text/css">
<link href="/eyuan/statics/dist/animate.css" rel="stylesheet" type="text/css">  
	<style type="text/css">
		body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#l-map{height:500px;width:70%; margin: auto;margin-left: 200px;}
		.tophead {
			position: absolute;
			   /*  z-index: 2; */
			    width: 30px;
			    height: 30px;
			    top: 0px;
			    left:45px;
			    border-radius:50%;
			    overflow:hidden;
			}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=E4805d16520de693a3fe707cdc962045"></script>
<link rel="icon" href="/eyuan/statics/images/logo.png"> 
<title>Eyuan——你身边的超市</title>
<script type="text/javascript">

</script>
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
	<!--导航栏-->
	 <div id="header_top">
	  <div id="top">
	    <div class="Inside_pages">
	    <c:if test="${empty user }">
		      <div class="Collection"><a href="/eyuan/login.jsp" class="green">请登录</a>
		      <a href="/eyuan/register.jsp" class="green">免费注册</a></div>
		      </c:if>
		      <c:if test="${!empty user }">
		      <div class="Collection">
		      <img  class="tophead" src="<c:if test="<%=exist %>">/eyuan/userinfo?action=userHeadInfo&imageName=${user.head }</c:if><c:if test="<%=!exist %>">/eyuan/statics/images/people.png</c:if>" />
		      <a href="/eyuan/user.jsp" class="green">&nbsp;Hi! ${user.nick }</a>
		      <a href="/eyuan/user?action=logOut" class="green">退出</a></div>
		      </c:if>
		<div class="hd_top_manu clearfix">
		  <ul class="clearfix">
		   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/index">首页</a></li> 
		   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/user.jsp">我的Eyuan</a> </li>
		   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="#">消息中心</a></li>
	       <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/index?action=listAll">商品分类</a></li>
	       <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/cart?action=cartOrderList">我的购物车<b>${cartCount }</b></a></li>	
		  </ul>
		</div>
	    </div>
	  </div>
	  <div id="header"  class="header page_style">
	<!--logo-->
	<div class="logo"><a href="/eyuan/index"><img src="/eyuan/statics/images/logo.png" /></a></div>
	<!--结束图层，搜索框-->
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
	 <div class="hd_Shopping_list" id="Shopping_list">
	   <div class="s_cart" id="myCart"><a href="/eyuan/cart?action=cartOrderList" >我的购物车</a> <i class="ci-right">&gt;</i><i class="ci-count" id="shopping-amount">${cartCount }</i></div>
	   <div class="dorpdown-layer">
	    <div class="spacer"></div>
	     <div id="myCartDiv" >
       
		 </div>	
		 <div class="Shopping_style">
		 <div class="p-total">共<b id="num">0</b>件商品　共计<strong id="total">￥ 0.00</strong></div>
		 <a href="/eyuan/cart?action=cartOrderList" title="去购物车结算" id="btn-payforgoods" class="Shopping">去购物车结算</a>
		 </div>	 
	   </div>
	 </div>
	</div>
	<!--菜单栏-->
	<div class="Navigation" id="Navigation">
		 <ul class="Navigation_name">
			<li><a href="/eyuan/index">首页</a></li>
            <li class="hour"><span class="bg_muen"></span><a href="#">半小时生活圈</a></li>
			<li class="on"><a href="/eyuan/other/map2.jsp">你身边的超市</a></li>
			<li><a href="#">预售专区</a><em class="hot_icon"></em></li>
			<li><a href="/eyuan/index?action=listAll">商城</a></li>
			
			<li><a href="/eyuan/user.jsp">个人中心</a></li>
			<li><a href="#">热销活动</a></li>
			<li><a href="/eyuan/other/map.jsp">联系我们</a></li>
		 </ul>			 
		</div>
		<script>$("#Navigation").slide({titCell:".Navigation_name li",trigger:"click"});</script>
    </div>
    </head>
<!--     	<div style=" width:100px; height:100px;float: right;text-align: center;">
 		<input name="" type="button" onclick="located()" style="margin-left: -50px; width:100px; height:100px;  border:0; background:url(/eyuan/statics/img/mapmarker.png) no-repeat left top;background-size:contain;" />
 		<h2 style="margin-left: -50px">定位我们</h3>
 		</div> -->
 		<div id="l-map" style="display: inline-block;"></div>
 	
 	<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("l-map");
	map.centerAndZoom(new BMap.Point(121.252785,31.02241), 13);
	map.enableScrollWheelZoom(true);
	var index = 0;
	var myGeo = new BMap.Geocoder();
	var adds = [
		new BMap.Point(121.252785,31.02241),
		new BMap.Point(121.237303,31.035702),
		new BMap.Point(121.251204,31.033983),
		new BMap.Point(121.229932,31.024947),
		new BMap.Point(121.218937,31.012878),
		new BMap.Point(121.254869,30.011949),
		new BMap.Point(121.252857,30.014301),
		new BMap.Point(121.164823,31.052114),
		new BMap.Point(121.401976,30.955046),
		new BMap.Point(121.401976,30.955046),
		new BMap.Point(121.238412,30.966194),
		new BMap.Point(121.270895,30.971148)
	];
	for(var i = 0; i<adds.length; i++){
		var marker = new BMap.Marker(adds[i]);
		map.addOverlay(marker);
		marker.setLabel(new BMap.Label("Eyuan超市:"+(i+1),{offset:new BMap.Size(20,-10)}));
	}
	function bdGEO(){	
		var pt = adds[index];
		geocodeSearch(pt);
		index++;
	}
	function geocodeSearch(pt){
		if(index < adds.length-1){
			setTimeout(window.bdGEO,400);
		} 
		myGeo.getLocation(pt, function(rs){
			var addComp = rs.addressComponents;
		});
	}
</script>
 	
 	
 
<!--网站地图-->
<div class="fri-link-bg clearfix">
    <div class="fri-link">
        <div class="logo left margin-r20"><img src="/eyuan/statics/images/logo.png" width="152" height="81" /></div>
        <div class="left"><img src="/eyuan/statics/images/qd.jpg" width="90"  height="90" />
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

<!-- 引入自己的js文件 -->
<script src="/eyuan/statics/myJS/cart.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/common_js.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/footer.js" type="text/javascript"></script>
</body>
</html>
