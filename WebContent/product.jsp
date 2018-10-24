<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URL"%>
<%@page import="com.eyuan.po.UserInfoPo"%>
<%@page import="java.net.HttpURLConnection"%>
<!DOCTYPE html>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Eyuan超市——商品</title>
<link rel="icon" href="statics/images/logo.png"> 
<link href="statics/css/base.css" rel="stylesheet" type="text/css" />
<link href="statics/css/css.css" rel="stylesheet" type="text/css" />
<link href="statics/css/style1.css" rel="stylesheet" type="text/css" />
<link href="statics/css/common.css" rel="stylesheet" type="text/css" />
<script src="statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="statics/js/common_js.js" type="text/javascript"></script>
<script type="text/javascript" src="statics/js/jquery-1.8.3.min.js"></script>
<script src="statics/js/jquery.simpleGal.js"></script>
<script type="text/javascript" src="statics/js/jquery.imagezoom.min.js"></script>
<script src="statics/dist/notice.js"></script>
<link href="statics/dist/noticejs.css" rel="stylesheet" type="text/css">
<link href="statics/dist/animate.css" rel="stylesheet" type="text/css">  
<style>
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
img {
	max-width: none;
}
.tb-pic a {
	display: table-cell;
	text-align: center;
	vertical-align: middle;
}
.tb-pic a img {
	vertical-align: middle;
}
.tb-pic a {
*display:block;
*font-family:Arial;
*line-height:1;
}
.tb-thumb {
	margin: 10px 0 0;
	overflow: hidden;
}
.tb-thumb li {
	float: left;
	width: 86px;
	height: 86px;
	overflow: hidden;
	border: 1px solid #cdcdcd;
	margin-right: 5px;
}
.tb-thumb li:hover, .tb-thumb .tb-selected {
	width: 84px;
	height: 84px;
	border: 2px solid #799e0f;
}
.tb-s310, .tb-s310 a {
	height: 365px;
	width: 365px;
}
.tb-s310, .tb-s310 img {
	max-height: 365px;
	max-width: 365px;
}
.tb-booth {
	border: 1px solid #CDCDCD;
	position: relative;
	z-index: 1;
}
div.zoomDiv {
	z-index: 999;
	position: absolute;
	top: 0px;
	left: 0px;
	background: #ffffff;
	border: 1px solid #ccc;
	display: none;
	overflow: hidden;
}
div.zoomMask {
	position: absolute;
	background: url("statics/images/mask.png") repeat;
	cursor: move;
	z-index: 1;
}
<!--弹出隐藏层-->
 .black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 1200px;
	background-color: black;
	z-index: 9999;
	-moz-opacity: 0.4;
	opacity: 0.40;
	filter: alpha(opacity=40);
}
.white_content {
	display: none;
	position: absolute;
	top: 20%;
	left: 40%;
	width: 400px;
	height: 175px;
	border: none;
	background-color: white;
	z-index: 100200;
	overflow: auto;
}
.white_content_small {
	display: none;
	position: absolute;
	top: 20%;
	left: 30%;
	width: 40%;
	height: 50%;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
.dialogbox {
	padding: 20px;
	line-height: 40px;
}
.addbtn {
	width: 22px;
	height: 22px;
	background: url(statics/images/close2.png) no-repeat;
	margin-right: 5px;
	margin-top: 3px;
	border: none;
	float: right;
}

.awcb{
display:inline-block;
width:100px;
height:100px;
}
.imgwcb{
width:100%;
}
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
<script type="text/javascript">
//弹出隐藏层
function ShowDiv(show_div,bg_div){
document.getElementById(show_div).style.display='block';
document.getElementById(bg_div).style.display='block' ;
var bgdiv = document.getElementById(bg_div);
bgdiv.style.width = document.body.scrollWidth;
// bgdiv.style.height = $(document).height();
$("#"+bg_div).height($(document).height());
};
//关闭弹出层
function CloseDiv(show_div,bg_div)
{
document.getElementById(show_div).style.display='none';
document.getElementById(bg_div).style.display='none';
};

</script>
</head>

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
<!--头部导航-->
<div class="nofix_head">
    <div class="top wrapper">
        <div class="float-lt margin-b10">
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
        </div>
        <div class="float-rt">
            <ul>
                <li><a href="/eyuan/index" >首页</a></li>
                <li><a href="/eyuan/user.jsp">我的Eyuan</a></li>
                <li><a id="linkOrder" href="">消息中心</a></li>
                <li><a href="/eyuan/index?action=listAll">商品分类</a></li>
                <li><a href="/eyuan/cart?action=cartOrderList">我的购物车<small class="num" id="shopping-amountTop">${cartCount }</small></a></li>
            </ul>
        </div>
    </div>
</div>
<!--头部导航END--> 

<!--头部快捷栏-->
<div class="clear wrapper header">

    <div class="logo float-lt" style="margin-right:130px;"><a href="index"><img src="statics/images/logo.png" /></div></a>
    <div class="search float-lt">
        <div class="search_list">
            <ul>
                <li class="current"><a href="#">产品</a></li>
                <li><a href="#">信息</a></li>
            </ul>
        </div>
        <div class="clear search_cur">
        <form action="index" method="get">
            <ul>
                <li>
                	<input type="hidden" name="action" value="serch"/>
                    <input name="keyWord" id="keyWord" class="search_box" onkeydown="keyDownSearch()" type="text">
                </li>
            </ul>
            <ul>
                <li class="search_btn"><input type="submit" value="搜索" style="color:white; background-color: rgb(144, 184, 48);border: none"/></li>
            </ul>
        </form>    
        </div>
        <div class="clear hotword">热门搜索词：香醋&nbsp;&nbsp;&nbsp;茶叶&nbsp;&nbsp;&nbsp;草莓&nbsp;&nbsp;&nbsp;葡萄&nbsp;&nbsp;&nbsp;菜油</div>
    </div>
    <!--购物车样式-->
	 <div class="hd_Shopping_list" id="Shopping_list">
	   <div class="s_cart" id="myCart"><a href="cart?action=cartOrderList" >我的购物车 &gt</a> <i class="ci-count" id="shopping-amount">${cartCount }</i></div>
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
<!--头部快捷栏END-->

<div class="clear">&nbsp;</div>

<!--网站头部-->
<div class="sup-wid">
	<div><img src="statics/images/TB27.gif" width="100%"/></div>
    <div class="supplie-top">
        <div class="clear">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="nav">
                <tr>
                    <td align="center"><a href="#">供应商首页</a></td>
                    <td align="center"><a href="#">全部产品</a></td>
                    <td align="center"><a href="#">企业介绍</a></td>
                    <td align="center"><a href="#">最新产品</a></td>
                    <td align="center"><a href="#">热销产品</a></td>
                    <td align="center"><a href="#">促销产品</a></td>
                </tr>
            </table>
        </div>
        <div class=" clear bread"><a href="#">首页</a> <span class="pipe">&gt;</span> <a href="#">某供应商</a> <span class="pipe">&gt;</span> <a href="#">某产品</a></div>
</div>
	<div class="pro_detail" >
        <div class="pro_detail_img float-lt">
            <div class="gallery">
                <div class="tb-booth tb-pic tb-s310"> <a href="statics/products/${product.image }/1/1.jpg"><img src="statics/products/${product.image }/1/1_mid.jpg"  alt="展品细节展示放大镜特效" rel="statics/products/${product.image }/1/1.jpg" class="jqzoom" /></a> </div>
                <ul class="tb-thumb" id="thumblist">
                
                	<li class="tb-selected">
                        <div class="tb-pic tb-s40"><a class="awcb" href="#"><img class="imgwcb" src="statics/products/${product.image }/1/1_small.jpg" mid="statics/products/${product.image }/1/1_mid.jpg" big="statics/products/${product.image }/1/1.jpg"></a></div>
                    
                    <li>
                        <div class="tb-pic tb-s40"><a class="awcb" href="#"><img class="imgwcb" src="statics/products/${product.image }/2/2_small.jpg"  mid="statics/products/${product.image }/2/2_mid.jpg" big="statics/products/${product.image }/2/2.jpg"></a></div>
                    </li>
                    <li>
                        <div class="tb-pic tb-s40"><a class="awcb" href="#"><img class="imgwcb" src="statics/products/${product.image }/3/3_small.jpg"  mid="statics/products/${product.image }/3/3_mid.jpg" big="statics/products/${product.image }/3/3.jpg"></a></div>
                    </li>
                    <li style="margin-right:0px;">
                        <div class="tb-pic tb-s40"><a class="awcb" href="#"><img class="imgwcb" src="statics/products/${product.image }/4/4_small.jpg"  mid="statics/products/${product.image }/4/4_mid.jpg" big="statics/products/${product.image }/4/4.jpg"></a></div>
                    </li>
                </ul>
            </div>
        <script type="text/javascript">
        $(function(){
				$("#h1").toggle(function(){
					$("#h1").css("background-image","url('statics/images/iconfont-xingxingman_add.png')");
				},function(){
					$("#h1").css("background-image","url('statics/images/iconfont-xingxingman_add.png') ");
				})
			}) 
		</script>
		<!-- 用户为空，不显示收藏 -->
		<c:if test="${!empty user }">
			<input  type="button" <c:if test="${empty uColl }">value="加入收藏"</c:if>  <c:if test="${!empty uColl }"> value="已收藏" style="background-image: url('statics/images/iconfont-xingxingman_add.png');" </c:if>  id="h1" class="addcart" onclick="collect(${product.pid })"/>
		</c:if>
     <script type="text/javascript">
     	function collect(pid){
     		//发送ajax
     		$.ajax({
     			url:"collect",
     			type:"post",
     			data:{"action":"addCollect","pid":pid},
     			success:function(result){
     				if(result==1){
     					//Dom操作
     					$("#h1").val("已收藏");
     					$("#h1").css("background-image","url('statics/images/iconfont-xingxingman_add.png') ");
     				}else{
     					return;
     				}
     			}
     		});
     	}
           
     </script>
        </div>
        <div class="float-lt pro_detail_con">
            <div class="pro_detail_tit">${product.pname }&nbsp;&nbsp;${product.subTitle }</div>
            <div class="pro_detail_ad">${product.detail }</div>
            <div class="pro_detail_score margin-t20">
                <ul>
                    <li class="margin-r20">评分</li>
                </ul>
                
                <ul>
                    <li style="width:16px; height:16px;"><img src="statics/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="statics/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="statics/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="statics/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="statics/images/iconfont-xingxingkong.png" width="16" height="16" /></li>
                </ul>
            </div>
            <div class="clear"></div>
            <div class="pro_detail_price  margin-t20"><span class="margin-r20">市场价</span><span style=" font-size:16px"><s>￥${product.price*1.2 }</s></span></div>
            <div class="clear"></div>
            <div class="pro_detail_act margin-t20 fl"><span class="margin-r20">售价</span><span id="price" style="font-size:26px; font-weight:bold; color:#dd514c;">￥${product.price }</span></div>
            <div class="clear"></div>
            <div class="act_block margin-t5"><span>本商品可使用9999积分抵用￥9.99元</span></div>
            <div class="pro_detail_number margin-t30">
              
                <div class="margin-r20 float-lt">数量</div>
                <div class=""> <i class="jian"></i>
                <form action="userOrder" method="post" id="myform">
                	<input type="hidden" name="action" value="nowPay">
                	<input type="hidden" name="pid" value="${product.pid }">
                	<input type="hidden" name="price" value="${product.price }">
                	<input type="hidden" name="image" value="${product.image }">
                	<input type="hidden" name="subTitle" value="${product.subTitle}">
                	<input type="hidden" name="pname" value="${product.pname}">
                	<input type="hidden" id="size" name="size" value="1">
                    <input type="text" value="1" name="num" class="float-lt choose_input" id="number"/>
                   </form>
                    <i class="jia"></i> <span>&nbsp;盒</span> <span>（库存${product.num }盒）</span> </div>
                <div class="clear"></div>
            </div>
            <div class="guige">
                <div class="margin-r20 float-lt" style="line-height:25px;">规格</div>
                <ul id="myUl">
                    <li class="guige-cur" onclick="hi01();">规格一</li>
                    <li onclick="hi02();">规格二</li>
                    <li onclick="hi03();">规格三</li>
                </ul>
                <div class="clear"></div>
            </div>
            <div class="pro_detail_number margin-t20">
                <div class="margin-r20 float-lt">月成交量：<span class="colorred"><strong>999件</strong></span></div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
            <input type="hidden" id="cartPrice" value="${product.price }">
            <input type="hidden"  id="pid" value="${product.pid }">
          
            <div class="pro_detail_btn margin-t30">
                <ul>
                    <li class="pro_detail_shop"><a href="" onclick="return myClick()">立即购买</a></li>  <!-- 参数要加用户Id -->
                    <li class="pro_detail_add"><a href="#" onclick="return submitCart()">加入购物车</a></li>
                    <!-- ShowDiv('MyDiv','fade') -->
                </ul>
            </div>
        </div>
        
        
        
<!-- 前台规格显示价格DOM操作 -->       
<script type="text/javascript">

function hi01(){
	$("#size").val(1);
}
function hi02(){
	$("#size").val(2);
}
function hi03(){
	$("#size").val(3);
}



function myClick() {
	$("#myform").submit();
	return false;
}


$(function(){
	var myUl = $("#myUl");
	var lis = myUl.children();
	//动态给每个规格加一个点击事件，并给产品规格赋值
	lis.eq(0).click(function(){
		$(this).attr("class","guige-cur");
		$("#price").html("￥${product.price * 1.0  }");
		lis.eq(1).attr("class","");
		lis.eq(2).attr("class","");
	});
	
	lis.eq(1).click(function(){
		$(this).attr("class","guige-cur");
		$("#price").html("￥${product.price * 1.2  }");
		lis.eq(0).attr("class","");
		lis.eq(2).attr("class","");
	});
	
	lis.eq(2).click(function(){
		$(this).attr("class","guige-cur");
		$("#price").html("￥${product.price * 1.5  }");
		lis.eq(0).attr("class","");
		lis.eq(1).attr("class","");
	});
	
	$("[class='jian']").click(function(){
		var number = $("#number").val();
		var s = parseInt(number);
		if (s==1) {
			$("#number").val(1);
			return;
		}
		$("#number").val(s-1);
	});
	
	$("[class='jia']").click(function(){
		var number = $("#number").val();
		 var s = parseInt(number);
		 var num = "${product.num }";
		 var num1 = parseInt(num);
		 if(s==num1){
			 $("#number").val(num1);
			 return;
		 }
		$("#number").val(s+1);
	});
	
	$("#number").blur(function(){
		var number = $("#number").val();
		var s = parseInt(number);
		var num = "${product.num }";
		var num1 = parseInt(num);
		if(s<1){
			$("#number").val(1);
			return;
		}
		if(s>num1){
			$("#number").val(num1);
			return;
		}
	});
	
});
</script>
        
        
        
        
    <div class="clear"></div>
    <script>
		$(function(){
			$(".pro_tab li").each(function(i){
				$(this).click(function(){
					$(this).addClass("cur").siblings().removeClass("cur");
					$(".conlist .conbox").eq(i).show().siblings().hide();
				})
			})
		})
	</script>
    <div class="pro_con margin-t55" style="overflow:hidden;">
        <div class="pro_tab">
            <ul>
                <li class="cur">产品介绍</li>
                <li>规格及包装</li>
                <li>评价</a></li>
            </ul>
        </div>
        <div class="conlist">
            <div class="conbox" style="display:block;">1</div>
            <div class="conbox">2</div>
            <div class="conbox">
                <div class="pro_judge">
                    <ul>
                        <li class="cur">
                            <input name="RadioGroup1" type="radio" value="" checked="checked" id="RadioGroup1_0" />
                            全部（100）</li>
                        <li>
                            <input name="RadioGroup1" type="radio" value="" id="RadioGroup1_1" />
                            好评（80）</li>
                        <li>
                            <input name="RadioGroup1" type="radio" value="" id="RadioGroup1_2" />
                            中评（10）</li>
                        <li>
                            <input name="RadioGroup1" type="radio" value="" id="RadioGroup1_3" />
                            差评（10）</li>
                    </ul>
                    <table width="100%" border="0">
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        <tr>
                            <td width="80" align="left"><a href="" rel="statics/images/01_mid.jpg" class="preview"><img src="statics/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="hotpro">
        <div class="hotpro_title">热销产品</div>
        <div class="hotpro_box">
            <div class="pro-view-hot">
                <ul>
                    <li class="pro-img"><a href="product?pid=40"><img src="statics/products/p40/2/2_mid.jpg" /></a></li>
                    <li class="price"><strong>￥ 256.00</strong><span>已销售1018</span></li>
                    <li><a href="product?pid=40" class="title">阳澄湖大闸蟹  现货 俏苏阁阳澄湖大闸蟹4对(公3.5两,母2.5两) 正宗礼盒鲜活螃蟹 </a></li>
                </ul>
                <ul>
                    <li class="pro-img"><a href="product?pid=38"><img src="statics/products/p38/1/1_mid.jpg" /></a></li>
                    <li class="price"><strong>￥ 235.9</strong><span>已销售998</span></li>
                    <li><a href="product?pid=38" class="title">洋河梦之蓝M3-52度  500ml*2礼盒装猫超自营酒厂直供 </a></li>
                </ul>
                <ul>
                    <li class="pro-img"><a href="product?pid=39"><img src="statics/products/p39/3/3_mid.jpg" /></a></li>
                    <li class="price"><strong>￥ 12.6</strong><span>已销售889</span></li>
                    <li><a href="product?pid=39" class="title">蜀道香  麻辣牛肉干100g四川成都特产 辣味零食好吃的小吃肉类零食</a></li>
                </ul>
                <ul>
                    <li class="pro-img"><a href="product?pid=10"><img src="statics/products/p10/2/2_mid.jpg" /></a></li>
                    <li class="price"><strong>￥ 238.00</strong><span>已销售785</span></li>
                    <li><a href="product?pid=10" class="title">张裕  红酒优选级赤霞珠 干红葡萄酒750ml*6整箱 </a></li>
                </ul>
                <ul>
                    <li class="pro-img"><a href="product?pid=36"><img src="statics/products/p36/3/3_mid.jpg" /></a></li>
                    <li class="price"><strong>￥ 29.9</strong><span>已销售765</span></li>
                    <li><a href="product?pid=36" class="title">Zespri佳沛  新西兰阳光金奇异果6个92-114g/个猕猴桃新鲜水果</a></li>
                </ul>
                <ul style="margin-right:0;">
                    <li class="pro-img"><a href="product?pid=9"><img src="statics/products/p9/1/1_mid.jpg" /></a></li>
                    <li class="price"><strong>￥ 39.9</strong><span>已销售666</span></li>
                    <li><a href="product?pid=9" class="title">Franzzi  Franzzi/法丽兹巧克力曲奇量贩装4口味380g饼干零食网红大礼包 </a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="helper">
        <div class="mod">
            <div class="mod-wrap">
                <h4><img src="statics/images/h1.png" width="60" height="60" /><span>新手上路</span> </h4>
            </div>
        </div>
        <div class="mod">
            <div class="mod-wrap">
                <h4><img src="statics/images/h2.png" width="60" height="60" /><span>如何支付</span> </h4>
            </div>
        </div>
        <div class="mod">
            <div class="mod-wrap">
                <h4><img src="statics/images/h3.png" width="60" height="60" /><span>配送运输</span> </h4>
            </div>
        </div>
        <div class="mod mod-last">
            <div class="mod-wrap">
                <h4><img src="statics/images/h4.png" width="60" height="60" /><span>售后服务</span> </h4>
            </div>
        </div>
        <div class="mod mod-last">
            <div class="mod-wrap">
                <h4><img src="statics/images/h5.png" width="60" height="60" /><span>联系我们</span> </h4>
            </div>
        </div>
    </div>
    
</div>

<div class="clear">&nbsp;</div>


<!--网站地图-->
<div class="fri-link-bg">
    <div class="fri-link">
        <div class="logo float-lt margin-r20"><img src="statics/images/logo.png" width="152" height="81" /></div>
        <div class="float-lt"><img src="statics/images/qd.jpg" width="90"  height="90" />
            <p>扫描下载APP</p>
        </div>
        <ul class="link-add float-lt ma">
            <li><a href="#" class="font14">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
        </ul>
        <ul class="link-add float-lt">
            <li><a href="#" class="font14">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
        </ul>
        <ul class="link-add float-lt">
            <li><a href="#" class="font14">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
        </ul>
        <ul class="link-add float-lt">
            <li><a href="#" class="font14">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
        </ul>
        <ul class="link-add float-lt">
            <li><a href="#" class="font14">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
        </ul>
        <ul class="link-add float-lt">
            <li><a href="#" class="font14">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
        </ul>
        <ul class="link-add float-lt">
            <li><a href="#" class="font14">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
            <li><a href="#">网站栏目</a></li>
        </ul>
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
<!--网站页脚END-->





<!--弹出层时背景层DIV--> 

<!--商品添加成功DIV-->
<div id="fade" class="black_overlay"> </div>
<div id="MyDiv" class="white_content">
    <div  style="width:385px; height:30px; background:#1ba67f; padding-left:15px; color:#fff; line-height:30px; font-size:14px;"> <span onclick="CloseDiv('MyDiv','fade')">
        <input type="button" class="addbtn">
        </span>商品加入货仓 </div>
    <div class="dialogbox">
        <p>商品添加成功！</p>
    </div>
</div>
</div>

<!--商品收藏成功DIV-->
<div id="fade2" class="black_overlay"> </div>
<div id="MyDiv2" class="white_content">
    <div  style="width:385px; height:30px; background:#1ba67f; padding-left:15px; color:#fff; line-height:30px; font-size:14px;"> <span onclick="CloseDiv('MyDiv2','fade2')">
        <input type="button" class="addbtn">
        </span>商品收藏 </div>
    <div class="dialogbox">
        <p>商品收藏成功！</p>
    </div>
</div>
</div>

<!-- 引入cart.js文件 -->
<script src="statics/myJS/cart.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$(".jqzoom").imagezoom();
	
	$("#thumblist li a").mousemove(function(){
		$(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
		$(".jqzoom").attr('src',$(this).find("img").attr("mid"));
		$(".jqzoom").attr('rel',$(this).find("img").attr("big"));
	});

});
</script>
</body>
</html>
