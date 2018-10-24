<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

 	<c:if test="${empty cartsProduct }">
		<div class="div4">

			<div style="height: 80px"></div>
			<span><img src="statics/img/cart.PNG"><h3 >订单空空的哦~，去看看心仪的商品吧~</h3><a href="index">去购物 &gt; </a>
		
		</div>

	</c:if>
	<c:if test="${!empty cartsProduct }">
	<div class="div2"><img src="statics/img/car2.jpg" /></div>
	<div class="div1"><h2>收货信息</h2></div>
	<div class="div2">
		<c:if test="${empty resultInfo.result }">
			<h2>您还未添加任何收货地址！</h2><a href="/eyuan/user_addr?action=editAddr">去添加地址 &gt; </a>
		</c:if>
		<c:if test="${!empty resultInfo.result }">
		<table align="center" >
			<c:forEach items="${resultInfo.result }" var="item" varStatus="idx">
				<c:if test="${idx.index==0 }" >
					<tr> 
						<td width="140"><input type="radio" name="addr" checked="checked" onchange="hasChecked('${item.aid }')"/>${item.r_name }</td>
						<td width="480">${item.r_mobile } , ${item.r_province } , ${item.r_city } , ${item.r_district } , ${item.r_address } , ${item.r_zip }</td>
						<td width="140"><a href="#">[修改]</a>|<a href="#">[删除]</a></td>
					</tr>
				</c:if>
				<c:if test="${idx.index!=0 }" >
					<tr> 
						<td width="140"><input type="radio" name="addr" onchange="hasChecked('${item.aid }')"/>${item.r_name }</td>
						<td width="480">${item.r_mobile } , ${item.r_province } , ${item.r_city } , ${item.r_district } , ${item.r_address } , ${item.r_zip }</td>
						<td width="140"><a href="#">[修改]</a>|<a href="#">[删除]</a></td>
					</tr>
				</c:if>				
			</c:forEach>
		</table>
		</c:if>
	</div>	
	<div class="div1"><h2>商品详情</h2></div>
	<div class="div2">
		<table align="center" >
			<tr class="div1">
				<th width="480">商品</th>
				<th width="140">数量</th>
				<th width="140">总金额</th>
			</tr>
			<%double total = 0;
			  String str = "";
			%>
				<c:forEach items="${cartsProduct }" var="item">
				<input type="hidden" class="myck" checked="checked" value="${item.cartid }" id="ck_${item.cartid }"/>
				<tr>				
					<td >
						<dl><dt><img src="statics/products/${item.image }/1/1_small.jpg"/></dt>
						<dd>${item.pname }<br />${item.subTitle }</dd>
						</dl>
					</td>
					<td >X${item.num }</td>
					<td price="${item.cartprice }">￥ ${item.cartprice }</td>
				</tr>
				<c:set scope="request" var="cartprice" value="${item.cartprice }"></c:set>
				<c:set scope="request" var="cartid" value="${item.cartid }"></c:set>
				<% total += (double)request.getAttribute("cartprice");
				   str += (Integer)request.getAttribute("cartid")+"-";
				%>
				</c:forEach>	
				<% if(!"".equals(str) || str!=null){
					str=str.substring(0, str.length()-1);
					} %>
		</table>
	</div>	
	<div class="div3"><h2 id="total">总计：￥<%=total %></h2></div>
	<div class="div3">
		<form action="cart" method="post" onsubmit="return hasAddr()">
		<input type="hidden" name="action" value="order"/>
		<input type="hidden" name="pid" value="${pid }"/>
		<input type="hidden" name="size" value="${size }"/>
		<input type="hidden" name="num" value="${num }"/>
		<input type="hidden" name="cartid" id="cartid" value="<%=str %>"/>
		<input type="hidden" name="price" id="price" value="<%=total %>"/>
		<input type="hidden" name="aid" id="aid" value="${resultInfo.result.get(0).aid }"/>
 		<input type="submit" name="" id="" value="提交订单 >>"  style="border: none;background-color: #90b830;width: 130px;height: 30px;color: white;font-size: 15px;"/>
		</form>
	</div>
	</c:if>