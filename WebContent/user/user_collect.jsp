<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html >

 <!--收藏样式-->
  <div class="right_style">
  <div class="title_style"><em></em>我的收藏</div> 
  <div class="Favorites_slideTxtBox">
     <div class="hd"><ul><li>收藏的商品</li></ul></div>
     <div class="bd">
        <ul class="commodity_list clearfix">
         <div class="Number_Favorites">共收藏：<c:if test="${!empty totalNum }">${totalNum }</c:if> <c:if test="${empty totalNum }">0</c:if>条</div>
         <div class="clearfix" id="mydiv">
        <c:if test="${empty resultInfo.result }">暂未收藏商品</c:if>
         <c:if test="${!empty resultInfo.result }">
         	<c:forEach items="${resultInfo.result.datas }" var="item">
          <li class="collect_p" id="li_${item.ctid }">
         <em class="iconfont  delete"></em>
         <a href="product?pid=${item.pid }" class="buy_btn">立即购买</a>
       <div class="collect_info">
        <div class="img_link"> <a href="product?pid=${item.pid }" class="center "><img src="statics/products/${item.image }/1/1.jpg"></a></div>
        <dl class="xinxi">
         <dt><a href="product?pid=${item.pid }" class="name">${item.subTitle }</a></dt>
         <dd><span class="Price"><b>现价:￥</b>${item.price }</span><span class="collect_Amount"><i class="iconfont icon-shoucang"></i><span style=" color:bule;text-decoration: line-through ">原价:${item.price*1.2 }</span></span></dd>         
        </dl>
        <div>
        	<dl>
        		<dt><a href="" style="color: red" onclick="return deleteCollect(${item.ctid},${resultInfo.result.pageNum })">删除</a></dt>
        	</dl>
        </div>
        </div>
        </li>
       	</c:forEach>
       </c:if>
       </div>
       </div>
       <div class="Paging">
    <div class="Pagination">
    
    <c:if test="${resultInfo.result.pageNum!=1 }">
    	<a href="collect?action=collectList&currentPage=1">首页</a>
 		<a href="collect?action=collectList&currentPage=${resultInfo.result.pageNum-1 }" class="pn-prev disabled">&lt;上一页</a>
 	</c:if>
    <c:forEach begin="1" end="${resultInfo.result.totalPages}" var="p">
    	<a  href="collect?action=collectList&currentPage=${p }" <c:if test="${p==resultInfo.result.pageNum }">class="on" style="color:red" </c:if>  >${p } </a>
    </c:forEach>
    <c:if test="${resultInfo.result.pageNum!=resultInfo.result.totalPages }">
    	<a href="collect?action=collectList&currentPage=${resultInfo.result.pageNum+1 }">下一页&gt;</a>
	 	<a href="collect?action=collectList&currentPage=${resultInfo.result.totalPages }">尾页</a>
 	</c:if>
	 	
     </div>
    </div>
        </ul>
     </div>
   </div>
   <script>
   jQuery(".Favorites_slideTxtBox").slide({trigger:"click"});
   //删除收藏商品
   function deleteCollect(ctid,pageNum){
	   swal({ 
			  title: '确定删除该收藏？', 
			  text: '你将无法恢复！', 
			  type: 'warning',
			  showCancelButton: true, 
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '确定删除！', 
			}).then(function(){
			   //发送ajax请求删除数据库的操作
				$.ajax({
					url:"collect",
					type:"post",
					data:{"action":"deleteCollect","ctid":ctid,"pageNum":pageNum},
					success:function(result){
							if (result.code==1) {
								//删除成功提示
								swal(
									'删除成功',
									'',
									'success'
								);
								//DOM操作
								$("#li_"+ctid).remove();  //删除当前的
								if (result.result!=null) {
									var num = parseInt(result.msg);
									//增加新的
									var li = $("<li class='collect_p' id='li_"+result.result.ctid+"'><em class='iconfont  delete'></em><a href='product?pid="+result.result.ctid+"' class='buy_btn'>立即购买</a><div class='collect_info'><div class='img_link'> <a href='product?pid="+result.result.pid+"' class='center '><img src='statics/products/"+result.result.image+"/1/1.jpg'></a></div><dl class='xinxi'><dt><a href='product?pid="+result.result.pid+"' class='name'>"+result.result.subTitle+"</a></dt><dd><span class='Price'><b>现价:￥</b>"+result.result.price+"</span><span class='collect_Amount'><i class='iconfont icon-shoucang'></i><span style=' color:bule;text-decoration: line-through '>原价:"+result.result.price*1.2+"</span></span></dd> </dl><div><dl><dt><a href='' style='color: red' onclick='return deleteCollect("+result.result.ctid+","+num+")'>删除</a></dt></dl></div></div> </li>");
									$("#mydiv").append(li);
								}
							}else{
								//删除失败提示
								swal(
										'系统繁忙，请重试',
										'',
										'error'
								);
							}
						}
					})
				});
				
		//终止a标签的跳转功能
		return false;
   }
   
   function test(){
	   window.location.reload();
   }
   </script>
  </div>
 </div>
</div>