package com.eyuan.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.po.User;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.UserService;


@WebServlet("/user")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private UserService userService = new UserService();   
    
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//得到用户行为
		String action = request.getParameter("action");
		if("login".equals(action)){
			//用户登录
			userLogin(request,response,0);
		}else if("checkName".equals(action)){
			//检查用户名唯一
			checkUserName(request,response);
		}else if("checkPhone".equals(action)){
			//检查手机号码唯一
			checkPhone(request,response);
		}else if("checkEmail".equals(action)){
			//检查邮箱唯一
			checkEmail(request,response);
		}else if("register".equals(action)){
			//注册
			checkRegister(request,response);
		}else if ("logOut".equals(action)) {
			//退出登录
			userLogOut(request,response);
		}else{
			//跳转到登录页面
			response.sendRedirect("login.jsp");
		}
	}
	/**
	 * 退出登录
	 * 	1、销毁session
	 * 	2、删除cookie
	 * 	3、跳转到登录页面
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void userLogOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 1、销毁session
		request.getSession().invalidate();
		// 2、删除cookie
		Cookie cookie = new Cookie("user", null);
		// 设置maxAge为0
		cookie.setMaxAge(0);
		// 响应
		response.addCookie(cookie);
		// 3、跳转到登录页面
		response.sendRedirect("login.jsp");
		
	}

	/**
	 * 用户注册
	 * @param request
	 * @param response
	 * @throws ServletException 
	 * @throws IOException 
	 */
	private void checkRegister(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		//1、接收参数
		String nick = request.getParameter("userName");
		String upwd = request.getParameter("userPwd");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		// 2、调用Service层，返回resultInfo封装类
		ResultInfo<User> resultInfo = userService.addUser(nick, upwd, phone, email);
		// 3、判断是否注册成功
		if (resultInfo.getCode() == 1) { // 登录成功
			//直接登录
			userLogin(request, response,1);
			int code = 1;
			PrintWriter out = response.getWriter();
			out.write(code+"");
			out.close();
		}else{
			//注册失败
			// 1、将resultInfo对象存到request作用域中
			request.setAttribute("resultInfo", resultInfo);
			// 2、请求转发到注册页面
			request.getRequestDispatcher("register.jsp").forward(request, response);
		}
	}

	/**
	 * 判断邮箱是否唯一
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void checkEmail(HttpServletRequest request,HttpServletResponse response) throws IOException {
		//1.接收参数(邮箱)
		String email = request.getParameter("email");
		//2.调用Service层,返回code;1=不存在,0=存在;
		int code = userService.checkEmail(email);
		//3.响应回ajax
		PrintWriter out = response.getWriter();
		out.write(code+"");
		out.close();
	}

	/**
	 * 判断手机号是否唯一
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void checkPhone(HttpServletRequest request,HttpServletResponse response) throws IOException {
		//1.接收参数(手机号)
		String phone = request.getParameter("phone");
		//2.调用Service层,返回code;1=不存在,0=存在;
		int code = userService.checkPhone(phone);
		//3.响应回ajax
		PrintWriter out = response.getWriter();
		out.write(code+"");
		out.close();
	}

	/**
	 * 判断用户名是否唯一
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private void checkUserName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.接收参数(用户名)
		String uname = request.getParameter("userName");
		//2.调用Service层,返回code;1=不存在,0=存在;
		int code = userService.checkUserName(uname);
		//3.响应回ajax
		PrintWriter out = response.getWriter();
		out.write(code+"");
		out.close();
	}
	
	

	private void userLogin(HttpServletRequest request, HttpServletResponse response,int auto) throws IOException, ServletException {
		
//		1、接收参数（用户名(昵称)、密码）
		String nick = request.getParameter("userName");
		String upwd = request.getParameter("userPwd");
		
//		2、调用Service层，返回resultInfo封装类
		ResultInfo<UserInfoPo> resultInfo = userService.userLogin(nick, upwd);
		
//		3、判断是否登录成功
		if(resultInfo.getCode()==1){
			//登录成功
//			1、将用户信息存到session作用域中
			request.getSession().setAttribute("user", resultInfo.getResult());
//			2、判断是否记住密码，如果是，存cookie对象
			String rem = request.getParameter("rem");
			if("1".equals(rem)){
				Cookie cookie = new Cookie("user", nick+"-"+upwd);
				//设置三天失效
				cookie.setMaxAge(3*24*60*60);
				//响应
				response.addCookie(cookie);
			}
			if(auto==0){
				//3、重定向到首页
				response.sendRedirect("index");
			}
			
		}else {
			//登录失败
//			1、将resultInfo对象存到request作用域中
			request.setAttribute("resultInfo", resultInfo);
//			2、请求转发到登录页面
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}
