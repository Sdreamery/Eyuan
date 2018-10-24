package com.eyuan.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.po.UserInfoPo;
import com.eyuan.util.StringUtil;

/**
 *  非法拦截与自动登录
 * 什么时候该放行
 * 	1、指定资源 放行 （静态资源html、js、css、images）
 * 	2、指定页面 放行 （登录页面、注册页面  ---  不需要登录就能访问的页面都放行）
 * 	3、指定行为 放行 （登录操作、自动登录操作、注册操作）
 * 	4、登录状态 放行 （对应的session作用域中是否有值  user对象）
 * 	5、判断cookie是否为空
 * 		如果cookie不为空，得到用户名和密码，调用登录方法
 * 拦截之后做什么
 *	跳转到登录页面
 * @author 威威
 *
 */
@WebFilter("/*")
public class LoginIntercept implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("拦截器初始化~~~");
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		//基于HTTP协议,所以先转化类型
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
	
		// 得到请求的路径,得到站点名+资源路径
		String requestUri = request.getRequestURI();
		
		//放行无需登陆就能查看的界面
		if (requestUri.contains("/mall") || requestUri.contains("/index") || requestUri.contains("/product") || requestUri.contains("other")) {
			
			chain.doFilter(request, response);
			return ;
		}
		//放行鼠标移入购物车请求详情
		if ("cartList".equals(request.getParameter("action"))) {
			chain.doFilter(request, response);
			return ;
		}
		
		// 放行指定资源  （静态资源 html、js、css、images）
		if (requestUri.contains("/statics")) {
			chain.doFilter(request, response);
			return ;
		}
		
		// 放行指定页面 （登录页面、注册页面  ---  不需要登录就能访问的页面都放行）
		if (requestUri.indexOf("/login.jsp") != -1||requestUri.indexOf("/register.jsp") != -1) {
			chain.doFilter(request, response);
			return ;
		}
		
		// 放行指定行为  action (登录操作、自动登录操作)
		String action = request.getParameter("action");
		if (requestUri.contains("/user")&&!requestUri.contains("/user.jsp")) {
			if (!requestUri.contains("/userOrder")){
				chain.doFilter(request, response);
				return ;
			}
		}
	
		// 登录状态  放行 （session作用域中的user对象不为空）
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		if (user != null) {
			chain.doFilter(request, response);
			return ;
		}
	
		/** 判断cookie是否为空  如果cookie不为空，
		 * 得到用户名和密码，调用自动登录方法
		*	获取Cookie对象,可能不止一个
		*	判断cookies是否为空
		*/		
		Cookie[] cookies = request.getCookies();
		if (cookies != null && cookies.length >0) {
			for (Cookie cookie : cookies) {//遍历一个个Cookie对象
				//拿到cookie名为user的cookie
				String uname = cookie.getName();
				if ("user".equals(uname)) {
					String value = cookie.getValue();
					if (StringUtil.isEmpty(value)) {
						response.sendRedirect("login.jsp");
						return ;
					} else {
						//获取用户名和密码
						String userName = value.split("-")[0];
						String userPwd = value.split("-")[1];
						//调用自动登录方法
						request.getRequestDispatcher("user?action=login&userName=" + userName + "&userPwd=" + userPwd).forward(request, response);
						return ;
					}
				}
			}
		}
		
		//拦截跳转到登录页面
		response.sendRedirect("login.jsp");
		
	}

	@Override
	public void destroy() {
		System.out.println("拦截器被销毁~~~");
		
	}

}
