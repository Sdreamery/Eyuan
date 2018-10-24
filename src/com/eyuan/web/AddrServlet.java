package com.eyuan.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.po.UserAddr;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.AddrService;
import com.eyuan.util.JsonUtil;


/**
 * 用户收货地址模块
	 * 添加收货地址
	 * 1、接收参数
	 * 2、调用Service层，返回resultInfo对象
	 * 3、将resultInfo对象存到request作用域中
	 * 4、判断是否成功，成功跳转到列表页，失败返回发布页（回显）
 */
@WebServlet("/user_addr")
public class AddrServlet extends HttpServlet {
	
	private AddrService addrService = new  AddrService();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 得到用户行为
		String action = request.getParameter("action");	

		if ("editAddr".equals(action)) {
			
			// 进入收货地址页面
			editAddr(request, response);
		}else if ("saveAddr".equals(action)) {
			
			//添加收货地址
			saveAddr(request,response);
		}else if ("deleteAddr".equals(action)) {
			
			//删除收货地址
			deleteAddr(request,response);
		}
		
	}
	
	/**
	 * 添加收货地址
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveAddr(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		// 2、从session作用域中得到用户ID
		//UserAddr user = (UserAddr) request.getSession().getAttribute("user");
		//Integer uid = user.getUid();
		Integer uid = 1;
		
		String aid = request.getParameter("aid");//收货地址Id
		String r_name = request.getParameter("r_name");//姓名
		
		String r_address = request.getParameter("r_address");//详细地址
		String r_zip = request.getParameter("r_zip");//邮编
		String r_phone = request.getParameter("r_phone");//手机
		
		//调用Service层，返回resultInfo对象
		ResultInfo<UserAddr> resultInfo = new AddrService().saveAddr(uid,aid,r_name,r_address,r_zip,r_phone);

		//将resultInfo对象存到request作用域中
		request.setAttribute("resultInfo", resultInfo);
			
		//请求转发跳转到添加收货地址页面
		request.getRequestDispatcher("user.jsp").forward(request, response);*/
		
		//接受参数
		String r_name = request.getParameter("name");
		String r_province = request.getParameter("province");
		String r_city = request.getParameter("city");
		String r_district = request.getParameter("district");
		String r_address = request.getParameter("address");
		String r_zip = request.getParameter("zip");
		String r_mobile = request.getParameter("mobile");
		String r_phone = request.getParameter("phone");
		String aid = request.getParameter("aid");
		
		// 从session作用域中得到用户ID
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		// 调用Service层，返回resultInfo对象
		ResultInfo<List<UserAddr>> resultInfo = addrService.saveAddr(uid,aid,r_name,r_province,r_city ,r_district, r_address, r_zip,r_mobile, r_phone);
		
		//将resultInfo转化为json字符串回调ajax函数
		JsonUtil.toJson(resultInfo, response);
		
		
	}
	/**
	 * 删除收货地址
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void deleteAddr(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 接收参数
		String aid = request.getParameter("aid");
		
		
		// 调用Service层，返回0或1
		int code = new AddrService().deleteAddr(aid);
		
		// 响应
		response.getWriter().write(code +"");
		
		response.getWriter().close();
		
	}

	
	/**
	 * 进入添加收货地址页面
	 * Servlet层
	 * 1.获取用户id
	 * 2.调用Service层,返回一个用户地址集合
	 * 3.存到request作用域
	 * 4.设置动态包含页面
	 * 4.请求转发到 user,jsp
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	private void editAddr(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		// 接受参数
		//接受session作用域中的user对象 TODO
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//调用Service层，返回resultInfo对象
		List<UserAddr> addrList = addrService.showUserAddrList(uid);
		
		//将resultInfo对象存到request作用域中
		request.setAttribute("addrList", addrList);
		
		//设置首页动态包含的页面值
		request.setAttribute("userChangePage", "user/user_addr.jsp");
			
		//请求转发跳转到index.jsp
		request.getRequestDispatcher("user.jsp").forward(request, response);
		
		
	}

}
