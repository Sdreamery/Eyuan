<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>支付中心</title>

<link rel="stylesheet" type="text/css" href="/eyuan/statics/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css" href="/eyuan/statics/css/main.css" />
<style type="text/css">
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }
    input[type="password"]{
        -moz-appearance: textfield;
    }
    .am-form input[type=password] {
    width: 48px;
    background: #fff;
    border: 2px solid #CCCCCC;
    font-size: 27px;
    height: 48px;
    border-radius: 4px;
    float: left;
    margin-right: 0px;
}
</style>
<script type="text/javascript">
function checkPsw(price){
	console.log(price);
	var txts = $("input[type='password']");
	var psw = "";
	for(var i = 0;i<txts.length;i++){
		psw+=txts[i].value;
	}
	if (psw=="123456") {
		//发送ajax,验证金额
		$.ajax({
			url:"../userOrder",
			type:"post",
			data:{"action":"buy","price":price},
			success:function(result){
				if (result==1) {
					$("#msg").html();
					$("#myform").submit();
					return true;
				}else {
					$("#msg").html("&nbsp;&nbsp;&nbsp;*金额不足，请先充值！&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a style='color:blue;font-size:20px'  href='../user/user_recharge.jsp'>充值变强链接</a>");
					return false;
				}
			}
		})
	}else{
		$("#msg").html("&nbsp;&nbsp;&nbsp;*密码输入有误！");
		return false;
	}
}
</script>
</head>
<body>

<div class="pay">
	<!--主内容开始编辑-->
	<div class="tr_recharge">
		<div class="tr_rechtext" >
			<p class="te_retit"><img src="/eyuan/statics/img/coin.png" alt="" />支付中心</p>
			<p>1.如果您因年龄、智力等因素而不具有完全民事行为能力，请在法定监护人（以下简称"监护人"）的陪同下阅读和判断是否同意本协议，并特别注意未成年人使用条款。 </p>
			<p>2.如果您是中国大陆地区以外的用户，您订立或履行本协议还需要同时遵守您所属和/或所处国家或地区的法律。</p>
		</div>
		<form action="../userOrder" class="am-form" id="myform" id="doc-vld-msg" method="post" >
			<div class="tr_rechbox">
				<div class="tr_rechhead">
					<img src="/eyuan/statics/img/ys_head2.jpg" />
					<p>支付帐户：
						<a>${user.nick }</a>
					</p>
					<div class="tr_rechheadcion">
						<img src="/eyuan/statics/img/coin.png" alt="" />
						<!-- <span>当前余额：<span>1000招兵币</span></span> -->
					</div>
				</div>
				<div class="tr_rechoth am-form-group">
					<span>其他金额：</span>
					<input type="number" min="10" max="10000" value="10.00元" class="othbox" data-validation-message="充值金额范围：10-10000元" />
					<!--<p>充值金额范围：10-10000元</p>-->
				</div>
				<div class="tr_rechcho am-form-group" >
					<span>支付方式：</span>

					<label class="am-radio" style="margin-right:30px;">
							<input type="radio" name="radio1" id="sel" value="" checked="checked" data-am-ucheck data-validation-message="请选择一种充值方式"><img src="/eyuan/statics/img/selPay.PNG">
						</label>
					<label class="am-radio" style="margin-right:30px;">
							<input type="radio" name="radio1" id="zfb" value="" data-am-ucheck data-validation-message="请选择一种充值方式"><img src="/eyuan/statics/img/zfbpay.png">
					</label>
					<label class="am-radio">
							<input type="radio" name="radio1" id="wechat" value="" data-am-ucheck required data-validation-message="请选择一种充值方式"><img src="/eyuan/statics/img/wechatpay.png">
					</label>
				</div>
				<div class="tr_rechnum">
					<span>应付金额：</span>
					<p class="rechnum"><%=request.getParameter("price") %>元</p>
				</div>
				
				<div class="tr_rechnum" style="margin-top:20px">
				<span style="float: left;">支付密码：</span>
				<input type="password" style="width: 48px ;margin-right: 0px"/>
				<input type="password" style="width: 48px ;margin-right: 0px"/>
				<input type="password" style="width: 48px ;margin-right: 0px"/>
				<input type="password" style="width: 48px ;margin-right: 0px"/>
				<input type="password" style="width: 48px ;margin-right: 0px"/>
				<input type="password" style="width: 48px ;margin-right: 0px"/>
				<span style="color: red;" id="msg"> </span>
				</div>
			</div>
			<div class="tr_paybox">
				<input type="hidden" name="action" value="payOrder"/>
				<input type="hidden" name="price" value="<%=request.getParameter("price") %>"/>
				<input type="hidden" name="aid" value="<%=request.getParameter("aid") %>"/>
				<input type="hidden" name="oid" value="<%=request.getParameter("oid") %>"/>
				<input type="button" value="确认支付" id="payMo" class="tr_pay am-btn" onclick="return checkPsw(<%=request.getParameter("price") %>)"/>
				<span>温馨提示：个人账户金额不能兑换现金，不能进行转账交易，不能兑换本公司体系外的产品和服务。。</span>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript" src="/eyuan/statics/js/jquery.min.js"></script>
<script type="text/javascript" src="/eyuan/statics/js/amazeui.min.js"></script>
<script type="text/javascript" src="/eyuan/statics/js/ui-choose.js"></script>
<script type="text/javascript">
$(function(){
	$("#zfb").click(function() {
		$("#payMo").prop("disabled",true);
	})
	$("#wechat").click(function() {
		$("#payMo").prop("disabled",true);
	})
	$("#sel").click(function() {
		$("#payMo").prop("disabled",false);
	})
	
	
    var txts = $("input[type='password']");
    for(var i = 0; i<txts.length;i++){
        var t = txts[i];
        t.index = i;
        //t.setAttribute("readonly", true);
        t.onkeyup=function(event){
        	$("#msg").html("");
            this.value=this.value.replace(/^(.).*$/,'$1');
            if(event.keyCode==8){
                var next = this.index - 1;
                if(next < 0) return;
                txts[next].removeAttribute("readonly");
                txts[next].focus();            	
            }else{
                var next = this.index + 1;
                if(next > txts.length - 1) {
                	var psw = "";
                	for(var i = 0;i<txts.length;i++){
                		psw+=txts[i].value;
                	}
                	if (psw=="123456") {
						
					}else{
						$("#msg").html("&nbsp;&nbsp;&nbsp;*密码输入有误！");
					}
                	return;
                }
                txts[next].removeAttribute("readonly");
                txts[next].focus();           	
            }

        }
    }
    txts[0].removeAttribute("readonly");

});

</script>
<div style="text-align:center;">
</div>
</body>
</html>