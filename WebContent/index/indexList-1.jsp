<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/eyuan/statics/css/common.css" rel="stylesheet" type="text/css" />
<link href="/eyuan/statics/css/style.css" rel="stylesheet" type="text/css" />
<script src="/eyuan/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/common_js.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/footer.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/accordion.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/lrtk.js" type="text/javascript"></script>
<script src="statics/dist/notice.js""></script>
<link href="statics/dist/noticejs.css" rel="stylesheet" type="text/css">
<link href="statics/dist/animate.css" rel="stylesheet" type="text/css">  
<title>产品列表页</title>
<style type="text/css">
.page_right_style {
    width: 1200px;
    margin-left: 0px;
    float: none;
}
</style>
</head>
<script type="text/javascript" charset="UTF-8">
<!--
 //点击效果start
 function infonav_more_down(index)
 {
  var inHeight = ($("div[class='p_f_name infonav_hidden']").eq(index).find('p').length)*30;//先设置了P的高度，然后计算所有P的高度
  if(inHeight > 60){
   $("div[class='p_f_name infonav_hidden']").eq(index).animate({height:inHeight});
   $(".infonav_more").eq(index).replaceWith('<p class="infonav_more"><a class="more"  onclick="infonav_more_up('+index+');return false;" href="javascript:">收起<em class="pulldown"></em></a></p>');
  }else{
   return false;
  }
 }
 function infonav_more_up(index)
 {
  var infonav_height = 85;
  $("div[class='p_f_name infonav_hidden']").eq(index).animate({height:infonav_height});
  $(".infonav_more").eq(index).replaceWith('<p class="infonav_more"> <a class="more" onclick="infonav_more_down('+index+');return false;" href="javascript:">更多<em class="pullup"></em></a></p>');
 }
   
 function onclick(event) {
  info_more_down();
 return false;
 }
 //点击效果end  
//-->
<!--实现手风琴下拉效果-->
$(function(){
   $(".nav").accordion({
        //accordion: true,
        speed: 500,
	    closedSign: '+',
		openedSign: '-'
	});
}); 

$(function() { 
	$("#scrollsidebar").fix({
		float : 'left',
		//minStatue : true,
		skin : 'green',	
		durationTime : 600
	});
});
</script>
<body>
<head>
 <div id="header_top">
  <div id="top">
    <div class="Inside_pages">
      <div class="Collection"><a href="#" class="green">请登录</a> <a href="#" class="green">免费注册</a></div>
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
  <div class="logo"><a href="index"><img src="/eyuan/statics/images/logo.png" /></a></div>
  <!--结束图层-->
  <div class="Search">
        <div class="search_list">
            <ul>
                <li class="current"><a href="#">产品</a></li>
                <li><a href="#">信息</a></li>
            </ul>
        </div>
        <div class="clear search_cur">
        <form action="index" method="get">
        	<input type="hidden" name="action" value="serch"/>
           <input name="keyWord" id="keyWord" class="search_box" onkeydown="keyDownSearch()" type="text">
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
            <li class="hour"><span class="bg_muen"></span><a href="#">半小时生活圈</a></li>
			<li><a href="/eyuan/other/map2.jsp">你身边的超市</a></li>
			<li><a href="#">预售专区</a><em class="hot_icon"></em></li>
			<li class="on"><a href="/eyuan/index?action=listAll" >商城</a></li>
			<li><a href="/eyuan/user.jsp">个人中心</a></li>
			<li><a href="#">热销活动</a></li>
			<li><a href="/eyuan/other/map.jsp">联系我们</a></li>
		 </ul>			 
		</div>
	<script>$("#Navigation").slide({titCell:".Navigation_name li",trigger:"click"});</script>
    </div>
</head>
<!--产品列表样式-->
<div class="Inside_pages">
<!--位置-->
<div id="Filter_style">
  <div class="Location_link">
  <em></em><a href="index?action=listAll">所有商品分类</a> 
  <c:if test="${!empty parentid }">
  <c:forEach items="${pclass }" var="item">
  		<c:if test='${item.key.cid==parentid}'>
  			&lt;   <a href="index?action=listFu&parentid=${item.key.cid }" >${item.key.cname }</a>
  		</c:if>
  </c:forEach>
  </c:if>
  <c:if test="${!empty cid }">
  <c:forEach items="${pclass }" var="item">
  	<c:forEach items="${item.value }" var="item2">
  		<c:if test='${item2.cid==cid}'>
  			&lt;   <a href="index?action=listFu&parentid=${item.key.cid }">${item.key.cname }</a>
  			&lt;   <a href="index?action=listFu&parentid=${item2.cid }">${item2.cname }</a>
  		</c:if>
  	</c:forEach>
  </c:forEach>
  </c:if>
 </div>
<!--条件筛选样式-->
 <div class="Filter" id="Filter">
 	<c:if test="${empty parentid && empty cid }">
 	<c:forEach items="${pclass }" var="item">
	  <div class="Filter_list clearfix">
	   <div class="Filter_title"><span style="margin-top:10px">${item.key.cname }：</span></div>
	   <div class="Filter_Entire"><a href="index?action=listFu&parentid=${item.key.cid }" class="Complete">全部</a></div>
	   <div class="p_f_name infonav_hidden" style="height: 35px;">
	   <p>
	   <c:forEach items="${item.value }" var="item2">
			<a href="index?action=listZi&cid=${item2.cid }" title="${item2.cname }">${item2.cname } </a>
		</c:forEach>
	    </p>
	   </div>
  	</div> 	
 	</c:forEach>
 	</c:if>
   <c:if test="${!empty parentid && empty cid }">
 	<c:forEach items="${pclass }" var="item">
 	 <c:if test="${item.key.cid==parentid }">
	  <div class="Filter_list clearfix">
	   <div class="Filter_title"><span style="margin-top:10px">${item.key.cname }：</span></div>
	   <div class="Filter_Entire"><a href="index?action=listFu&parentid=${item.key.cid }" class="Complete">全部</a></div>
	   <div class="p_f_name infonav_hidden" style="height: 35px;">
	   <p>
	   <c:forEach items="${item.value }" var="item2">
			<a href="index?action=listZi&cid=${item2.cid }" title="${item2.cname }">${item2.cname } </a>
		</c:forEach>
	    </p>
	   </div>
  	</div> 	
  	</c:if>
 	</c:forEach>
 	</c:if>
  <div class="Filter_list clearfix">

  </div>
  </div>
 </div>
 <!--产品列表样式-->
 <div  class="scrollsidebar side_green clearfix" id="scrollsidebar"> 
    <div class="show_btn" id="rightArrow"><span></span></div>

 <div class="page_right_style">
 <div class="Sorted">
  <div class="Sorted_style">
   <a href="index?action=listSort&sort=&parentid=${parentid }&cid=${cid }" <c:if test="${empty sort }">class="on"</c:if>>综合<i class="iconfont icon-fold"></i></a>
   <a href="index?action=listSort&sort=xinYong&parentid=${parentid }&cid=${cid }"  <c:if test="${sort=='xinYong' }">class="on"</c:if>>信用<i class="iconfont icon-fold"></i></a>
   <a href="index?action=listSort&sort=price&parentid=${parentid }&cid=${cid }" <c:if test="${sort=='price' }">class="on"</c:if>>价格<i class="iconfont icon-fold"></i></a>
   <a href="index?action=listSort&sort=sales&parentid=${parentid }&cid=${cid }" <c:if test="${sort=='sales' }">class="on"</c:if>>销量<i class="iconfont icon-fold"></i></a>
   </div>
   <!--产品搜索-->
   <div class="products_search">
    <input name="" type="text" class="search_text" value="请输入你要搜索的产品" onfocus="this.value=''" onblur="if(!value){value=defaultValue;}"><input name="" type="submit" value="" class="search_btn">
   </div>
   <!--页数-->
   <div class="s_Paging">
   </div>
   </div>
   <c:if test="${resultInfo.code == 0 }">
			<h2>${resultInfo.msg }</h2>
		</c:if>
   <c:if test="${resultInfo.code == 1 }">
   <div class="p_list  clearfix">
   <ul>
   
	<c:forEach items="${resultInfo.result.datas }" var="item">
	<li class="gl-item">
    <em class="icon_special tejia"></em>
	<div class="Borders">
	 <div class="img"><a href="product?pid=${item.pid }" target="_blank"><img src="/eyuan/statics/products/${item.image }/1/1.jpg" style="width:220px;height:220px"></a></div>
	 <div class="Price"><b>${item.price }</b><span>[<s>${item.price*1.2 }</s>]</span></div>
	 <div class="name"><a href="Product_Detailed.html">${item.pname } ${item.subTitle }</a></div>
	 <!-- <div class="Shop_name"><a href="#">三只松鼠旗舰店</a></div> -->
	 <div class="p-operate">
	  <a href="#" onclick=" return collect(${item.pid })" class="p-o-btn Collect"><em></em><span id="sp_${item.pid }">收藏</span></a>
	  <a href="other/map.jsp" class="p-o-btn shop_cart"><em></em>联系我们</a>
	 </div>
	 </div>
	</li>
	</c:forEach>
	
   </ul>
   </c:if>
   <div class="Paging">
    <div class="Pagination">
     <a href="index?action=${action }&pageNum=1&parentid=${parentid }&cid=${cid }">首页</a>
     <a href="index?action=${action }&pageNum=${resultInfo.result.prePage }&parentid=${parentid }&cid=${cid }" class="pn-prev disabled">&lt;上一页</a>
	 <c:forEach begin="${resultInfo.result.startNavPage }" end="${resultInfo.result.endNavPage }" var="p">
		<a href="index?action=${action }&pageNum=${p }&parentid=${parentid }&cid=${cid }" <c:if test="${p == resultInfo.result.pageNum }"> class="on" </c:if>>${p }</a>
	</c:forEach>
	 <a href="index?action=${action }&pageNum=${resultInfo.result.nextPage }&parentid=${parentid }&cid=${cid }">下一页&gt;</a>
	 <a href="index?action=${action }&pageNum=${resultInfo.result.totalPages }&parentid=${parentid }&cid=${cid }">尾页</a>	
     </div>
    </div>
   </div>
</div>
</div>

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
 <!--右侧菜单栏购物车样式-->
<!-- <div class="fixedBox">
  <ul class="fixedBoxList">
      <li class="fixeBoxLi user"><a href="#"> <span class="fixeBoxSpan"></span> <strong>消息中心</strong></a> </li>
    <li class="fixeBoxLi cart_bd" style="display:block;" id="cartboxs">
		<p class="good_cart">9</p>
			<span class="fixeBoxSpan"></span> <strong>购物车</strong>
			<div class="cartBox">
       		<div class="bjfff"></div><div class="message">购物车内暂无商品，赶紧选购吧</div>    </div></li>
    <li class="fixeBoxLi Service "> <span class="fixeBoxSpan"></span> <strong>客服</strong>
      <div class="ServiceBox">
        <div class="bjfffs"></div>
        <dl onclick="javascript:;">
		    <dt><img src="/eyuan/statics/images/Service1.png"></dt>
		       <dd><strong>QQ客服1</strong>
		          <p class="p1">9:00-22:00</p>
		           <p class="p2"><a href="http://wpa.qq.com/msgrd?v=3&amp;uin=123456&amp;site=DGG三端同步&amp;menu=yes">点击交谈</a></p>
		          </dd>
		        </dl>
				<dl onclick="javascript:;">
		          <dt><img src="/eyuan/statics/images/Service1.png"></dt>
		          <dd> <strong>QQ客服1</strong>
		            <p class="p1">9:00-22:00</p>
		            <p class="p2"><a href="http://wpa.qq.com/msgrd?v=3&amp;uin=123456&amp;site=DGG三端同步&amp;menu=yes">点击交谈</a></p>
		          </dd>
		        </dl>
	          </div>
     </li>
	 <li class="fixeBoxLi code cart_bd " style="display:block;" id="cartboxs">
			<span class="fixeBoxSpan"></span> <strong>微信</strong>
			<div class="cartBox">
       		<div class="bjfff"></div>
			<div class="QR_code">
			 <p><img src="/eyuan/statics/images/erweim.jpg" width="180px" height="180px" /></p>
			 <p>微信扫一扫，关注我们</p>
			</div>		
			</div>
			</li>

    <li class="fixeBoxLi Home"> <a href="./"> <span class="fixeBoxSpan"></span> <strong>收藏夹</strong> </a> </li>
    <li class="fixeBoxLi BackToTop"> <span class="fixeBoxSpan"></span> <strong>返回顶部</strong> </li>
  </ul>
</div> -->

<!-- 引入自己的js文件 -->
<script src="/eyuan/statics/myJS/cart.js" type="text/javascript"></script>
<script type="text/javascript">
	function collect(pid){
		$("#sp_"+pid).html("<span style='color: red;'>已收藏</span>");
		return false;
	}
</script>
</body>
</html>
