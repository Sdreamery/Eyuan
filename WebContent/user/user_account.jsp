<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html >
   <div class="right_style">
  <div class="title_style"><em></em>账户管理</div> 
  <div class="user_Account_style">
   <div class="user_Account">
   <div class="title_name">我的账户余额：（Eyuan钱包）</div>
   <div class="Balance clearfix">
    <p class="je_Balance">账户余额：<b>${money }</b>元 </p>
    <p class="clearfix Account_btn"><a href="user/user_recharge.jsp" class="Recharge_btn" >充值</a><a href="#" class="withdraw_btn" id="cz_Records_btn">充值记录</a></p>
   </div>
   </div>
  </div>
  </div>

  
<script type="text/javascript">
//弹出一个iframe层
$('#cz_Records_btn').on('click', function(){
    layer.open({
        type: 2,
        title: '充值记录',
        maxmin: true,
        shadeClose: true, //点击遮罩关闭层
        area : ['900px' , '450px'],
        content:'user/user_table.jsp'
    });
});
</script>