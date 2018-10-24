package com.eyuan.web;

import java.io.IOException;
import java.rmi.server.UID;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import javax.print.DocFlavor.STRING;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.dao.AccountDao;
import com.eyuan.dao.CartDao;
import com.eyuan.dao.OrderDao;
import com.eyuan.po.Cart;
import com.eyuan.po.UserAddr;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.User_Order;
import com.eyuan.po.vo.CartProduct;
import com.eyuan.po.vo.DetaliOrder;
import com.eyuan.po.vo.OrderList;
import com.eyuan.po.vo.OrderNumber;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.CartService;
import com.eyuan.service.UserAddrService;
import com.eyuan.service.UserOrderService;
import com.eyuan.util.JsonUtil;
import com.eyuan.util.StringUtil;
import com.sun.xml.internal.ws.message.stream.PayloadStreamReaderMessage;

/**
 * 用户中心，用户订单Servlet层
 */
@WebServlet("/userOrder")
@SuppressWarnings("all")
public class UserOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserOrderService uOrderService = new UserOrderService();
	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if ("orderList".equals(action)) {
			//进入到用户订单列表
			userOrderList(request,response,null);
		}else if ("deleteOrder".equals(action)) {
			//删除用户指定订单
			userOrderDelete(request,response);
		}else if ("allPay".equals(action)) {
			//批量收货
			allPay(request,response);
		}else if ("allDelete".equals(action)) {
			//批量删除订单
			allDelete(request,response);
		}else if ("onePay".equals(action)) {
			//单独收货某个订单
			onePay(request,response);
		}else if ("searchKey".equals(action)) {
			String searchKey = request.getParameter("search");
			request.setAttribute("searchKey", searchKey);
			//指定订单号或者搜索框
			userOrderList(request,response,searchKey);
		}else if ("payOrder".equals(action)) {
			//支付订单
			payOrder(request,response);
		}else if ("saveOid".equals(action)) {
			//存oid到 session作用域
			saveOid(request,response);
		}else if ("detali".equals(action)) {
			//显示记录详情
			detali(request,response);
		}else if ("nowPay".equals(action)) {  
			//立刻购买
			nowPay(request,response);
		}else if ("buy".equals(action)) {   //付款验证余额
			buyOrder(request,response);
		}
		
	}
	
	/**
	 * 付款验证余额
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void buyOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.获取参数
		String price = request.getParameter("price");
		
		//TODO 获取uid
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//2.获取账户余额
		Double num1 = new AccountDao().findRecharge(uid);  //充值总额
		Double num2 = new AccountDao().findPay(uid);       //消费总额
		
		//3.判断金额
		if ((num1-num2)>Double.parseDouble(price)) { //账户余额充足
			response.getWriter().write("1");
		}else{
			response.getWriter().write("0");
		}
		response.getWriter().close();
		
	}

	/**立即购买
	 * Servlet层
	 * 1.接收参数
	 * 2.调用Service层，返回一个地址集合
	 * 3.调用Servlet层，返回一个购物车订单的对象
	 * 4.存域对象
	 * 5.设置页面动态包含值
	 * 6.请求转发到指定页面 
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void nowPay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//TODO  1.从session中获取uid
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		String pid = request.getParameter("pid");
		String num = request.getParameter("num");
		String price = request.getParameter("price");
		String subTitle = request.getParameter("subTitle");
		String image = request.getParameter("image");
		String pname = request.getParameter("pname");
		String size = request.getParameter("size");
		int size1 = Integer.parseInt(size);
		Double sizeNum = 1.0;
		if (size1==2) {
			sizeNum = 1.2;
		}
		if (size1==3) {
			sizeNum = 1.5;
		}
		//2.调用Service层，返回一个地址集合
		ResultInfo resultInfo = new UserAddrService().showAddrList(uid);
		
		//3.调用Service层，返回一个购物车订单的对象
		List<CartProduct> cartsProduct = new ArrayList<>();
		CartProduct c1 = new CartProduct();
		c1.setCartprice(Integer.parseInt(num)*Double.parseDouble(price)*sizeNum);
		c1.setImage(image);
		c1.setNum(Integer.parseInt(num));
		c1.setSubTitle(subTitle);
		c1.setPname(pname);
		cartsProduct.add(c1);
		
		/*//删除库存指定的数量，返回受影响的行数
		Integer num1 = new CartDao().findKun(Integer.parseInt(pid));
		int row = new CartDao().deleteKuCun(Integer.parseInt(pid), num1-Integer.parseInt(num));*/
		
		
		//4.存域对象
		request.setAttribute("resultInfo", resultInfo);
		request.setAttribute("cartsProduct", cartsProduct);
		request.setAttribute("pid", pid);
		request.setAttribute("size", size);
		request.setAttribute("num", num);
		//5.设置包含的页面
		request.setAttribute("mySubOrder", "subOrder2.jsp");
					
		//6.请求转发到cart_order.jsp
		request.getRequestDispatcher("cart/cart_order.jsp").forward(request, response);
	}
	
	
	/**
	 * 显示记录详情
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void detali(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.从session获取 uid,oid
		//TODO
		String oid = (String) request.getSession().getAttribute("oid");
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//2.调用Dao层，返回一个订单详情类
		DetaliOrder order = new OrderDao().detali(oid,uid);
		
		//3.将对象转成json字符串，响应给ajax回调函数
		JsonUtil.toJson(order, response);
		
	}

	/**
	 * 存oid到 session作用域
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void saveOid(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String oid = request.getParameter("oid");
		request.getSession().setAttribute("oid", oid);
		response.getWriter().write("1");
		response.getWriter().close();
	}


	/**支付订单
	 * Servlet层
	 * 1.接收参数
	 * 2.调用Service层，返回状态码
	 * 3.请求转发到指定页面
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void payOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.接收参数
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		String aid = request.getParameter("aid");
		String oid = request.getParameter("oid");
		
		//2.调用Service层，返回状态码
		int statusCode = uOrderService.payOrder(uid,oid,aid);
		
		//3.请求转发到指定订单页面
		request.getRequestDispatcher("userOrder?action=orderList&status=2").forward(request, response);
	}



	/**单独收货某个订单
	 * Servlet层
	 * 1.接受参数
	 * 2.调用Service层，返回ResultInfo对象
	 * 3.将对象转换成字符串响应给ajax回调函数
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void onePay(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.接受参数
		String oid = request.getParameter("oid");
		
		//2.调用Service层，返回ResultInfo对象
		ResultInfo resultInfo = uOrderService.onePay(oid);
		
		//3.将对象转换成字符串响应给ajax回调函数
		JsonUtil.toJson(resultInfo, response);
		
	}

	/**批量删除订单
	 * Servlet层
	 * 1.接受参数
	 * 2.调用Service层，返回ResultInfo对象
	 * 3.将对象转换成字符串响应给ajax回调函数
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void allDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.接受参数
		String status = request.getParameter("status");
		// 从session中获取uid
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//2.调用Service层，返回ResultInfo对象
		ResultInfo resultInfo = uOrderService.allDeleteByStatus(status,uid);
				
		//3.将对象转换成字符串响应给ajax回调函数
		JsonUtil.toJson(resultInfo, response);
		
	}

	/**批量收货
	 * Servlet层
	 * 1.接受参数
	 * 2.判断参数
	 * 3.调用Service层，返回ResultInfo对象
	 * 4.将对象转换成字符串响应给ajax回调函数
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void allPay(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ResultInfo resultInfo = new ResultInfo<>();
		//1.接受参数
		String status = request.getParameter("status");
		//2.判断参数
		if (!"3".equals(status)) {
			resultInfo.setCode(0);
			resultInfo.setMsg("只能批量收货待收货订单！！");
			JsonUtil.toJson(resultInfo, response);
			return;
		}
		
		//3.调用Service层，返回ResultInfo对象
		resultInfo = uOrderService.updateStatus(status);
		
		//4.将对象转换成字符串响应给ajax回调函数
		JsonUtil.toJson(resultInfo, response);
		
	}

	/**删除用户指定订单
	 * Servlet层
	 * 1.获取参数
	 * 2.调用Service层，返回一个ResultInfo对象
	 * 3.把ResultInfo对象转换成json串 响应给ajax
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void userOrderDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.获取参数
		String oid = request.getParameter("oid");
		String status = request.getParameter("status");
		//2.调用Service层，返回一个ResultInfo对象
		ResultInfo resultInfo = uOrderService.userOrderDelete(oid,status);
		
		//3.把ResultInfo对象转换成json串 响应给ajax
		JsonUtil.toJson(resultInfo, response);
		
	}

	/**进入到用户订单列表
	 * 1.从session作用域中获取到用户id
	 * 2.调用Service层，返回一个Number对象
	 * 3.调用Sercice层，把所有订单对象，遍历出来 User_Order
	 * 4.存到作用域
	 * 5.设置页面切换
	 * 6.请求转发到user.jsp
	 * @param request
	 * @param response
	 * @param searchKey 
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void userOrderList(HttpServletRequest request, HttpServletResponse response, String searchKey) throws ServletException, IOException {
		//接收订单状态码参数
		String status = request.getParameter("status");
		
		//1.从session作用域中获取到用户id
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//2.调用Service层，返回一个Number对象
		OrderNumber number = uOrderService.findNumberByUid(uid);
		
		
		
		//3.调用Sercice层，把所有订单对象，遍历出来 User_Order
		List<User_Order> orderList = new CartService().findOrderListByUID(uid,status,searchKey);
		
		//调用Sercice层，把子订单的信息查询出来
		List<OrderList> sonList = uOrderService.findSonListByUID(uid);
		//4.存到作用域
		if (!StringUtil.isEmpty(status)) {
			request.setAttribute("status", status);
		}
		request.setAttribute("number", number);
		request.setAttribute("orderList", orderList);
		request.setAttribute("sonList", sonList);
		
		//5.设置页面切换
		request.setAttribute("userChangePage", "user/user_order.jsp");
		
		//6.请求转发到user.jsp
		request.getRequestDispatcher("user.jsp").forward(request, response);
	}
	
	

}
