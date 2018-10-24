//页面加载完就执行
function submitCart(){
	var size;
	var number = $("#number").val();
	var liSize = $("[class='guige-cur']");
	var liSizeStr = liSize.html();
	var price =$("#cartPrice").val();
	if ("规格一"==liSizeStr) {
		size=1;
	}
	if ("规格二"==liSizeStr) {
		size=2;
	}
	if ("规格三"==liSizeStr) {
		size=3;
	}
	var pid = $("#pid").val();
	
	//发送ajax请求
	$.ajax({
		url:"cart",
		type:"post",
		data:{"action":"addCart","size":size,"pid":pid,"num":number,"cartPrice":price},
		success:function(result){
			if (result.code==1) {  //添加成功
				new NoticeJs({
				    text: '加入成功！',
				    position: 'topCenter',
				     animation: {
				        open: 'animated bounceIn',
				        close: 'animated bounceOut'
				    } 
				}).show();
				var count = $("#shopping-amount");
				   var num = parseInt(count.html());
				   console.log($("#shopping-amountTop").html());
				   count.html(num+1);
				   $("#shopping-amountTop").html(num+1);
			}else { //添加失败
				window.location.href="login.jsp";
				/*new NoticeJs({
				    text: '无法加入！',
				    position: 'topCenter',
				     animation: {
				        open: 'animated bounceIn',
				        close: 'animated bounceOut'
				    } 
				}).show();*/
			}
		}
	});

	return false;
}


//**************鼠标移入购物车事件**************
$("#myCart").mouseover(function () {
	$.ajax({
	   type: "get",
	   url: "/eyuan/cart",
	   data: {"action":"cartList"},
	   success: function(carts){
	     if (carts==null||carts.length<1) {
				$("#myCartDiv").html('<div class="prompt"></div><div class="nogoods"><b></b>购物车中还没有商品，赶紧选购吧！</div>');
				$("#num").html(0);
				$("#total").html('￥ 0.00');
				return;
			}
	     var str = '<ul class="p_s_list">';
	     var price = 0 ;
	     var num = 0 ;
		 $.each(carts,function(index,value){
			price += carts[index].cartprice; 
			num += carts[index].num;
			str+='<li id="li_'+carts[index].cartid+'">'+
			     '<div class="img"><img src="/eyuan/statics/products/'+carts[index].image+'/1/1_small.jpg"></div>'+
			     '<div class="content"><p class="name"><a href="/eyuan/product?pid='+carts[index].pid+'" target="_blank">'+carts[index].pname+'</a></p><p>规格:规格'+carts[index].size+'&nbsp;&nbsp;数量：X'+carts[index].num+'</p></div>'+
				 '<div class="Operations">'+
				 '<p class="Price">￥'+carts[index].cartprice+'</p>'+
				 '<p><a href="" onclick="return delectCart('+carts[index].cartid+')">删除</a></p></div>'+
			     '</li>';
		});
		 	str+='</ul>';
		 	$("#myCartDiv").html(str);
			$("#num").html(num);
			$("#total").html('￥'+price);
	   }
	});
});
/****************删除购物车记录（右上角购物车样式）******************/
function delectCart(cartid){
	
	$.ajax({
		type: "get",
		   url: "/eyuan/cart",
		   data: {"action":"deleteCart","cartid":cartid},
		   success: function(row){
			   if (row == "1") {
				   $("#li_"+cartid).remove();
				   var count = $("#shopping-amount");
				   var num = parseInt(count.html());
				   console.log($("#shopping-amountTop").html());
				   if (num==1) {
					   count.html(0);
					   $("#shopping-amountTop").html(0);
				   }else {
					   count.html(num-1);
					   $("#shopping-amountTop").html(num-1);
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




