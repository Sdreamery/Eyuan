package com.eyuan.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.dao.AccountDao;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.PayCount;
import com.eyuan.service.AccountService;
import com.eyuan.util.JsonUtil;

/**
 * 用户资金模块、个人中心模块
 * @author xueyou
 *
 */
@WebServlet("/account")
public class UserAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private AccountService aService = new AccountService();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if ("showAccount".equals(action)) {
			//显示账户余额
			showAccount(request,response);
		}else if ("deposit".equals(action)) {
			//充值
			UserDeposit(request,response);
		}else if ("showCount".equals(action)) {
			//获取到页面的充值记录
			showCount(request,response);
		}else if ("userCenter".equals(action)) {
			//响应个人中心的所有请求信息
			userCenter(request,response);
		}
	}
	/**
	 * 响应个人中心的所有请求信息
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void userCenter(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.从session中获取uid
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		//2.调用Dao层，返回记录集合
		List<Object> list = aService.userCenter(uid);
		
		//3.把集合转换为字符串,回调给ajax
		JsonUtil.toJson(list, response);
		
	}

	/**
	 * 展示页面充值记录
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void showCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.从session中获取uid
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//2.调用Dao层，返回记录集合
		List<PayCount> list = new AccountDao().findList(uid);
		
		//3.把集合转换为字符串,回调给ajax
		JsonUtil.toJson(list, response);
		
	}
	
	
	/**充值
	 * Servlet层
	 * 1.获取到用户名
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void UserDeposit(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//TODO  1.从session中获取用户id,接受参数
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		String money = request.getParameter("money");
		String method = request.getParameter("method");
		
		//2.调用Dao层，返回受影响的行数
		int row = new AccountDao().deposit(uid,money,method);
		
		//3.响应给ajax会调函数
		response.getWriter().write(""+row);
		response.getWriter().close();
	}
	
	
	
	
	

	/**显示账户余额
	 * Servlet层
	 * 1.获取uid
	 * 2.调用Dao层，查询充值总额
	 * 3.调用Dao层，查询消费总额
	 * 4.把账号先额存到作用域，请求转发到个人账号资金页面
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void showAccount(HttpServletRequest request, HttpServletResponse response) throws  IOException, ServletException {
		//1.获取uid TODO
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
	 	
	 	//2.调用Dao层，查询充值总额
	 	Double num1 = new AccountDao().findRecharge(uid);
	 	
	 	//3.调用Dao层，查询消费总额
	 	Double num2 = new AccountDao().findPay(uid);
	 	
	 	//4.把账号先额存到作用域，请求转发到个人账号资金页面
	 	request.setAttribute("money", num1-num2);
	 	
	 	//5.设置动态页面包含值
	 	request.setAttribute("userChangePage", "user/user_account.jsp");
	 			
	 	//6.请求转发到user.jsp
	 	request.getRequestDispatcher("user.jsp").forward(request, response);
	 	
	}
	
	
	

}
