package com.eyuan.filter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

/**
 * 字符集处理（请求乱码）
 * 					Tomcat8及以上版本					Tomcat7及以下版本
 * GET请求			不会乱码，不需要处理					会乱码
 * 													new String(request.getParameter(name).getBytes("IS0-8859-1"),"UTF-8"); (GET请求与POS均可使用，一次只处理一个参数T请求)
 * 
 * POST请求			会乱码	（Tomcat版本通用）						
 * 					1、request.setCharacterEncoding("UTF-8"); (只针对POST请求)
 * 					2、new String(request.getParameter(name).getBytes("IS0-8859-1"),"UTF-8"); (GET请求与POS均可使用，一次只处理一个参数T请求)		
 * 
 * 
 * 	1、如果是POST请求，无论是Tomcat的什么版本都可以使用request.setCharacterEncoding("UTF-8");
 * 	2、如果是GET请求，并且Tomcat版本是7及以下，需要处理乱码
 * 		
 * 
 */
@WebFilter("/*")
public class EncodeFilter implements Filter {

    public EncodeFilter() {

    }

	public void destroy() {
		
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
		
		// 基于Http
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)resp;
		
		// 设置POST请求编码
		request.setCharacterEncoding("UTF-8");
		
		// 得到请求方式 GET/POST
		String method = request.getMethod();
		
		// 得到服务器的版本信息
		String serverInfo = request.getServletContext().getServerInfo();
		//System.out.println(serverInfo); // Apache Tomcat/8.0.45
		// 得到服务器的版本号字符串
		String versionStr = serverInfo.substring(serverInfo.indexOf("/") + 1, serverInfo.indexOf("/") + 2);
		// 判断版本号字符串是否为空
		if (versionStr == null || "".equals(versionStr)) {
			return;
		}
		// 得到具体的版本号
		Integer version = Integer.parseInt(versionStr);
		// 判断GET请求并且服务器版本是否是7以下
		if ("GET".equals(method.toUpperCase()) && version < 8) {
			MyWapper myWapper = new MyWapper(request);
			// 放行
			chain.doFilter(myWapper, response);
			return;
		}
		
		
		chain.doFilter(request, response);
		
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
	
	}
	
	/**
	 * 1、定义内部类，继承HttpServletRequestWrapper包装类
	 * 2、重写getParameter()方法，处理乱码问题
	 * @author Lisa Li
	 *
	 */
	class MyWapper extends HttpServletRequestWrapper {

		// 提升request作用范围（给getParameter()使用）
		private HttpServletRequest request;
		/**
		 * 带参构造
		 * @param request
		 */
		public MyWapper(HttpServletRequest request) {
			super(request);
			this.request = request; //(把形参的值赋给类中的属性)
		}
		

		/**
		 * 重写getParameter()方法
		 */
		@Override
	    public String getParameter(String name) {
			String value  = null;
			try {
				value = new String(request.getParameter(name).getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return value;
	    }
		
	}

}

