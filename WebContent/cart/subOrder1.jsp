<%@page import="com.eyuan.po.vo.CartProduct"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<<script type="text/javascript">
/****************删除购物车记录（订单结算界面）******************/
function delectCart(cartid){
	
	$.ajax({
		type: "get",
		   url: "/eyuan/cart",
		   data: {"action":"deleteCart","cartid":cartid},
		   success: function(row){//删除成功时的操作
			   if (row == "1") {
				   $("#tr_"+cartid).remove();//1、删除页面改行记录
				   var total = 0.0;
					$("input[name='myck']:checkbox").each(function() { //2、计算并刷新总价
						if($(this).is(":checked")){ 
							total+=parseFloat($(this).parent().parent().children().eq(3).attr("price"));
							} 
						});
					$("#total").html("总计：￥"+total);
					if(total==0){
						location.reload();//3、删除所有记录时刷新当前界面
					}
					new NoticeJs({
					    text: '删除成功！',
					    position: 'topRight',
					     animation: {
					        open: 'animated bounceIn',
					        close: 'animated bounceOut'
					    } 
					}).show();
					
			   }else{
					new NoticeJs({
					    text: '删除失败！',
					    position: 'topRight',
					     animation: {
					        open: 'animated bounceIn',
					        close: 'animated bounceOut'
					    } 
					}).show();
			   }
		   }
	});
	return false;
}
</script>
	<c:if test="${empty cartsProduct }">
		<div class="div4">

			<div style="height: 80px"></div>
			<span><img src="statics/img/cart.PNG"><h3 >购物车空空的哦~，去看看心仪的商品吧~</h3><a href="index">去购物 &gt; </a>
		
		</div>

	</c:if>
	<c:if test="${!empty cartsProduct }">
	<div class="div2"><img src="statics/img/car1.jpg" /></div>
	<div class="div1"><h2>商品详情</h2></div>
	<div class="div2">
		<table align="center" >
			<tr class="div1">
				<th width="50" >选项</th>
				<th width="480">商品</th>
				<th width="140">数量</th>
				<th width="140">总金额</th>
				<th width="140">操作</th>
			</tr>
			<%double total = 0;
			  String str = "";
			%>
				<c:forEach items="${cartsProduct }" var="item">
				<tr id="tr_${item.cartid }">				
					<td ><input type="checkbox" name="myck" checked="checked" value="${item.cartid }" id="ck_${item.cartid }"/></td>
					<td >
						<dl><dt><img src="statics/products/${item.image }/1/1_small.jpg"/></dt>
						<dd>${item.pname }<br />${item.subTitle }</dd>
						</dl>
					</td>
					<td >X${item.num }</td>
					<td price="${item.cartprice }">￥ ${item.cartprice }</td>
					<td ><a href="" onclick="return delectCart(${item.cartid })" class="green">删除</a></td>
				</tr>
				<c:set scope="request" var="cartprice" value="${item.cartprice }"></c:set>
				<c:set scope="request" var="cartid" value="${item.cartid }"></c:set>
				<% total += (double)request.getAttribute("cartprice");
				   str += (Integer)request.getAttribute("cartid")+"-";
				%>
				</c:forEach>	
				<% if(!"".equals(str)){
					str=str.substring(0, str.length()-1);
					} %>
		</table>
	</div>	
	<div class="div3"><h2 id="total">总计：￥<%=total %></h2></div>
	<div class="div3">
		<form action="addr" method="post" onsubmit="">
			<input type="hidden" name="action" value="addrListInOrder"/>
			<input type="hidden" name="cartid" id="cartid" value="<%=str %>"/>
			<input type="button" value="继续购物>>" style="border: none;background-color:#666666;width: 130px;height: 30px;font-size: 15px;"/>
			<input type="submit" name="" id="" value="立即结算>>" style="border: none;background-color: #90b830;width: 130px;height: 30px;color: white;font-size: 15px;"/>
		</form>
	</div>
	</c:if>