	
	/**
	 * 表单验证
	 * @returns {Boolean}
	 */
	function checkLogin() {	
		// 得到文本框的值
		var userName = $("#userName").val();
		var userPwd = $("#userPwd").val();
		
		// 判断是否为空
		if (isEmpty(userName)) {
			$("#msg").html("* 用户名称不能为空！");
			// 聚焦
			$("#userName").focus();
			return;
		}
		if (isEmpty(userPwd)) {
			$("#msg").html("* 用户密码不能为空！");
			// 聚焦
			$("#userPwd").focus();
			return;
		}
//		//判断是否记住密码
//		var rem = 0;
//		if($("rem").prop("checked")){
//			rem=1;
//		}
		
		// 提交表单
		$("#loginForm").submit();
		
	}
	
	function check_userName() {
		  
		  var userName = document.getElementById("userName").value;
		  var regName = /^[a-zA-Z]\w{3,15}$/;
		  if (userName == "" || userName.trim() == "") {
		    document.getElementById("err_name").innerHTML = "请输入用户名";
		    return false;
		  } else if (!regName.test(userName)) {
		    document.getElementById("err_name").innerHTML = "由英文字母和数字组成的4-16位字符，以字母开头";
		    return false;
		  } else {
			//发送ajax请求
			$.ajax({
				url:"user",
				type:"post",
				data:{action:"checkName",userName:userName},
				success:function(code){
					//判断用户名是否唯一,code=1可用,code=0不可用
					if(code == 0){
						 document.getElementById("err_name").innerHTML = "该用户名已被占用";
						 return false
					}else{
						document.getElementById("err_name").innerHTML = "ok!!!";
						document.getElementById("myint1").value = "1";
					}
				}
			})
			  
		  }
		}
	function check_pwd() {
		  var pwd = document.getElementById("userPwd").value;
		  var regPwd = /^\w{4,10}$/;
		  if (pwd == "" || pwd.trim() == "") {
		    document.getElementById("err_pwd").innerHTML = "请输入密码";
		    return false;
		  } else if (!regPwd.test(pwd)) {
		    document.getElementById("err_pwd").innerHTML = "格式错误";
		    return false;
		  } else {
		    document.getElementById("err_pwd").innerHTML = "ok!!!";
		    document.getElementById("myint2").value = "1";
		  }
		}
	function check_pwd2() {
		  var pwd1 = document.getElementById("userPwd").value;
		  var pwd2 = document.getElementById("userPwd2").value;
		  if (pwd2 == "" || pwd2.trim() == "") {
		    document.getElementById("err_pwd2").innerHTML = "请输入密码";
		    return false;
		  } else if (pwd1 != pwd2) {
		    document.getElementById("err_pwd2").innerHTML = "两次输入密码不一致";
		    return false;
		  } else {
		    document.getElementById("err_pwd2").innerHTML = "ok!!!";
		    document.getElementById("myint3").value = "1";
		  }
		}
	function check_phone() {
		  var phone = document.getElementById("phone").value;
		  var regPhone = /^1[34578]\d{9}$/;
		  if (phone == "" || phone.trim() == "") {
		    document.getElementById("err_phone").innerHTML = "请输入手机号";
		    return false;
		  } else if (!regPhone.test(phone)) {
		    document.getElementById("err_phone").innerHTML = "手机号格式错误";
		    return false;
		  } else {
			//发送ajax请求
				$.ajax({
					url:"user",
					type:"post",
					data:{action:"checkPhone",phone:phone},
					success:function(code){
						//判断手机号是否唯一,code=1可用,code=0不可用
						if(code == 0){
							 document.getElementById("err_phone").innerHTML = "该手机号已被使用";
							 return false
						}else{
							document.getElementById("err_phone").innerHTML = "ok!!!";
							document.getElementById("myint4").value = "1";
						}
					}
				})
		  }
		}
	function check_email() {
		  var email = document.getElementById("email").value;
		  var regEmail = /^\w+@\w+((\.\w+)+)$/;
		  var flag;
		  if (email == "" || email.trim() == "") {
		    document.getElementById("err_email").innerHTML = "请输入邮箱";
		    return false;
		  }else if (!regEmail.test(email)) {
		    document.getElementById("err_email").innerHTML = "邮箱账号@域名。如good@tom.com、whj@sina.com.cn";
		    return false;
		  }else{
			  	//发送ajax请求
				$.ajax({
					url:"user",
					type:"post",
					data:{action:"checkEmail",email:email},
					success:function(code){
						//判断邮箱是否唯一,code=1可用,code=0不可用
						if(code == 0){
							 document.getElementById("err_email").innerHTML = "该邮箱已被使用";
						}else{
						document.getElementById("err_email").innerHTML = "ok!!!";
						document.getElementById("myint5").value = "1";
						}
					}
				})
		  }
		  
		  return flag;
		}
	
	function check_register(){
		check_userName();
		check_pwd();
		check_pwd2();
		check_phone();
		check_email();
		var a1 = document.getElementById("myint1").value;
		var a2 = document.getElementById("myint2").value;
		var a3 = document.getElementById("myint3").value;
		var a4 = document.getElementById("myint4").value;
		var a5 = document.getElementById("myint5").value;
		//console.log(a1);
		if(a1==1&&a2==1&&a3==1&&a4==1&&a5==1){
			////发送ajax请求
			$.ajax({
				url:"user",
				type:"post",
				data:{action:"register",email:email.value,phone:phone.value,userPwd:userPwd.value,userName:userName.value},
				success:function(code){
					if(code==1){
						window.location.replace("index");
					}
				}
			})
		}else{
			console.log("你好!");
		}
	}
	