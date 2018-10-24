<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>充值中心</title>

<link rel="stylesheet" type="text/css" href="/eyuan/statics/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css" href="/eyuan/statics/css/main.css" />
<link rel="stylesheet" type="text/css" href="/eyuan/statics/sweetalert/sweetalert2.min.css" />
<style type="text/css">
 input[type="number"]{
        -moz-appearance: textfield;
    }
 input::-webkit-inner-spin-button {
        -webkit-appearance: none;
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
function checkPsw(){
	var txts = $("input[type='password']");
	var psw = "";
	for(var i = 0;i<txts.length;i++){
		psw+=txts[i].value;
	}
	if (psw=="123456") {
		$("#msg").html();
		return true;
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
		<div class="tr_rechtext">
			<p class="te_retit"><img src="/eyuan/statics/img/coin.png" alt="" />充值中心</p>
			<p>1.如果您因年龄、智力等因素而不具有完全民事行为能力，请在法定监护人（以下简称"监护人"）的陪同下阅读和判断是否同意本协议，并特别注意未成年人使用条款。 </p>
			<p>2.如果您是中国大陆地区以外的用户，您订立或履行本协议还需要同时遵守您所属和/或所处国家或地区的法律。</p>
		</div>
		<form action="" class="am-form" id="doc-vld-msg">
			<div class="tr_rechbox">
				<div class="tr_rechhead">
					<img src="/eyuan/statics/img/ys_head2.jpg" />
					<p>充值帐号：
						<a>${user.nick }</a>
					</p>
					<div class="tr_rechheadcion">
						<img src="/eyuan/statics/img/coin.png" alt="" />
					</div>
				</div>
				<div class="tr_rechli am-form-group">
					<ul class="ui-choose am-form-group" id="uc_01">
						<li>
							<label class="am-radio-inline">
									<input type="radio"  value="" name="docVlGender" required data-validation-message="请选择一项充值额度"> 100￥
								</label>
						</li>
						<li>
							<label class="am-radio-inline">
									<input type="radio" name="docVlGender" data-validation-message="请选择一项充值额度"> 200￥
								</label>
						</li>

						<li>
							<label class="am-radio-inline">
									<input type="radio" name="docVlGender" data-validation-message="请选择一项充值额度"> 500￥
								</label>
						</li>
						<li>
							<label class="am-radio-inline">
									<input type="radio" name="docVlGender" data-validation-message="请选择一项充值额度"> 其他金额
								</label>
						</li>
					</ul>
					<!--<span>1招兵币=1元 10元起充</span>-->
				</div>
				<div class="tr_rechoth am-form-group">
					<span>其他金额：</span>
					<input type="number"  style="width: 130px;  height:40px"   class="othbox"  />
					<!--<p>充值金额范围：10-10000元</p>-->
				</div>
				<div class="tr_rechcho am-form-group">
					<span>充值方式：</span>
					<label class="am-radio">
							<input type="radio" name="radio1" value="weixin" data-am-ucheck required data-validation-message="请选择一种充值方式"><img src="/eyuan/statics/img/wechatpay.png">
						</label>
					<label class="am-radio" style="margin-right:30px;">
							<input type="radio" name="radio1" value="zhifubao" data-am-ucheck data-validation-message="请选择一种充值方式"><img src="/eyuan/statics/img/zfbpay.png">
						</label>
				</div>
				<div class="tr_rechnum">
					<span>应付金额：</span>
					<p class="rechnum"></p>
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
				<input type="button" value="确认支付" onclick="return mySubmit()"  class="tr_pay am-btn" />
				<span>温馨提示：个人账户金额不能兑换现金，不能进行转账交易，不能兑换本公司体系外的产品和服务。。</span>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript" src="/eyuan/statics/js/jquery.min.js"></script>
<script type="text/javascript" src="/eyuan/statics/js/amazeui.min.js"></script>
<script type="text/javascript" src="/eyuan/statics/js/ui-choose.js"></script>
<script type="text/javascript" src="/eyuan/statics/sweetalert/sweetalert2.min.js"></script>

<script type="text/javascript">
	//获取到金额数
	function mySubmit(){
		var moneyStr  = $('.rechnum').text();
		if ("" == moneyStr || moneyStr==null) {
			swal(
				'',
				'充值金额不能为空！',
				'error'
				)
			return false;
		}
		
		var myval= $('input[name="radio1"]:checked').val();
        if("" == myval || myval==null){
        	swal(
    			'',
    			'请选择支付方式！',
    			'error'
    			)
            return false;
        }
        
		var money = parseFloat(moneyStr);
		var method1 = $('input[name="radio1"]:checked ').val();
		var method;
		if(method1=="weixin"){
			method=1;
		}else{
			method=2;
		}
		if(checkPsw()){
		//发送ajax
	 	$.ajax({
			url:"/eyuan/account",
			type:"post",
			data:{"action":"deposit","money":money,"method":method},
			success:function(result){
				if(result==1){  //成功
					//提示成功
					swal(
					  '恭喜！充值成功！',
					  '两秒后跳转个人资金中心',
					  'success'
					)
					window.setTimeout(test, 2000);
				}else{
					swal(
						'哎哟！',
						'系统繁忙！',
						'error'
						)
				}
			}
		});
		}
		return false;
}
	
	
function test(){
		window.location= "../account?action=showAccount";
}
	 
	

	// 将所有.ui-choose实例化
	$('.ui-choose').ui_choose();
	// uc_01 ul 单选
	var uc_01 = $('#uc_01').data('ui-choose'); // 取回已实例化的对象
	uc_01.click = function(index, item) {
		console.log('click', index, item.text())
	}
	uc_01.change = function(index, item) {
		console.log('change', index, item.text())
	}
	$(function() {
		$('#uc_01 li:eq(3)').click(function() {
			$('.tr_rechoth').show();
			$('.tr_rechoth').find("input").attr('required', 'true')
			$('.rechnum').text('100.00元');
		})
		$('#uc_01 li:eq(0)').click(function() {
			$('.tr_rechoth').hide();
			$('.rechnum').text('100.00元');
			$('.othbox').val('');
		})
		$('#uc_01 li:eq(1)').click(function() {
			$('.tr_rechoth').hide();
			$('.rechnum').text('200.00元');
			$('.othbox').val('');
		})
		$('#uc_01 li:eq(2)').click(function() {
			$('.tr_rechoth').hide();
			$('.rechnum').text('500.00元');
			$('.othbox').val('');
		})
		$(document).ready(function() {
			$('.othbox').on('input propertychange', function() {
				var num = $(this).val();
				$('.rechnum').html(num + ".00元");
			});
		});
	})

	$(function() {
		$('#doc-vld-msg').validator({
			onValid: function(validity) {
				$(validity.field).closest('.am-form-group').find('.am-alert').hide();
			},
			onInValid: function(validity) {
				var $field = $(validity.field);
				var $group = $field.closest('.am-form-group');
				var $alert = $group.find('.am-alert');
				// 使用自定义的提示信息 或 插件内置的提示信息
				var msg = $field.data('validationMessage') || this.getValidationMessage(validity);

				if(!$alert.length) {
					$alert = $('<div class="am-alert am-alert-danger"></div>').hide().
					appendTo($group);
				}
				$alert.html(msg).show();
			}
		});
	});
	/*********************密码输入验证************************/
	$(function(){
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