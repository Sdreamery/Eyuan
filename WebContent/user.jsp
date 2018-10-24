<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URL"%>
<%@page import="com.eyuan.po.UserInfoPo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.lang.Exception"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.HttpURLConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="statics/css/common.css" rel="stylesheet" type="text/css" />
<link href="statics/css/style.css" rel="stylesheet" type="text/css" />
<link href="statics/css/user_style.css" rel="stylesheet" type="text/css" />
<link href="statics/skins/all.css" rel="stylesheet" type="text/css" />
<link href="statics/css/test.css" rel="stylesheet" type="text/css" />
<link href="statics/skins/flat/_all.css" rel="stylesheet" type="text/css" />
<!-- xueyou sweet-->
<link href="statics/sweetalert/sweetalert2.min.css" rel="stylesheet" type="text/css" />
<script src="statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="statics/js/common_js.js" type="text/javascript"></script>
<script src="statics/js/footer.js" type="text/javascript"></script>
<script src="statics/layer/layer.js" type="text/javascript"></script>
<script src="statics/js/iCheck.js" type="text/javascript"></script>
<script src="statics/js/custom.js" type="text/javascript"></script>
<script src="statics/myJS/user_order.js" type="text/javascript"></script>
<script src="statics/sweetalert/sweetalert2.min.js" type="text/javascript"></script>
<script src="statics/myJS/util.js" type="text/javascript"></script>
<script src="statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
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
</style>
<link rel="icon" href="statics/images/logo.png"> 
<title>Eyuan超市——用户中心</title>
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
       <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/cart?action=cartOrderList">我的购物车<b id="shopping-amountTop">${cartCount }</b></a></li>	
	  </ul>
	</div>
    </div>
  </div>
  <div id="header"  class="header top_header_style">
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
        <form action="/eyuan/index" method="get">
        	<input type="hidden" name="action" value="serch"/>
           <input name="keyWord" id="keyWord" class="search_box" onkeydown="keyDownSearch()" type="text" style="height:42px"/>
           <input name="" type="submit" value="搜 索"  class="Search_btn"/>
        </form>
        </div>
        <div class="clear hotword">热门搜索词：香醋&nbsp;&nbsp;&nbsp;茶叶&nbsp;&nbsp;&nbsp;草莓&nbsp;&nbsp;&nbsp;葡萄&nbsp;&nbsp;&nbsp;菜油</div>
</div>
 <!--购物车样式-->
	 <div class="hd_Shopping_list" id="Shopping_list">
	   <div class="s_cart" id="myCart"><a href="cart?action=cartOrderList" >我的购物车</a> <i class="ci-right">&gt;</i><i class="ci-count" id="shopping-amount">${cartCount }</i></div>
	   <div class="dorpdown-layer">
	    <div class="spacer"></div>
	     <div id="myCartDiv" >
       
		 </div>	
		 <div class="Shopping_style">
		 <div class="p-total">共<b id="num">0</b>件商品　共计<strong id="total">￥ 0.00</strong></div>
		 <a href="cart?action=cartOrderList" title="去购物车结算" id="btn-payforgoods" class="Shopping">去购物车结算</a>
		 </div>	 
	   </div>
	 </div>
</div>
<!--菜单栏-->
	<div class="Navigation" id="Navigation">
		 <ul class="Navigation_name">
			<li><a href="index">首页</a></li>
			<li><a href="other/map2.jsp">你身边的超市</a></li>
			<li><a href="#">预售专区</a><em class="hot_icon"></em></li>
			<li><a href="index?action=listAll">商城</a></li>
			<li><a href="#">半小时生活圈</a></li>
			<li class="on"><a href="/eyuan/user.jsp">个人中心</a></li>
			<li><a href="#">热销活动</a></li>
			<li><a href="other/map.jsp">联系我们</a></li>
		 </ul>			 
		</div>
	<script>$("#Navigation").slide({titCell:".Navigation_name li",trigger:"click"});</script>
    </div>
</head>
<!--用户中心样式-->
<div class="user_style clearfix">
 <div class="user_center clearfix">
 <div class="left_style" style="margin-left:-42px">
     <div class="menu_style" style="width: 220px">
     <div class="user_title"><a href="/eyuan/user.jsp">用户中心</a></div>
     <div class="user_Head">
     <div class="user_portrait">
      <img src="<c:if test="<%=exist %>">userinfo?action=userHeadInfo&imageName=${user.head }</c:if><c:if test="<%=!exist %>">statics/images/people.png</c:if>" style="height: 85px; width: 85px" />
      <div class="background_img"></div>
      </div>
      <% 
      		Date date = new Date();
      		SimpleDateFormat siFormat = new SimpleDateFormat("yyyy-MM-dd  HH:mm");
      		String dtime = siFormat.format(date);
      %>
      <div class="user_name">
       <p><span class="name">${user.nick }</span></p>
       <p>访问时间：<%= dtime %></p>
       </div>           
     </div>
     <div class="sideMen">
     <!--菜单列表图层-->
     <dl class="accountSideOption1">
      <dt class="transaction_manage"><em class="icon_1"></em>订单管理</dt>
      <dd>
        <ul>
          <li> <a href="userOrder?action=orderList">我的订单</a></li>
          <li> <a href="user_addr?action=editAddr">收货地址</a></li>
        </ul>
      </dd>
    </dl>
     <dl class="accountSideOption1">
      <dt class="transaction_manage"><em class="icon_2"></em>会员管理</dt>
        <dd>
      <ul>
        <li><a href="userinfo?action=userInfo">用户信息</a></li>
        <li><a href="collect?action=collectList">我的收藏</a></li>
        <li><a href="account?action=showAccount">账户余额</a></li>
      </ul>
    </dd>
    </dl>
     
   </div>
      <script>jQuery(".sideMen").slide({titCell:"dt", targetCell:"dd",trigger:"click",defaultIndex:0,effect:"slideDown",delayTime:300,returnDefault:true});</script>
   </div>
   <!--浏览记录样式-->
    <div class="us_Records">
	  <div id="Record_ps" class="Record_p" style="display: none">
	    <div class="title_name"><span class="name left">浏览历史</span><span class="pageState right"></div>
	      <div class="hd"><a class="next">&lt;</a><a class="prev">&gt;</a></div>
            <div class="bd">
                <ul >
                <li>
                   <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_1.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>	
                    </li>
                <li >
                <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_12.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>		
                </li>
                    <li >
                        <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_23.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>	
                    </li>
                    <li >
                        <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_4.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>							
                    </li>
                    <li>
                        <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_5.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>							
                    </li>
                        <li>
                        <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_8.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>				
                    </li>
                        <li >
                        <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_1.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>	
                    </li>
                        <li>
                        <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_6.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>	
                    </li>
                    <li>
                <div class="p_width">
                    <div class="pic"><a href=""><img src="statics/products/P_11.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="Purchase_info"><span class="p_Price">￥32.50</span> <a href="#" class="Purchase">立即购买</a></div>
                </div>		
                </li>
                </ul>
                </div>            
         </div>
         <script type="text/javascript">jQuery("#Record_ps").slide({mainCell:".bd ul",autoPage:true,effect:"leftLoop",vis:1,autoPlay:false });</script>
	    </div>
   
</div>
	<c:if test="${empty userChangePage }">
		<jsp:include page="user/user_index.jsp"></jsp:include>
	</c:if>
	<c:if test="${!empty userChangePage }">
		<jsp:include page="${userChangePage }"></jsp:include>
	</c:if>
</div>
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
     <dl>
		   
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
            
        </div>
    </div>
</div>


<!-- 引入自己的js文件 -->
<script src="statics/myJS/cart.js" type="text/javascript"></script>

</body>
</html>