package com.eyuan.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.po.UserInfoPo;
import com.eyuan.service.CartService;

/**
 * Servlet Filter implementation class CartCountFilter
 */
@WebFilter("/*")
public class CartCountFilter implements Filter {
    public CartCountFilter() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		// 基于HTTP
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse)resp;
		// 获取请求的路径
		String path = request.getRequestURI(); // 从站点名开始到问号结束
		
		// 1、静态资源（statics目录下的资源）  放行
		if (path.contains("/statics")) {
			chain.doFilter(request, response);
			return;
		}
		
		// 2、指定页面（登录页面login.jsp、注册页面register.jsp等）	放行
		if (path.contains("/login.jsp")) {
			chain.doFilter(request, response);
			return;
		}
		// 过滤查询购物车记录数量
		long count;
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		if (user!=null) {
			String uid = user.getUid()+"";//(User)request.getSession().getAttribute("user").getUid;
			count = new CartService().cartCount(uid);
		}else{
			count = 0;
		}
		// pass the request along the filter chain
		request.setAttribute("cartCount", count);
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
