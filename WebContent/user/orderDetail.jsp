<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/eyuan/statics/bootstrap/css/bootstrap.min.css" />
<script type="text/javascript" src="/eyuan/statics/bootstrap/js/jquery-1.11.3.js"></script>
<script type="text/javascript" src="/eyuan/statics/bootstrap/js/bootstrap.min.js"></script>
</head>
<body id="bo1">

	<!-- <table class='table table-bordered'>
 		<tbody>
 			<tr>
 				<th>订单号</th>
 				<th>订单总额</th>
 				<th>收货人</th>
 				<th>手机号</th>
 				<th>订单创建时间</th>
 				<th>订单支付时间</th>
 				<th>订单完成时间</th>
 				<th>收货地址</th>
 			</tr>
 		</tbody>
	</table> -->
</body>

<script type="text/javascript">
$.ajax({
	url:"../userOrder",
	type:"post",
	data:{"action":"detali"},
	success:function(order){
		console.log(order);
		var table  = $("<table class='table table-bordered'><tbody><tr><th>订单号</th><th>订单总额</th><th>收货人</th><th>手机号</th><th>订单创建时间</th><th>订单支付时间</th><th>订单完成时间</th><th>收货地址</th></tr></tbody></table>");
		var tr  = $("<tr></tr>");
		var td = $("<td>"+order.o_no+"</td>"); //订单号
		
		var td1 = $("<td>￥"+order.pay+"</td>"); //订单总额
		
		var time = dateformat(order.time);    
		var td2 = $("<td>"+time+"</td>");  //订单创建时间
		
		var time1 = dateformat(order.time1); 
		if (order.time1==null) {
			var td3 = $("<td>暂未付款</td>");  
		}else {
			var time1 = dateformat(order.time1);    
			var td3 = $("<td>"+time1+"</td>");  //订单支付时间
		}
		
		if (order.time2==null) {
			var td4 = $("<td>未完成状态</td>");  //订单完成时间
		}else {
			var time2 = dateformat(order.time2);    
			var td4 = $("<td>"+time2+"</td>");  //订单完成时间
		}
		var td5 = $("<td>"+order.name+"</td>"); //收货人
		var td6 = $("<td>"+order.phone+"</td>"); //收货人手机号码
		var td7 = $("<td>"+order.po+order.co+order.doo+order.ao+"</td>"); //收货人详细地址
		
		tr.prepend(td7);
		tr.prepend(td4);
		tr.prepend(td3);
		tr.prepend(td2);
		tr.prepend(td6);
		tr.prepend(td5);
		tr.prepend(td1);
		tr.prepend(td);
		table.children().append(tr);
		$("#bo1").append(table);
	}
});


function dateformat(str){
	 if(str == null || str == "" || typeof(str)=="undefined"){
		return "";
	 }
	 var now = new Date(str);
	 var year = now.getFullYear();
	 var month =(now.getMonth() + 1).toString();
	 var day = (now.getDate()).toString();
	 var hour = (now.getHours()).toString();
    var minute = (now.getMinutes()).toString();
    var second =(now.getSeconds()).toString();
	 if (month.length == 1) {
	      month = "0" + month;
	 }
	 if (day.length == 1) {
	      day = "0" + day;
	 }
	  var dateTime = year +"-"+ month +"-"+  day +" "+hour +":"+minute+":"+second ;
	return dateTime;
} 

</script>
</html>