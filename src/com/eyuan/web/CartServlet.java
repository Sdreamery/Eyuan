package com.eyuan.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.dao.CartDao;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.User_Order;
import com.eyuan.po.vo.CartProduct;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.CartService;
import com.eyuan.util.JsonUtil;
import com.eyuan.util.StringUtil;
import com.google.gson.JsonArray;
import com.sun.org.apache.bcel.internal.generic.ATHROW;

/**
 * 购物车模块
 */
@WebServlet("/cart")
@SuppressWarnings("all")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CartService cartService = new CartService();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//得到行为
		String action = request.getParameter("action");
		
		if ("addCart".equals(action)) {
			//购物车添加记录操作
			addCart(request,response);
		} else if ("cartList".equals(action)) {
			//展示购物车清单
			showCartList(request,response);
		} else if ("cartOrderList".equals(action)) {
			//购物车提交界面展示清单
			showCartOrderList(request,response);
		} else if ("order".equals(action)) {
			//购物车提交订单
			orderCart(request,response);
		}else if ("orderList".equals(action)) {
			//展示已提交订单
			orderList(request,response);
		} else if ("deleteCart".equals(action)) {
			deleteCart(request,response);
		} 
		
	}
	/**
	 * 删除单条购物车
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void deleteCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.从session中获取到用户id，写死uid==1
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		//2.获取待删除购物车的id
		String cartid = request.getParameter("cartid");
		//2.调用Dao层查询，返回一个删除记录受影响的行数，
		int row = new CartDao().deleteCart(uid,cartid);
		
		//3.把受影响的行数返回给ajax回调函数
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		pw.write(row+"");
		pw.close();
		
		
	}

	/**展示已提交订单
	 * Servlet层
	 * 1.获取参数
	 * 2.调用Service层,返回一个订单列表的集合
	 * 3.存到域对象中，
	 * 4.请求转发到指定页面
	 * @param request
	 * @param response
	 */
	private void orderList(HttpServletRequest request, HttpServletResponse response) {
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		//定义一个空
		String status =null;
		String str = null;
		//2.调用Service层,返回一个订单列表的集合
		List<User_Order> orderList = cartService.findOrderListByUID(uid,status,str);
		
		//3.存到域对象中，
		request.setAttribute("orderList", orderList);
		
	}

	
	/**
	 * 购物车提交订单
	 * Servlet层
	 * 1.接收参数
	 * 2.调用Service层,返回ResultInfo对象
	 * 3.把ResultInfo对象存到request域对象中
	 * 4.请求转发到订单支付成功页面
	 * 
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void orderCart(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//1.接收参数cartid、aid
		String cartid = request.getParameter("cartid");
		System.out.println(cartid);
		System.out.println(cartid.length());
		String aid = request.getParameter("aid");
		String price = request.getParameter("price");
		String size = request.getParameter("size");
		String pid = request.getParameter("pid");
		String num = request.getParameter("num");
		String orderNum = getOrderNum();
		//从session中获取到用户id，写死uid==1
		
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		
		//判断catrId是否为空
		if (cartid.length()==4) {  //为空
			//增加一个订单记录
			int row  = new CartDao().addFa(uid,price,aid,orderNum);
			if (row>0) {
				//查询刚才的oid
				Integer oid = new CartDao().findOIDByOrderNum(orderNum);
				//给订单字表增加记录
				int row1 = new CartDao().addSon(oid,pid,num,size);
				if (row1>0) {
					//获取当前库存的数量
					Integer num3 = new CartDao().findKun(Integer.parseInt(pid));
					//库存操作减少
					int row3 = new CartDao().deleteKuCun(Integer.parseInt(pid),num3-Integer.parseInt(num));
					if (row3>0) {
						ResultInfo resultInfo = new ResultInfo<>();
						resultInfo.setResult(oid);
						request.setAttribute("resultInfo", resultInfo);
					}
				}
			}
		}else{
			//2.调用Service层,返回ResultInfo对象
			ResultInfo resultInfo = cartService.orderCart(cartid,uid,aid);
			request.setAttribute("resultInfo", resultInfo);
		}
		
		//3.把ResultInfo对象存到request域对象中
		request.setAttribute("mySubOrder", "subOrder3.jsp");
		request.setAttribute("price", price);
		request.setAttribute("aid", aid);
		
		//4.响应ajax请求
		//JsonUtil.toJson(resultInfo,response);
		request.getRequestDispatcher("cart/cart_order.jsp").forward(request, response);
		
	}
	
	/**
	 * 购物车提交界面展示清单
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	public void showCartOrderList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.从session中获取到用户id，写死uid==1
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//2.调用Dao层查询，返回一个CartProduct对象集合，
		List<CartProduct> cartsProduct = new CartDao().showCartList(uid);
		
		//3.把CartProduct对象集合存到request作用域
		request.setAttribute("cartsProduct", cartsProduct);
		
		//4.请求转发到cart_order.jsp
		request.getRequestDispatcher("cart/cart_order.jsp").forward(request, response);
		
	}

	/**
	 * 展示购物车清单
	 * Servlet层
	 * 1.从session中获取到用户id
	 * 2.调用Dao层查询，返回一个CartProduct对象集合，
	 * 3.把对象集合转换成Json串返回给ajax回调函数
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void showCartList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.从session中获取到用户id，写死uid==1
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		List<CartProduct> cartsProduct = null;
		if (!(user==null)) {
			Integer uid = user.getUid();
			
			//2.调用Dao层查询，返回一个CartProduct对象集合，
			cartsProduct =  new CartDao().showCartList(uid);
		}
		
		
		//3.把对象集合转换成Json串返回给ajax回调函数
		
		JsonUtil.toJson(cartsProduct, response);
	}

	
	
	/**
	 * 购物车添加记录操作
	 * Servlet层
	 * 接受参数
	 * 调用Service层，返回一个ResultInfo对象
	 * 把对象转换成json字符串响应给ajax
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void addCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.接受参数	
		String pid = request.getParameter("pid");
		String num = request.getParameter("num");
		String size = request.getParameter("size");
		String cartPrice = request.getParameter("cartPrice");
		
		//这里从session作用域中接收用户id，暂时写死为1
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//2.调用Service层，返回一个ResultInfo对象
		ResultInfo resultInfo = cartService.addCart(pid,num,size,uid,cartPrice);
		
		//3.把对象转换成json字符串响应给ajax
		JsonUtil.toJson(resultInfo, response);
	}
	
	
	/**
	 * 随机生成一个订单号
	 */
	public String getOrderNum(){
		String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
		String secnods = new SimpleDateFormat("HHmmss").format(new Date());
		Random rad = new Random();
		
		String result = rad.nextInt(100)+"";
		
		if (result.length()==1) {
			result = "0" +result;
		}
		
		return date+secnods+result;
	}
}
