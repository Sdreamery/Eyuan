//个人订单信息JS文件

//个人订单删除
function deleteOrder(oid,status){
	console.log(status);
	swal({ 
		  title: '确定删除吗？', 
		  text: '你将无法恢复订单！', 
		  type: 'warning',
		  showCancelButton: true, 
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '确定删除！', 
		}).then(function(){
		   //发送ajax请求删除数据库的操作
			$.ajax({
				url:"userOrder",
				type:"post",
				data:{"action":"deleteOrder","oid":oid,"status":status},
				success:function(result){
					if (result.code==1) {
						swal(
								result.msg,
								'',
								'success'
						);
						//dom操作
						deleteTbody(oid);
					}else {
						swal(
								result.msg,
								'',
								'error'
						);
					}
				}
			});
			
		})
		
	//终止a标签的跳转功能
	return false;
}

//删除DOM操作
function deleteTbody(oid){
	$("#tb_"+oid).remove();
}

//提醒发货
function askOrder(oid){
	swal(
			'提醒成功！！',
			'',
			'success'
	);
	
	$("#aa_"+oid).attr("style","color:red");
	
	return false;
}

//全选
function allChoose(){
	$("[name='choosename']").prop("checked",true);
}

//批量确认收货
function allPay(status){
	//发送ajax请求，把状态码从3改为4
	$.ajax({
		url:"userOrder",
		type:"post",
		data:{"action":"allPay","status":status},
		success:function(result){
			if (result.code==1) {
				swal(
						'操作成功，2秒后跳转交易成功页面',
						'',
						'success'
				);
				//刷新页面
				window.setTimeout(meReLoad,2000);
			}else {
				swal(
						result.msg,
						'',
						'error'
				);
			}
		}
	});
}

//跳转页面
function meReLoad(){
	window.location.href="userOrder?action=orderList&status=4";
}

function goAllOrder(){
	window.location.href="userOrder?action=orderList";
}

//批量删除订单
function allDetele(status){
	swal({ 
		  title: '确定删除吗？', 
		  text: '你将无法恢复订单！', 
		  type: 'warning',
		  showCancelButton: true, 
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '确定删除！', 
		}).then(function(){
		   //发送ajax请求删除数据库的操作
			$.ajax({
				url:"userOrder",
				type:"post",
				data:{"action":"allDelete","status":status},
				success:function(result){
					if (result.code==1) {
						swal(
								'恭喜,删除成功！！',
								'',
								'success'
						);
						//刷新页面
						window.setTimeout(goAllOrder,1000);
					}else{
						swal(
								'删除失败！！',
								'',
								'error'
						);
					}
				}
			});
	});
}

//单独确认收货
function submitOrder(oid){
	//发送ajax请求，把状态码从3改为4
	$.ajax({
		url:"userOrder",
		type:"post",
		data:{"action":"onePay","oid":oid},
		success:function(result){
			if (result.code==1) {
				swal(
						'操作成功',
						'',
						'success'
				);
				//DOM操作
				$("#p_"+oid).html("交易成功");
				$("#myTD_"+oid).html("<a href='#'>联系客服</a><a href='#' onclick=' return deleteOrder("+oid+"'> 删除</a>");
				window.setTimeout(test05, 2000);
				
			}else {
				swal(
						'确认收货失败',
						'',
						'error'
				);
			}
		}
	});
	
	return false;
}

function test05(){
	window.location.href = "userOrder?action=orderList&status=4";
}

//搜索框
function searchKey(){
	//获取搜索框里面的值
	var value = $("#search").val();
	console.log(value);
	if (isEmpty(value)) {
		$("#search").val("请输入订单号");
		return false;
	}
	if (value.length!=16) {
		$("#search").val("请输入完整的订单号");
		return false;
	}
	
}

/**
 * 聚焦事件
 */
$("#search").focus(function(){
	$("#search").val("");
});

