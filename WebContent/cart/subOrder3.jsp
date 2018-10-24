<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="div4">

	<div style="height: 80px"></div>
	<span><img src="statics/img/success.png"><h3 >下单成功!</h3>
	<form action="cart/pay.jsp" method="post" id="tform">
		<input type="hidden" name="price" value="${price }"/>
		<input type="hidden" name="aid" value="${aid }"/>
		<input type="hidden" name="oid" value="${resultInfo.result }"/>
		<input type="submit" value="立即支付" style="border: none;background-color: #90b830;width: 130px;height: 40px;color: white;font-size: 15px;"/> 
	</form>

</div>
