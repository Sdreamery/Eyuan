<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html >
<title>订单管理</title>
<<style>
.awcb{
display:inline-block;
width:20px;
height:20px;
}
.imgwcb{
width:100%;
}
</style>
 <!--右侧样式-->
  <div class="right_style">
  <div class="title_style"><em></em>订单管理</div> 
   <div class="Order_form_style">
      <div class="Order_form_filter" id="myDiv">
       <a href="userOrder?action=orderList" <c:if test="${empty status }"> class="on" </c:if> >全部订单（${number.totalNum }）</a>
       <a href="userOrder?action=orderList&status=1" <c:if test="${status==1 }"> class="on" </c:if> >代付款（${number.num2 }）</a>
       <a href="userOrder?action=orderList&status=2" <c:if test="${status==2 }"> class="on" </c:if> >代发货（${number.num3 }）</a>
       <a href="userOrder?action=orderList&status=3" <c:if test="${status==3 }"> class="on" </c:if> >待收货（${number.num4 }）</a>
       <a href="userOrder?action=orderList&status=5" <c:if test="${status==5 }"> class="on" </c:if> >退货/退款（${number.num6 }）</a>
       <a href="userOrder?action=orderList&status=4" <c:if test="${status==4 }"> class="on" </c:if> >交易成功（${number.num5 }）</a>
       <a href="userOrder?action=orderList&status=0" <c:if test="${status==0 }"> class="on" </c:if> >交易关闭（${number.num1 }）</a>
      </div>
      <div class="Order_Operation">
     <div class="left"> <label><input name="choosename" onclick="allChoose()" class="checkbox" <c:if test="${empty status }"> type="hidden" </c:if> <c:if test="${!empty status }"> type="checkbox" 全选 </c:if> ></label> 
     <input name="" type="submit" onclick="allPay(${status})"  value="批量确认收货"  class="confirm_Order"/>  <input name="" type="submit" value="批量删除订单" onclick="allDetele(${status})" class="confirm_Order"/>  </div>
     <div class="right_search">
     <form action="userOrder" method="post">
     <input type="hidden" name="action" value="searchKey">
     <input name="search" type="text" <c:if test="${!empty searchKey }"> value="${searchKey }"  </c:if> id="search" class="add_Ordertext" placeholder="请输入订单号进行搜索" />
     <input  type="submit" value="搜索订单" id="wcb" onclick="return searchKey()" class="search_order"/>
     </form>
     </div>
      </div>
      <div class="Order_form_list">
      <c:if test="${empty orderList }"><h2>您还没有任何相关订单哦</h2></c:if>
      <c:if test="${!empty orderList }">
         <table>
         <thead>
          <tr><td class="list_name_title0">商品</td>
          <td class="list_name_title1">单价(元)</td>
          <td class="list_name_title2">数量</td>
          <td class="list_name_title4">实付款(元)</td>
          <td class="list_name_title5">订单状态</td>
          <td class="list_name_title6">操作</td>
         </tr>
         </thead>
         
         <!-- 循环遍历订单数据  orderList -->
    <c:forEach items="${orderList }" var="item">
    <fmt:formatDate value="${item.create_datetime }" pattern="yyyy-MM-dd  HH:mm"  var="time"/>
         <tbody id="tb_${item.oid }">       
           <tr class="Order_info"><td colspan="6" class="Order_form_time"><input name="choosename" type="checkbox" value=""  class="checkbox"/>下单时间：${time } | 订单号：${item.o_no } <em></em></td></tr>
           <tr class="Order_Details">
           <td colspan="3">
           <table class="Order_product_style">
           		<tbody>
           		<!-- 循环遍历  sonList -->
           	<c:forEach items="${sonList }" var="itemson">
           		<c:if test="${itemson.oid==item.oid }">
           <tr>
           <td>
            <div class="product_name clearfix">
            <a href="product?pid=${itemson.pid }" class="product_img"><img src="statics/products/${itemson.image }/1/1.jpg" width="80px" height="80px"></a>
            <a href="product?pid=${itemson.pid }" class="p_name" style="font-size:12px" >${itemson.subTitle }</a>
            <p class="specification" style="font-size:14px"><c:if test="${itemson.size==1 }">规格一</c:if><c:if test="${itemson.size==2 }">规格二</c:if><c:if test="${itemson.size==3 }">规格三</c:if></p>
            </div>
            </td>
            <td><c:if test="${itemson.size==1 }">${itemson.price }</c:if><c:if test="${itemson.size==2 }">${itemson.price*1.2 }</c:if><c:if test="${itemson.size==3 }">${itemson.price*1.5 }</c:if></td>
           <td>${itemson.num }</td>
            </tr>
            	</c:if>
           </c:forEach>
            	</tbody>
            
            </table>
           </td>   
           <td class="split_line">${item.pay}</td>
           <td class="split_line"><p style="color:#F30" id="p_${item.oid }"><c:if test="${item.status==0 }">订单已关闭</c:if>
           <c:if test="${item.status==1 }">等待买家付款</c:if><c:if test="${item.status==2 }">等待卖家发货</c:if>
           <c:if test="${item.status==3 }">卖家已发货</c:if><c:if test="${item.status==4 }">交易成功</c:if><c:if test="${item.status==5 }">退款/退货订单</c:if>
           </p></td>
         <c:if test="${item.status==0 }">订单已关闭
          <td class="operating">
             <a href="#" onclick="return openThis()">联系客服</a>
             <a href="#" onclick=" return deleteOrder(${item.oid },${item.status })" >删除</a>
           </td>
          </c:if>
          
          <c:if test="${item.status==1 }">
          	 <td class="operating">
          	 <form id="form_${item.oid }" name="form" method="post" action="cart/pay.jsp"> 
			　　<input type="hidden" name="oid" value="${item.oid }"> 
				<input type="hidden" name="aid" value="${item.aid }"> 
				<input type="hidden" name="price" value="${item.pay }"> 
			</form> 
			<a href="#" class="btu_aa"  onclick="return lookOrder(${item.oid })">查看订单</a>
			<a href="#" onclick=" return myClick(${item.oid});">立即付款 </a>
             <%-- <a href="cart/pay.jsp?oid=${item.oid }&aid=${item.aid }&price=${item.pay }">立即付款</a> --%>
             <a href="#" onclick="return openThis()">联系客服</a>
             <a href="#" onclick=" return deleteOrder(${item.oid },${item.status })"> 删除</a>
           </td>
          </c:if>
          
          <c:if test="${item.status==2 }">
          	<td class="operating" >
             <a href="#" class="btu_aa"  onclick="return lookOrder(${item.oid })">查看订单</a>
             <a href="#" id="aa_${item.oid }" onclick=" return askOrder(${item.oid })" >提醒发货</a>
             <a href="#" onclick="return openThis()">联系客服</a>
             <a href="#" onclick=" return deleteOrder(${item.oid },${item.status })"> 删除</a>
           </td>
          </c:if>
          
         <c:if test="${item.status==3 }">
          	<td class="operating" id="myTD_${item.oid }" >
             <a href="#" >查看物流</a>
             <a href="#" onclick="return openThis()">联系客服</a>
             <a href="#" id="sub_${item.oid }" class="Delivery_btn" onclick=" return submitOrder(${item.oid })" >确认收货</a>  
           </td>
         </c:if>
         
          <c:if test="${item.status==4 }">
          	<td class="operating">
          	<a href="#" class="btu_aa"  onclick="return lookOrder(${item.oid })">查看订单</a>
             <a href="#" onclick="return openThis()">联系客服</a>
             <a href="#" onclick="return deleteOrder(${item.oid },${item.status })"> 删除</a>
           </td>
         </c:if>
         
          <c:if test="${item.status==5 }">
          	<td class="operating">
             <a href="#" class="btu_aa"  onclick="return lookOrder(${item.oid })">查看订单</a>
             <a href="#">查看进度</a>
             <a href="#" onclick="return openThis()">联系客服</a>
             <a href="#" onclick=" return deleteOrder(${item.oid },${item.status })"> 删除</a>
           </td>
         </c:if>
         
           </tr>
           </tbody>
        </c:forEach>    
                  
         </table>
     </c:if>
    </div>
     </div>
   </div>
 
<div class="dialogue-wrapper" >
    <div id="btn_open" class="dialogue-support-btn" style="display: none;">
        <i class="dialogue-support-icon"></i>
        <i class="dialogue-support-line"></i>
        <span class="dialogue-support-text">联系客服</span>
    </div>
    <div class="dialogue-main">
        <div class="dialogue-header">
            <i id="btn_close" class="dialogue-close">></i>
            <div class="dialogue-service-info">
                <i class="dialogue-service-img">Eyuan</i>
               	<div class="dialogue-service-title">
                    <p class="dialogue-service-name">Eyuan支持平台</p>
                </div>
            </div>
        </div>
        <div id="dialogue_contain" class="dialogue-contain">
            <p class="dialogue-service-contain"><span class="dialogue-text dialogue-service-text">您好，有啥事</span></p>
            <!-- <p class="dialogue-customer-contain"><span class="dialogue-text dialogue-customer-text">我有个问题</span></p> -->
        </div>
        <div class="dialogue-submit">
            <p id="dialogue_hint" class="dialogue-hint"><span class="dialogue-hint-icon">!</span><span class="dialogue-hint-text">发送内容不能为空</span></p>
            <textarea id="dialogue_input" class="dialogue-input-text" style="color: red" placeholder="请输入您的问题，按Enter键提交（shift+Enter换行）"></textarea>
        </div>
    </div>
</div>
 
 
<script>

function myClick(oid) {
	$("#form_"+oid).submit();
	return false;
}


function lookOrder(oid){
	//发送ajax请求，把oid，存到session
	$.ajax({
		url:"userOrder",
		type:"post",
		data:{"action":"saveOid","oid":oid},
		success:function(result){
			if (result==1) {  //存成功
				layer.open({
			        type: 2,
			        title: '订单详情',
			        maxmin: true,
			        shadeClose: true, //点击遮罩关闭层
			        area : ['1200px' , '120px'],
			        content:'user/orderDetail.jsp'
				});
			}
		} 
	})
	
	
	return false;
}

	var doc = document;
    // 模拟一些后端传输数据
    var serviceData = {
        'robot': {
            'name': 'robot001',
            'dialogue': ['不能退货的，亲', '我没明白,请再说一次', 'hehe'],
            'welcome': '您好，robot001为您服务'
        }
    };

    var dialogueInput = doc.getElementById('dialogue_input'),
        dialogueContain = doc.getElementById('dialogue_contain'),
        dialogueHint = doc.getElementById('dialogue_hint'),
        btnOpen = doc.getElementById('btn_open'),
        btnClose = doc.getElementById('btn_close'),
        timer,
        timerId,
        shiftKeyOn = false;  // 辅助判断shift键是否按住
      	//打开联系客服窗口
        function openThis(){
        	$('.dialogue-support-btn').css({'display': 'none'});
            $('.dialogue-main').css({'display': 'inline-block', 'height': '0'});
            $('.dialogue-main').animate({'height': '600px'})
            
        	return false;
        }
    
	
    btnClose.addEventListener('click', function(e) {
        $('.dialogue-main').animate({'height': '0'}, function() {
            $('.dialogue-main').css({'display': 'none'});
        });
    })

    dialogueInput.addEventListener('keydown', function(e) {
        var e = e || window.event;
        if (e.keyCode == 16) {
            shiftKeyOn = true;
        }
        if (shiftKeyOn) {
            return true;
        } else if (e.keyCode == 13 && dialogueInput.value == '') {
            // console.log('发送内容不能为空');
            // 多次触发只执行最后一次渐隐
            setTimeout(function() {
                fadeIn(dialogueHint);
                clearTimeout(timerId)
                timer = setTimeout(function() {
                    fadeOut(dialogueHint)
                }, 2000);
            }, 10);
            timerId = timer;
            return true;
        } else if (e.keyCode == 13) {
            var nodeP = doc.createElement('p'),
                nodeSpan = doc.createElement('span');
            nodeP.classList.add('dialogue-customer-contain');
            nodeSpan.classList.add('dialogue-text', 'dialogue-customer-text');
            nodeSpan.innerHTML = dialogueInput.value;
            nodeP.appendChild(nodeSpan);
            dialogueContain.appendChild(nodeP);
            dialogueContain.scrollTop = dialogueContain.scrollHeight;
            submitCustomerText(dialogueInput.value);
        }
    });

    dialogueInput.addEventListener('keyup', function(e) {
        var e = e || window.event;
        if (e.keyCode == 16) {
            shiftKeyOn = false;
            return true;
        }
        if (!shiftKeyOn && e.keyCode == 13) {
            dialogueInput.value = null;
        }
    });

    function submitCustomerText(text) {
        console.log(text)
        // code here 向后端发送text内容

        // 模拟后端回复
        var num = Math.random() * 10;
        if (num <= 7) {
            getServiceText(serviceData);
        }
    }

    function getServiceText(data) {
        var serviceText = data.robot.dialogue,
            i = Math.floor(Math.random() * serviceText.length);
        var nodeP = doc.createElement('p'),
            nodeSpan = doc.createElement('span');
        nodeP.classList.add('dialogue-service-contain');
        nodeSpan.classList.add('dialogue-text', 'dialogue-service-text');
        nodeSpan.innerHTML = serviceText[i];
        nodeP.appendChild(nodeSpan);
        dialogueContain.appendChild(nodeP);
        dialogueContain.scrollTop = dialogueContain.scrollHeight;
    }

    // 渐隐
    function fadeOut(obj) {
        var n = 100;
        var time = setInterval(function() {
            if (n > 0) {
                n -= 10;
                obj.style.opacity = '0.' + n;
            } else if (n <= 30) {
                obj.style.opacity = '0';
                clearInterval(time);
            }
        }, 10);
        return true;
    }

    // 渐显
    function fadeIn(obj) {
        var n = 30;
        var time = setInterval(function() {
            if (n < 90) {
                n += 10;
                obj.style.opacity = '0.' + n;
            } else if (n >= 80) {
                
                obj.style.opacity = '1';
                clearInterval(time);
            }
        }, 100);
        return true;
    }
</script>   
   