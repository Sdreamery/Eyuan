<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html >
 <script type="text/javascript">

	 $.ajax({
			type: "POST",
		   	url: "/eyuan/account",
		   	data: {"action":"userCenter"},
		   	success: function(list){
		   		console.log(list);
		   		$("#money").html("余额：￥"+list[0]);
		   		$("#orders").html("派送订单：("+list[1]+")");
		   		$("#collects").html("我的收藏：("+list[2]+")");
		   		$("#addrs").html("我的地址：("+list[3]+")");
		   		/*循环拼接已完成订单展示*/
		   	    var str1 = '<tr>'+
		   	    '<td class="img_link">';
		   	    var num = 0;
		   		for(var i = 0 ; i< list[4].length ; i++){
			   		str1+= ('<a href="/eyuan/product?pid='+list[4][i].pid+'" target="_blank" class="img" title="'+list[4][i].pname+'"><img src="statics/products/'+list[4][i].image+'/1/1.jpg" width="80" height="80"></a>');
			   		if (i<list[4].length-1) {
			   			str1 +='<i class="icon-copy"></i>';
					}
			   		num += list[4][i].num;
		   		}
		   		str1+='</td>'+
		   		'<td>'+num+'</td>'+
		   		'<td>完成</td>'+
		   		'<td><a href="/eyuan/userOrder?action=orderList" class="View">查看</a></td>';
		   		$("#products1").html(str1);
		   		/*循环拼接已收藏商品展示  */
		   		 var str2 = "";
		   		for(var i = 0 ; i< list[5].length ; i++){
		   			str2 += '<li style="display: inline-block">'+
	                    '<div class="pic"><a href="/eyuan/product?pid='+list[5][i].pid+'" target="_blank"><img src="/eyuan/statics/products/'+list[5][i].image+'/1/1.jpg"></a></div>'+	
	                    '<div class="title"><a href="/eyuan/product?pid='+list[5][i].pid+'" target="_blank">'+list[5][i].pname+'  '+list[5][i].subTitle+'</a></div>'+
	                    '<div class="p_Price">￥'+list[5][i].price+'</div>'+		
	                '</li>';
		   		}
		   		$("#products2").html(str2);
		   	 	//$("#products2").listview('refresh');   //在使用'ul'标签时才使用，作用:刷新列表
		   		//$("#products2").trigger("create");  //重新加载所在标签的样式。不加这一句动态append的标签将丢失Css样式
		   		/*循环拼接浏览历史商品展示  */
		   		var str3 = "";
		   		for (var i = 0 ; i< 1 ; i++){
/* 		   			if(i==0){ */
		   				str3+='<li class="clone">'+
                        '<div class="p_width">'+
                    '<div class="pic"><a href="/eyuan/product?pid='+list[5][i].pid+'" target="_blank"><img src="/eyuan/statics/products/'+list[5][i].image+'/1/1.jpg"></a></div>'+	
                    '<div class="title"><a href="/eyuan/product?pid='+list[5][i].pid+'" target="_blank">'+list[5][i].pname+'  '+list[5][i].subTitle+'</a></div>'+
                    '<div class="Purchase_info"><span class="p_Price">￥'+list[5][i].price+'</span> <a href="#" class="Purchase">立即购买</a></div>'+
                '</div>'+
                '</li>';
	/* 	   			}else{
		   				str3+='<li >'+
                        '<div class="p_width">'+
                    '<div class="pic"><a href="/eyuan/product?pid='+list[5][i].pid+'" target="_blank"><img src="/eyuan/statics/products/'+list[5][i].image+'/1/1.jpg"></a></div>'+	
                    '<div class="title"><a href="/eyuan/product?pid='+list[5][i].pid+'" target="_blank">'+list[5][i].pname+'  '+list[5][i].subTitle+'</a></div>'+
                    '<div class="Purchase_info"><span class="p_Price">￥'+list[5][i].price+'</span> <a href="#" class="Purchase">立即购买</a></div>'+
                '</div>'+
                '</li>';
		   			} */
				
		   		}
		   		$("#products3").html(str3);// 用append 方式添加拼接的标签

		   		//$("#products3").listview("refresh");   //在使用'ul'标签时才使用，作用:刷新列表

		   		//$("#products3").trigger("create");  //重新加载所在标签的样式。不加这一句动态append的标签将丢失Css样式
		   	}
		});

</script>
 <div class="right_style">
     <div class="info_content">
    <div class="Notice"><span>系统最新公告:</span>为了更好地服务于【每日鲜】的会员朋友及读者 发表意见。</div>
     <div class="user_info">
      <ul class="">
       <li class="Balance"><a href="/eyuan/account?action=showAccount"><img src="statics/images/user_img_05.png" /><h4 id="money">余额：￥ 0.00</h4></a></li>
       <li class="Order_form"><a href="/eyuan/userOrder?action=orderList"><img src="statics/images/user_img_04.png" /><h4 id="orders">派送订单：(0)</h4></a></li>
       <li class="grade"><a href="/eyuan/collect?action=collectList"><img src="statics/images/user_img_08.png" /><h4 id="collects">我的收藏：(0)</h4></a></li>
       <li class="Favorable"><a href="/eyuan/user_addr?action=editAddr"><img src="statics/images/user_img_07.png" /><h4 id="addrs">我的地址：(0)</h4></a></li>
       <li class="integral"><a href="#"><img src="statics/images/user_img_06.png" /><h4>100分</h4></a></li>
      </ul>
     </div>
     <!--样式-->
     <div class="user_info_p_s  clearfix">
       <!--订单记录-->
       <div class="left_user_cont">
     <div class="us_Orders left clearfix">
  <div class="Orders_name">
   <div class="title_name">
   <div class="Records">购买记录</div>
   <div class="right select">
   只记录你交易完成订单的购买记录  </div>
   </div>   
  </div>
  <table>
  <thead>
  <tr>
   <th>产品名称</th>
   <th>数量</th>
   <th>状态</th>
   <th>操作</th>
   </tr>
  </thead>
  <tbody id="products1">

	<!-- 展示订单 -->

   </tbody>
  </table>
   <div class="us_jls">共2条记录</div>
  </div>
    </div>
      <!--右侧记录样式-->
    <div class="right_user_recording">
    <div class="us_Record">
	  <div id="Record_p" class="Record_p">
	  <!-- ------------------------------------------------------ -->
	    <div class="title_name"><span class="name left">浏览历史</span><span class="pageState right"><span>1</span>/7</span></div>
	      <div class="hd"><a class="next">&lt;</a><a class="prev">&gt;</a></div>
            <div class="bd">
                <ul id="products3">
    
                </ul>
                </div>            
         </div>
         <script type="text/javascript">jQuery("#Record_p").slide({ mainCell:".bd ul",effect:"leftLoop",vis:1,autoPlay:false });</script>
	    </div>
       </div>      
     </div>
        <!--收藏商品-->
     <div class="Collections_p">
      <div class="slideGroups">
        <div class="parHd">
				<ul><li>收藏的商品</li></ul>
			</div>
			<!-- ------------------------------------------------------ -->
            <div class="parBd">
             <div class="Collect_Products">
              <a class="sPrev" href="javascript:void(0)">&lt;</a>
              <ul id="products2" data-role="listview">
             
              </ul>
              <a class="sNext" href="javascript:void(0)">&gt;</a>
              <a href="/eyuan/collect?action=collectList" class="more">更多收藏</a>
             </div>
             <!-- <div class="Collect_Products">
             <a class="sPrev" href="javascript:void(0)">&lt;</a>
              <ul >
              <li>
                    <div class="pic"><a href=""><img src="statics/products/P_29.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>		
                </li>
                <li s>
                    <div class="pic"><a href=""><img src="statics/products/P_19.jpg"></a></div>
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                   <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>	
                </li>
                <li >
                    <div class="pic"><a href=""><img src="statics/products/P_37.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>							
                </li>
                <li>
                    <div class="pic"><a href=""><img src="statics/products/P_24.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>									
                </li>
                    <li >
                    <div class="pic"><a href=""><img src="statics/products/P_33.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>						
                </li>
                    <li >
                    <div class="pic"><a href=""><img src="statics/products/P_29.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>			
                </li>
                    <li>
                    <div class="pic"><a href=""><img src="statics/products/P_18.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>			
                </li>
                <li>
                    <div class="pic"><a href=""><img src="statics/products/P_17.jpg"></a></div>
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>	
                </li>
                <li >
                    <div class="pic"><a href=""><img src="statics/products/P_16.jpg"></a></div>	
                    <div class="title"><a href="#">金龙鱼 东北大米 蟹稻共生 盘锦大米5KG</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>								
                </li>
                <li >
                    <div class="pic"><a href=""><img src="statics/products/P_12.jpg"></a></div>	
                    <div class="title"><a href="#">三只松鼠旗舰店</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>									
                </li>
                <li >
                    <div class="pic"><a href=""><img src="statics/products/P_8.jpg"></a></div>	
                    <div class="title"><a href="#">三只松鼠旗舰店</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>						
                </li>
                <li >
                    <div class="pic"><a href=""><img src="statics/products/P_11.jpg"></a></div>	
                    <div class="title"><a href="#">店铺名称是什么</a></div>
                    <div class="shop_name"><span>收藏：234</span><a href="#" >进入店铺</a></div>			
                </li>
              </ul>
              <a class="sNext" href="javascript:void(0)">&gt;</a>
              <a href="#" class="more">更多收藏</a>
             </div>
            </div> -->
      </div>
      <script type="text/javascript">
			/* 内层图片无缝滚动 */
			jQuery(".slideGroups .Collect_Products").slide({ mainCell:"ul",vis:5,prevCell:".sPrev",nextCell:".sNext",effect:"leftMarquee",interTime:50,autoPlay:true,trigger:"click"});

			/* 外层tab切换 */
			jQuery(".slideGroups").slide({titCell:".parHd li",mainCell:".parBd",trigger:"click"});

		</script>			
     </div>
   <!--结束-->       
    </div>
 
  </div>
 </div>
