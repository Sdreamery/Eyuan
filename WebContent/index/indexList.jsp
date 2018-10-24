<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URL"%>
<%@page import="com.eyuan.po.UserInfoPo"%>
<%@page import="java.net.HttpURLConnection"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/eyuan/statics/css/common_x.css" rel="stylesheet" type="text/css" />
<link href="/eyuan/statics/css/style_x.css" rel="stylesheet" type="text/css" />
<link href="/eyuan/statics/css/search.css" rel="stylesheet" type="text/css" />
<script src="/eyuan/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/common_js.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/footer.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/accordion.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/lrtk.js" type="text/javascript"></script>
<script src="/eyuan/statics/js/search.js" type="text/javascript"></script>
<script src="statics/dist/notice.js""></script>
<link href="statics/dist/noticejs.css" rel="stylesheet" type="text/css">
<link href="statics/dist/animate.css" rel="stylesheet" type="text/css">
<link rel="icon" href="statics/images/logo.png">   
<title>Eyuan超市</title>
<style type="text/css">
	.page_right_style {
	    width: 1200px;
	    margin-left: 0px;
	    float: none;
	}
	body {
		font: 12px/1.5 tahoma,arial,"\5b8b\4f53";
		font-family: tahoma,arial,"\5FAE\8F6F\96C5\9ED1",sans-serif;
	}
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
<script>$("#Navigation").slide({titCell:".Navigation_name li",trigger:"click"});</script>
<body>
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
			        <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/cart?action=cartOrderList" id="shopping-amountTop">我的购物车<b>${cartCount }</b></a></li>	
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
	                <li class="current"><label for="detialInfo">商品信息</label></li>
	                <!-- <li><a href="mall?action=searchName">信息</a></li> -->
	            </ul>
	        </div>
	        <form role="search" action="mall">
		        <div class="clear search_cur">
		        		
			        	<input type="hidden" name="action" value="searchKey">
						<input type="text" id="detialInfo" name="detail" class="search_box" placeholder="请输入关键字" value="${detial }">
						<input type="submit" value="搜 索"  class="Search_btn"/>
					
		        </div>
	        </form>
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
</div>

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
			   <div class="Filter_title"><span style="margin-top:0px">${item.key.cname }：</span></div>
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
			   <div class="Filter_title"><span style="margin-top:0px">${item.key.cname }：</span></div>
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
			<!-- <div class="Sorted">
				<div class="Sorted_style">
				   	<a href="#" class="on">综合<i class="iconfont icon-fold"></i></a>
				  	<a href="#">价格<i class="iconfont icon-fold"></i></a>
				   	<a href="#">销量<i class="iconfont icon-fold"></i></a>
				   	<a href="#">信用<i class="iconfont icon-fold"></i></a>
				</div>
			</div> -->
			
			<div id="J_filter" class="filter">
				<div class="f-line top">
	
					<div class="f-sort">
						<a href="mall?&pid=${resultInfo.result.datas.get(0).pid }<c:if test="${!empty resultInfo }">${resultInfo.result.pageNum }</c:if>" <c:if test="${menu == 'pid' }">class="curr"</c:if>>
							<span class="fs-tit">综合</span>
							<em class="fs-down"><i class="arrow"></i></em>
						</a>
							
							<a href="mall?num=${resultInfo.result.datas.get(0).num }<c:if test="${!empty resultInfo }">${resultInfo.result.pageNum }</c:if>" <c:if test="${menu == 'num' }">class="curr"</c:if> >
								<span class="fs-tit">销量</span>
								<em class="fs-down"><i class="arrow"></i></em>
							</a>
						
						
						<a href="mall?price=${resultInfo.result.datas.get(0).price }<c:if test="${!empty resultInfo }">${resultInfo.result.pageNum }</c:if>" <c:if test="${menu == 'price' }">class="curr"</c:if> >
							<span class="fs-tit">价格</span>
							<em class="fs-down"><i class="arrow"></i></em>
						</a>
						<a href="javascript:;" class="" >
							<span class="fs-tit">评论数</span>
							<em class="fs-down"><i class="arrow"></i></em>
						</a>
						<!-- <a href="javascript:;" class="">
							<span class="fs-tit">上架时间</span>
							<em class="fs-up"><i class="arrow-top"></i><i class="arrow-bottom"></i></em>
						</a> -->
					</div>
		
					<div class="f-datagrid">
						<a href="javascript:;" class="fdg-item" data-range="0-7" data-tips="10%的用户喜欢的价位">
							<span class="def-bar" style="height:21%"></span>
						</a>
						<a href="javascript:;" class="fdg-item" data-range="7-16" data-tips="32%的用户喜欢的价位">
							<span class="def-bar" style="height:68%"></span>
						</a>
						<a href="javascript:;" class="fdg-item fdg-item-curr" data-range="16-35" data-tips="40%的用户喜欢的价位">
							<span class="def-bar" style="height:85%"></span>
						</a>
						<a href="javascript:;" class="fdg-item" data-range="35-67" data-tips="12%的用户喜欢的价位">
							<span class="def-bar" style="height:26%"></span>
						</a>
						<a href="javascript:;" class="fdg-item" data-range="67-¥" data-tips="6%的用户喜欢的价位">
							<span class="def-bar" style="height:13%"></span>
						</a>
					</div>
		
					<div id="J_selectorPrice" class="f-price">
						<div class="f-price-set">
							<div class="fl"><input type="text" class="input-txt" autocomplete="off" style="color: rgb(51, 51, 51);" value="16"></div>
							<em>-</em>
							<div class="fl"><input type="text" class="input-txt" autocomplete="off" style="color: rgb(51, 51, 51);" value="35"></div>
						</div>
						<div class="f-price-edit">
							<a href="javascript:;" class="item1 J-price-cancle">清空</a>
							<a href="javascript:;" class="item2 J-price-confirm" data-url="search?keyword=%E4%BC%91%E9%97%B2%E9%A3%9F%E5%93%81&amp;enc=utf-8&amp;qrst=1&amp;rt=1&amp;stop=1&amp;vt=2&amp;suggest=1.his.0.0&amp;stock=1&amp;ev=exprice_%7Bmin%7D-%7Bmax%7D%5E&amp;uc=0#J_searchWrap">确定</a>
						</div>
					</div>
		
					<div id="J_topPage" class="f-pager">
						<!-- 显示当前分页情况 -->
						<span class="fp-text"><b>${resultInfo.result.pageNum }</b><em>/</em><i>${resultInfo.result.totalPages }</i></span>
						<!-- 如果当前页为第一页，那么让导航按钮变成不可点。 -->
						<c:if test="${resultInfo.result.pageNum == 1 }">
							<a class="fp-prev disabled" href="javascript:;">&lt;</a>
						</c:if>
						<!-- 如果当前页不为第一页，让导航按钮恢复点击功能 -->
						<c:if test="${resultInfo.result.pageNum != 1 }">
							<a class="fp-prev" href="mall?pageNum=${resultInfo.result.prePage }<c:if test="${!empty searchInfo }">${searchInfo }</c:if>" title="使用方向键左键也可翻到上一页哦！" style="color: #333;">&lt;</a>
						</c:if>
						<!-- 如果当前页不为最后一页，让导航按钮恢复点击功能 -->
						<c:if test="${resultInfo.result.pageNum != resultInfo.result.totalPages }">
							<a class="fp-next" href="mall?pageNum=${resultInfo.result.nextPage }<c:if test="${!empty searchInfo }">${searchInfo }</c:if>" title="使用方向键右键也可翻到下一页哦！" style="color: #333;">&gt;</a>
						</c:if>
						<!-- 如果当前页为最后一页，那么让导航按钮变成不可点。 -->
						<c:if test="${resultInfo.result.pageNum == resultInfo.result.totalPages }">
							<a class="fp-next disabled" href="javascript:;">&gt;</a>
						</c:if>
					</div>
					<!-- 显示当前商品数量状况 -->
					<div class="f-result-sum">共<span id="J_resCount" class="num">${resultInfo.result.totalCount }+</span>件商品</div>
		
					<span class="clr"></span>
				</div>
			</div>
								
			
			<c:if test="${resultInfo.code == 0 }"><h1>${resultInfo.msg }</h1></c:if>
			<c:if test="${resultInfo.code == 1 }">
				<div class="p_list  clearfix">
					<ul>
					<c:forEach items="${resultInfo.result.datas }" var="item">
						<li class="gl-item">
					    	<em class="icon_special tejia"></em>
							<div class="Borders">
								 <div class="img"><a href="product?pid=${item.pid }" target="_blank"><img src="/eyuan/statics/products/${item.image }/1/1.jpg" style="width:220px;height:220px"></a></div>
								 <div class="Price">
								 	<b>¥ ${item.price }</b>
								 	<%-- <strong style="color:#CEAA00;font-weight:400;float: right;">${1000-item.num }</strong> --%>
								 	<span style="float: right;">总销量：<strong>${1000-item.num }</strong></span>
								 </div>
								 <div class="name"><a href="product?pid=${item.pid }" target="_blank"><b>${item.pname }</b> ${item.subTitle }</a></div>
								 <div class="Shop_name"></div>
								 <div class="p-operate">
								 	<a href="#" onclick=" return collect(${item.pid },${user.uid })" class="p-o-btn Collect" ><em></em><span id="sp_${item.pid }">收藏</span></a>
									<a href="#" onclick="return false" class="p-o-btn shop_cart"><em></em>联系我们</a>
								 </div>
							</div>
						</li>
					</c:forEach>
					</ul>
					<div class="Paging">
		    			<div class="Pagination">
		    				<c:if test="${resultInfo.result.pageNum == 1 }">
								<a style="background: #fff;border: 1px solid #ddd;color: #ccc">首页</a>
								<a style="background: #fff;border: 1px solid #ddd;color: #ccc" class="pn-prev disabled"><i>&lt;</i><em>上一页</em></a>
		     				</c:if>
		     				<c:if test="${resultInfo.result.pageNum != 1 }">
		     					<a href="mall?pageNum=1<c:if test="${!empty searchInfo }">${searchInfo }</c:if>">首页</a>
		     					<a href="mall?pageNum=${resultInfo.result.prePage }<c:if test="${!empty searchInfo }">${searchInfo }</c:if>" class="pn-prev disabled"><i>&lt;</i><em>上一页</em></a>
							</c:if>
							<c:forEach begin="1" end="${resultInfo.result.endNavPage }" var="p">
								<span  >
									<a <c:if test="${p == resultInfo.result.pageNum }"> style="border:0; background-color:#fff; color:#e4393c; font-weight:900;" </c:if> href="mall?pageNum=${p }<c:if test="${!empty searchInfo }">${searchInfo }</c:if>">${p }</a>
								</span>
							</c:forEach>
							<c:if test="${resultInfo.result.pageNum == resultInfo.result.totalPages }">
								<a style="background: #fff;border: 1px solid #ddd;color: #ccc" class="pn-next"><em>下一页</em><i>&gt;</i></a>
								<a style="background: #fff;border: 1px solid #ddd;color: #ccc">尾页</a>	
		     				</c:if>
							<c:if test="${resultInfo.result.pageNum != resultInfo.result.totalPages }">
								<a href="mall?pageNum=${resultInfo.result.nextPage }<c:if test="${!empty searchInfo }">${searchInfo }</c:if>" class="pn-next"><em>下一页</em><i>&gt;</i></a>
								<a href="mall?pageNum=${resultInfo.result.totalPages }<c:if test="${!empty searchInfo }">${searchInfo }</c:if>">尾页</a>	
		     				</c:if>
		     			
		     			</div>
		    		</div>
				</div>
			</c:if>
		</div>
	</div>
</div>
<!--网站地图-->
<div class="fri-link-bg clearfix" style="text-align: center;">
    <div class="fri-link">
        <div class="logo left margin-r20"><img src="/eyuan/statics/images/fo-logo.jpg" width="152" height="81" /></div>
        <div class="left"><img src="/eyuan/statics/images/qd.jpg" width="90"  height="90" />
            <p>扫描下载APP</p>
        </div>
       <div class="">
    <dl>
	 <dt>购物指南</dt>
     <dd><a href="#">购物流程</a></dd>
     <dd><a href="#">会员介绍</a></dd>
     <dd><a href="#">生活团购</a></dd>
     <dd><a href="#">订购方式</a> </dd>
     <dd><a href="#">隐私声明 </a></dd>
	</dl>
	<dl>
	 <dt>配送方式</dt>
	 <dd><a href="#">上门自提</a></dd>
     <dd><a href="#">211限时达</a></dd>
     <dd><a href="#">配送服务查询</a></dd>
     <dd><a href="#">配送费收取标准</a></dd>
     <dd><a href="#">海外配送</a></dd>
	</dl>
	<dl>
	 <dt>支付方式</dt>
	 <dd><a href="#">货到付款</a></dd>
     <dd><a href="#">在线支付</a></dd>
     <dd><a href="#">分期付款</a> </dd>
     <dd><a href="#">邮局汇款</a></dd>
     <dd><a href="#">公司转账</a></dd>
	</dl>	
    <dl>
	 <dt>售后服务</dt>
	 <dd><a href="#">售后政策</a></dd>
     <dd><a href="#">价格保护</a></dd>
     <dd><a href="#">退款说明</a> </dd>
     <dd><a href="#">返修/退换货</a></dd>
     <dd><a href="#">取消订单</a></dd>
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
 <!--右侧菜单栏样式-->
<div class="fixedBox">
  <ul class="fixedBoxList">
      <!-- <li class="fixeBoxLi user"><a href="#"> <span class="fixeBoxSpan"></span> <strong>消息中心</strong></a> </li> -->
    <!-- <li class="fixeBoxLi cart_bd" style="display:block;" id="cartboxs">
		<p class="good_cart">9</p>
			<span class="fixeBoxSpan"></span> <a href="car?action=carOrderList"><strong>购物车</strong></a>
			<div class="cartBox">
       			<div class="bjfff"></div><div class="message">购物车内暂无商品，赶紧选购吧</div>    
       		</div>
    </li> -->
    <li class="fixeBoxLi Service "><span class="fixeBoxSpan"></span><strong>客服</strong>
      <div class="ServiceBox">
        <div class="bjfffs"></div>
        <dl onclick="javascript:;">
		    <dt><img src="/eyuan/statics/images/hg.jpg" width="100%"></dt>
		       <dd><strong>QQ客服1</strong>
		          <p class="p1">9:00-22:00</p>
		           <p class="p2"><a href="http://wpa.qq.com/msgrd?v=3&amp;uin=123456&amp;site=DGG三端同步&amp;menu=yes">点击交谈</a></p>
		          </dd>
		        </dl>
				<dl onclick="javascript:;">
		          <dt><img src="/eyuan/statics/images/zly.jpg" width="100%"></dt>
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
			 <p><img src="/eyuan/statics/images/Eyuan.jpg" width="75%"/></p>
			 <p>微信扫一扫</p>
			 <p>关注我们</p>
			</div>		
			</div>
			</li>

    <li class="fixeBoxLi Home"> <a href="collect?action=collectList"> <span class="fixeBoxSpan"></span> <strong>收藏夹</strong> </a> </li>
    <li class="fixeBoxLi BackToTop"> <span class="fixeBoxSpan"></span> <strong>返回顶部</strong> </li>
  </ul>
</div>

<!-- 引入自己的js文件 -->
<script src="/eyuan/statics/myJS/cart.js" type="text/javascript"></script>
<script type="text/javascript">
	function collect(pid,uid){
		if (uid==null) {
			window.location.href="login.jsp";
			return;
		}
		$("#sp_"+pid).html("<span style='color: red;'>已收藏</span>");
		return false;
	}
</script>
</body>
</html>
