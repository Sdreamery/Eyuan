<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
td{
	text-align: center;
}
th{
	text-align: center;
}

	
</style>
<link rel="stylesheet" type="text/css" href="/eyuan/statics/bootstrap/css/bootstrap.min.css" />
<script type="text/javascript" src="/eyuan/statics/bootstrap/js/jquery-1.11.3.js"></script>
<script type="text/javascript" src="/eyuan/statics/bootstrap/js/bootstrap.min.js"></script>
</head>
<body id="body">
	
	
</body>

<script type="text/javascript">
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
	 if (hour.length == 1) {
		 hour = "0" + hour;
	 }
	  var dateTime = year +"-"+ month +"-"+  day +" "+hour +":"+minute+":"+second ;
	return dateTime;
} 


$.ajax({
		url:"../account",
		type:"post",
		data:{"action":"showCount"},
		success:function(result){
			if (result!=null) {  //有记录
				console.log(result.length);
				var table = $("<table class='table table-bordered'><tbody><tr><th style='text-align:center;'>充值时间</th> <th style='text-align:center;'>充值金额</th><th style='text-align:center;'>充值方式</th><th style='text-align:center;'>充值单号</th></tr></tbody></table>");
				for(var i=0;i<result.length;i++){
						var tr = $("<tr></tr>");
						var dateTime = dateformat(result[i].time);
						var td = $("<td>"+dateTime+"</td>");
						var td1 = $("<td>￥"+result[i].money+"</td>");
						if (result[i].method==1) {
							var td2 = $("<td>微信</td>");
						}else{
							var td2 = $("<td>支付宝</td>");
						}
						var td3 = $("<td>"+result[i].payNum+"</td>");
						tr.append(td);
						tr.append(td1);
						tr.append(td2);
						tr.append(td3);
						table.children().append(tr);
				}
				$("#body").append(table);
			}else{ //没记录
				$("#body").html('<h3 style="text-align:center;">充没充自己心里没点数？还敢来查充值记录</h3>');
			}
		}
	});
	

	

</script>

</html>