<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.eyuan.po.Product"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eyuan.po.Pclass"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URL"%>
<%@page import="com.eyuan.po.UserInfoPo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html >
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="statics/css/common.css" rel="stylesheet" type="text/css" />
<link href="statics/css/style.css" rel="stylesheet" type="text/css" />
<script src="statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="statics/js/common_js.js" type="text/javascript"></script>
<script src="statics/js/footer.js" type="text/javascript"></script>
<script src="statics/dist/notice.js"></script>
<link href="statics/dist/noticejs.css" rel="stylesheet" type="text/css">
<link href="statics/dist/animate.css" rel="stylesheet" type="text/css"> 
<link rel="icon" href="statics/images/logo.png"> 
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
<title>Eyuan超市</title>
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
		   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/user.jsp">我的Eyuan</a> </li>
		   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="#">消息中心</a></li>
	       <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/index?action=listAll">商品分类</a></li>
	       <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="/eyuan/cart?action=cartOrderList">我的购物车<b id="shopping-amountTop">${cartCount }</b></a></li>	
		  </ul>
		</div>
	    </div>
	  </div>
	  <div id="header"  class="header page_style">
	<!--logo-->
	<div class="logo"><a href="index"><img src="statics/images/logo.png" /></a></div>
	<!--结束图层，搜索框-->
	 <div class="Search">
        <div class="search_list">
            <ul>
                <li class="current"><a href="#">产品 </a></li>
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
			<li><a href="other/map2.jsp">你身边的超市</a></li>
			<li><a href="#">预售专区</a><em class="hot_icon"></em></li>
			<li><a href="mall">商城</a></li>
			
			<li><a href="/eyuan/user.jsp">个人中心</a></li>
			<li><a href="#">热销活动</a></li>
			<li><a href="other/map.jsp">联系我们</a></li>
		 </ul>			 
		</div>
		<script>$("#Navigation").slide({titCell:".Navigation_name li",trigger:"click"});</script>
    </div>
    </head>
    <!--广告幻灯片样式-->
   	<div id="slideBox" class="slideBox">
			<div class="hd">
				<ul class="smallUl"></ul>
			</div>
			<div class="bd">
				<ul>
					<li><a href="/eyuan/product?pid=40" target="_blank"><div style="background:url(/eyuan/statics/img/jm_03.PNG) no-repeat rgb(226, 155, 197); background-position:center; width:100%; height:480px; margin-top:-15px"></div></a></li>
					<li><a href="/eyuan/product?pid=41" target="_blank"><div style="background:url(/eyuan/statics/img/jm_04.PNG) no-repeat #f7ddea; background-position:center; width:100%; height:450px;"></div></a></li>
					<li><a href="/eyuan/product?pid=36" target="_blank"><div style="background:url(/eyuan/statics/img/jm_01.PNG) no-repeat; background-position:center; width:100%; height:450px;"></div></a></li>
					<li><a href="/eyuan/product?pid=43" target="_blank"><div style="background:url(/eyuan/statics/img/jm_02.PNG) no-repeat; background-position:center ; width:100%; height:450px;"></div></a></li>
                    <li><a href="/eyuan/product?pid=42" target="_blank"><div style="background:url(/eyuan/statics/img/jm_05.PNG) no-repeat  #F60; background-position:center; width:100%; height:450px;"></div></a></li>
				</ul>
			</div>
			<!-- 下面是前/后按钮-->
			<a class="prev" href="javascript:void(0)"></a>
			<a class="next" href="javascript:void(0)"></a>

		</div>
		<script type="text/javascript">
		jQuery(".slideBox").slide({titCell:".hd ul",mainCell:".bd ul",autoPlay:true,autoPage:true});
		</script>
	</div>
	<div id="mian">
 	<div class="clearfix marginbottom">	
 	<!--产品分类样式-->
	  <div class="Menu_style" id="allSortOuterbox">
	   <div class="title_name"><em></em>所有商品分类</div>
	   <div class="content hd_allsort_out_box_new">
	    <ul class="Menu_list">
	    	<!--第一类-->
	      <!-- <li class="name">
			<div class="Menu_name"><a href="product_list.html" >茶品类</a> <span>&lt;</span></div>
			<div class="link_name">
			  <p>
	          <a href="Product_Detailed.html">茅台</a> | 
	          <a href="#">五粮液</a> | 
	          <a href="#">郎酒</a> | 
	          <a href="#">剑南春</a>
	          <a href="Product_Detailed.html">茅台</a> | 
	          <a href="#">五粮液</a> | 
	          <a href="#">郎酒</a> | 
	          <a href="#">剑南春</a>
	          </p>
			</div>
			第一类详情
			<div class="menv_Detail">
			 <div class="cat_pannel clearfix">
			   <div class="hd_sort_list">
			    <dl class="clearfix" data-tpc="1">
				 <dt><a href="#">面膜<i>></i></a></dt>
				 <dd><a href="#">撕拉面膜</a><a href="#">面膜贴</a><a href="#">免洗面膜</a><a href="#">水洗面膜</a></dd> 
				</dl>

			   </div>
			  </div>
			</div>		 
			</li> -->
			<c:forEach items="${pclass }" var="item">
				<li class="name">
				<div class="Menu_name"><a href="index?action=listFu&parentid=${item.key.cid }" >${item.key.cname }</a><span>&lt;</span></div>
				<div class="link_name">
				<c:forEach items="${item.value }" var="item2" varStatus="idx">
					<c:if test="${idx.index<item.value.size()-1 }">
						<a href="index?action=listZi&cid=${item2.cid }">${item2.cname } </a>|
					</c:if>
					 <c:if test="${idx.index==item.value.size()-1 }">
						<a href="index?action=listZi&cid=${item2.cid }">${item2.cname } </a>
					</c:if>
				</c:forEach>
				</div>
				<div class="menv_Detail">
			 <div class="cat_pannel clearfix">
			   <div class="hd_sort_list">
			    <dl class="clearfix" data-tpc="1">
				 <dt><a href="index?action=listFu&parentid=${item.key.cid }">${item.key.cname }<i>></i></a></dt>
				 <dd>
				 <c:forEach items="${item.value }" var="item2">
					<a href="index?action=listZi&cid=${item2.cid }"> ${item2.cname } </a>
				</c:forEach>
				 </dd> 
				</dl>

			   </div>
			  </div>
			</div>		 
			</li>
			</c:forEach>
			
	    </ul>
	   </div>
	  </div>
	  <script>$("#allSortOuterbox").slide({ titCell:".Menu_list li",mainCell:".menv_Detail",	});</script>
 	  <!--产品栏切换-->
	  <div class="product_list left">
	  		<div class="slideGroup">
				<div class="parHd">
					<ul><li>新品上市</li><li>超值特惠</li><li>本期团购</li><li>产品精选</li><li>抢先一步</li></ul>
				</div>
				<div class="parBd">
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<c:forEach items="${products }" var="item" begin="0" end="3">
									<li>
									<div class="pic"><a href="product?pid=${item.pid }" target="_blank"><img src="statics/products/${item.image }/1/1.jpg" /></a></div>
									<div class="title">
	                                <a href="product?pid=${item.pid }" target="_blank" class="name">${item.pname }&nbsp; ${item.subTitle }</a>
	                                <h3><b>￥</b>${item.price }</h3>
	                                </div>
	                                </li>
								</c:forEach>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div><!-- slideBox End -->
	
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<c:forEach items="${products }" var="item" begin="4" end="7">
									<li>
									<div class="pic"><a href="product?pid=${item.pid }" target="_blank"><img src="statics/products/${item.image }/1/1.jpg" /></a></div>
									<div class="title">
	                                <a href="product?pid=${item.pid }" target="_blank" class="name">${item.pname }&nbsp; ${item.subTitle }</a>
	                                <h3><b>￥</b>${item.price }</h3>
	                                </div>
	                                </li>
								</c:forEach>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div><!-- slideBox End -->
	
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<c:forEach items="${products }" var="item" begin="8" end="11">
									<li>
									<div class="pic"><a href="product?pid=${item.pid }" target="_blank"><img src="statics/products/${item.image }/1/1.jpg" /></a></div>
									<div class="title">
	                                <a href="product?pid=${item.pid }" target="_blank" class="name">${item.pname }&nbsp; ${item.subTitle }</a>
	                                <h3><b>￥</b>${item.price }</h3>
	                                </div>
	                                </li>
								</c:forEach>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div><!-- slideBox End -->
	                    	<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
							   <c:forEach items="${products }" var="item" begin="12" end="15">
									<li>
									<div class="pic"><a href="product?pid=${item.pid }" target="_blank"><img src="statics/products/${item.image }/1/1.jpg" /></a></div>
									<div class="title">
	                                <a href="product?pid=${item.pid }" target="_blank" class="name">${item.pname }&nbsp; ${item.subTitle }</a>
	                                <h3><b>￥</b>${item.price }</h3>
	                                </div>
	                                </li>
								</c:forEach>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div><!-- slideBox End -->
	                    	<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
							   <c:forEach items="${products }" var="item" begin="16" end="19">
									<li>
									<div class="pic"><a href="product?pid=${item.pid }" target="_blank"><img src="statics/products/${item.image }/1/1.jpg" /></a></div>
									<div class="title">
	                                <a href="product?pid=${item.pid }" target="_blank" class="name">${item.pname }&nbsp; ${item.subTitle }</a>
	                                <h3><b>￥</b>${item.price }</h3>
	                                </div>
	                                </li>
								</c:forEach>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div><!-- slideBox End -->
	
				</div><!-- parBd End -->
			</div>
	        <script type="text/javascript">
				/* 内层图片无缝滚动 */
				jQuery(".slideGroup .slideBoxs").slide({ mainCell:"ul",vis:4,prevCell:".sPrev",nextCell:".sNext",effect:"leftMarquee",interTime:50,autoPlay:true,trigger:"click"});
				/* 外层tab切换 */
				jQuery(".slideGroup").slide({titCell:".parHd li",mainCell:".parBd"});
			</script>
	        <!--广告样式-->
	        <div class="Ads_style">
	        	<a href="/eyuan/product?pid=37" target="_blank"><img src="statics/img/AD_01.jpg" width="318" height="345px"/></a>
	        	<a href="/eyuan/product?pid=38" target="_blank"><img src="statics/img/AD_02.png" width="318" height="345px"/></a>
	        	<a href="/eyuan/product?pid=39" target="_blank"><img src="statics/img/AD_03.jpg" width="318" height="345px"/></a>
	        </div>
	  </div>
	 </div>		
<!--板块栏目样式-->
    	<%	Map<Pclass, List<Pclass>> pclass = (Map)request.getAttribute("pclass");//获取作用域内商品类对象map集合
    		List<Product> products = (List<Product>)request.getAttribute("products");//获取作用域内商品对象集合
    		Set<Pclass> keySet = pclass.keySet();
    		Iterator<Pclass> it = keySet.iterator();
    		Map<String,List<Product>> myMap = new HashMap<>();
    		List<Pclass> pclasses = new ArrayList<>();
    		while(it.hasNext()){//遍历商品类map集合
    			Pclass key = it.next();//商品父类
    			pclasses.add(key);
                List<Pclass> value = pclass.get(key);//商品子类
                int[] myArr = new int[value.size()];//定义父类商品的子类商品id数组
                for(int i = 0 ; i<value.size(); i++){
                	myArr[i]=value.get(i).getCid();
                }
                Arrays.sort(myArr);
                List<Product> myList = new ArrayList<>();
                for(int i = 0 ;i<products.size();i++){//遍历商品集合
                	if(Arrays.binarySearch(myArr, products.get(i).getCid())>=0){
                		myList.add(products.get(i));
                	}
                }
                myMap.put(key.getCname(), myList);
    		}
    		request.setAttribute("myMap", myMap);
    		request.setAttribute("pclasses", pclasses);
    		%>
 <!--板块一-->
 <div class="clearfix Plate_style">
  <div class="Plate_column Plate_column_left" style="width: 1210px">
    <div class="Plate_name">
    <h2>产品大类</h2>
    <script type="text/javascript">
    	function chooseType(cid) {
<%--     		<c:if test="${resultInfo.code == 0 }">
				<h2>${resultInfo.msg }</h2>
			</c:if>
    		var str = '<c:forEach items="${myMap.get(pclasses.get(0).cname)}" var="item">'+
    			      '<li class="product_display">'+
				   	     '<a href="" class="Collect"><em></em>收藏</a>'+
				   	     '<a href="#" class="img_link"><img src="statics/products/${item.image }/1/1.jpg"  width="140" height="140"/></a>'+
				   	     '<a href="#" class="name">${item.pname }</a>'+
				   	     '<h3><b>￥</b>${item.price }</h3>'+
				   	    '<div class="Detailed">'+
				   		   '<div class="content">'+
				   			  '<p class="center"><a href="#" class="Buy_btn">立即购买</a></p>'+
				   			  '</div>'+
				   		   '</div>'+
				        '</li>'+
    				'</c:forEach>';
    				$("#lists").html(str);
    		
    		//var str = ${myMap.get("美容洗护") };
    		//console.log(str);
    		//console.log(<%=myMap %>);
			return false; --%>
			$.ajax({
				type: "POST",
			   	url: "/eyuan/index",
			   	data: {"action":"listByParentId","cid":cid},
			   	success: function(products){
			   		var str = "";
			   		for(var i = 0 ;i<products.length;i++){
			   			str += '<li class="product_display">'+
						   	     '<a href="#" class="Collect"><em></em>收藏</a>'+
						   	     '<a href="/eyuan/product?pid='+products[i].pid+'" class="img_link" target="_blank"><img src="statics/products/'+products[i].image+'/1/1.jpg"  width="140" height="140"/></a>'+
						   	     '<a href="/eyuan/product?pid='+products[i].pid+'" class="name" target="_blank">'+products[i].pname+'</a>'+
						   	     '<h3><b>￥</b>'+products[i].price+'</h3>'+
						   	    '<div class="Detailed" style="display:none">'+
						   		   '<div class="content">'+
						   			  '<p class="center"><a href="#" class="Buy_btn">立即购买</a></p>'+
						   			  '</div>'+
						   		   '</div>'+
						        '</li>';
			   		}
			   		$("#lists").html(str);
			   	}
			});
			return false;
		}

    </script>
    <div class="Sort_link">
    	<c:forEach items="${pclass }" var="item">
			<a href="#" class="name" onclick="return chooseType('${item.key.cid }')">${item.key.cname }</a>	
		</c:forEach>
    </div>
    <a href="#" class="Plate_link"> <img src="statics/images/bk_img_14.png" /></a>
    </div>
    <div class="Plate_product" style="width: 1010px">
    
    <ul id="lists">		
    <c:forEach items='${myMap.get(pclasses.get(0).cname) }' var="item" varStatus="idx">
   	 <c:if test="${idx.index<10 }">
      <li class="product_display">
	     <a href="#" class="Collect" id="myaa" onclick="return collect(${item.pid })"><em></em><span id="sp_${item.pid }">收藏</span></a>
	     <a href="/eyuan/product?pid=${item.pid }" target="_blank" class="img_link"><img src="statics/products/${item.image }/1/1.jpg"  width="140" height="140"/></a>
	     <a href="/eyuan/product?pid=${item.pid }" target="_blank" class="name">${item.pname }</a>
	     <h3><b>￥</b>${item.price }</h3>
	    <div class="Detailed">
		   <div class="content">
		      <form action="userOrder" method="post" id="myform_${item.pid }" target="_blank">
                	<input type="hidden" name="action" value="nowPay">
                	<input type="hidden" name="pid" value="${item.pid }">
                	<input type="hidden" name="price" value="${item.price }">
                	<input type="hidden" name="image" value="${item.image }">
                	<input type="hidden" name="subTitle" value="${item.subTitle}">
                	<input type="hidden" name="pname" value="${item.pname}">
                	<input type="hidden"  name="size" value="1">
                    <input type="hidden" value="1" name="num"  />
                   </form>
		   
		   
			  <p class="center"><a href="" class="Buy_btn" onclick="return myClick(${item.pid })">立即购买</a></p>
			  </div>
		   </div>
		</c:if>	   
     </li>
    </c:forEach>
     
    </ul>
    </div>
  </div>
  	 <script type="text/javascript">
	  	function myClick(pid) {
	  		$("#myform_"+pid).submit();
	  		return false;
	  	}

     	function collect(pid){
     		//发送ajax
     		$.ajax({
     			url:"collect",
     			type:"post",
     			data:{"action":"addCollect","pid":pid},
     			success:function(result){
     				if(result==1){
     					//Dom操作
     					$("#sp_"+pid).html("已收藏");
     				}else{
     					console.log(1);
     					return false;
     				}
     			}
     		});
     		return false;
     	}
      </script>
  <!--板块二-->
 <div class="Plate_column Plate_column_right">
<!--     <div class="Plate_name">
    <h2>产品名称</h2>
    <div class="Sort_link"><a href="#" class="name">分类名称</a><a href="#" class="name">分类名称</a><a href="#" class="name">分类名称</a><a href="#" class="name">分类名称</a><a href="#" class="name">分类名称</a><a href="#" class="name">分类名称</a><a href="#" class="name">分类名称</a></div>
    <a href="#" class="Plate_link"> <img src="statics/images/bk_img_19.png" /></a>
   
    </div> -->
   <!--  <div class="Plate_product">
    <ul id="lists">
     <li class="product_display">
     <a href="" class="Collect"><em></em>收藏</a>
     <a href="#" class="img_link"><img src="statics/products/p_15.jpg"  width="140" height="140"/></a>
     <a href="#" class="name">墨西哥原装进口 科罗娜啤酒</a>
     <h3><b>￥</b>34.00</h3>
    <div class="Detailed">
	   <div class="content">
		  <p class="center"><a href="#" class="Buy_btn">立即购买</a></p>
		  </div>
	   </div>
     </li>
     <li class="product_display">
      <a href="" class="Collect"><em></em>收藏</a>
     <a href="#" class="img_link"><img src="statics/products/p_13.jpg"  width="140" height="140"/></a>
     <a href="#" class="name">墨西哥原装进口 科罗娜啤酒</a>
     <h3><b>￥</b>34.00</h3>
      <div class="Detailed">
	   <div class="content">
		  <p class="center"><a href="#" class="Buy_btn">立即购买</a></p>
		  </div>
	   </div>
     </li>
     <li class="product_display">
      <a href="" class="Collect"><em></em>收藏</a>
     <a href="#" class="img_link"><img src="statics/products/p_12.jpg"  width="140" height="140"/></a>
     <a href="#" class="name">墨西哥原装进口 科罗娜啤酒</a>
     <h3><b>￥</b>34.00</h3>
       <div class="Detailed">
	   <div class="content">
		  <p class="center"><a href="#" class="Buy_btn">立即购买</a></p>
		  </div>
	   </div>
     </li>
     <li class="product_display">
      <a href="" class="Collect"><em></em>收藏</a>
     <a href="#" class="img_link"><img src="statics/products/p_11.jpg"  width="140" height="140"/></a>
     <a href="#" class="name">墨西哥原装进口 科罗娜啤酒</a>
     <h3><b>￥</b>34.00</h3>
     <div class="Detailed">
	   <div class="content">
		  <p class="center"><a href="#" class="Buy_btn">立即购买</a></p>
		  </div>
	   </div>
     </li>
     
    </ul>
    </div> -->
  </div>

 </div>	
</div>
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
<script src="statics/myJS/cart.js" type="text/javascript"></script>
<script src="statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="statics/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="statics/js/common_js.js" type="text/javascript"></script>
<script src="statics/js/footer.js" type="text/javascript"></script>
</body>
</html>
