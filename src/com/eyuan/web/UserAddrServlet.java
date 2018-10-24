package com.eyuan.web;

import java.io.IOException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.dao.CartDao;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.CartProduct;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.UserAddrService;

/**
 * 用户地址信息模块
 */
@WebServlet("/addr")
public class UserAddrServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private UserAddrService addrService = new UserAddrService();
    
    
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("addrListInOrder".equals(action)) {
			//显示该用户下所有用户地址、并再次查询显示购物车清单
			showAddrListInOrder(request,response);
		}
		
		
		
	}

    /**查询该用户下所有用户地址
     * Servlet层
     * 1.接受参数
     * 2.调用Service层，返回resultInfo对象
     * 3.响应给ajax回调函数
     * @param request
     * @param response
     * @throws IOException 
     * @throws ServletException 
     */
	private void showAddrListInOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//1.接受参数
		//TODO  从session从获取用户id
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		//2.获取勾选的购物车id
		String cartid = request.getParameter("cartid");
		//2.调用Service层，返回resultInfo对象
		ResultInfo<List> resultInfo = addrService.showAddrList(uid);
		if (!("".equals(cartid)||cartid==null)) {
			String [] cartidArr = cartid.split("-");//获取已勾选购物车id数组
	 		//6.再次调用CarDao层，购物车提交界面展示清单,并帅选已勾选购物车
	 		List<CartProduct> cartsProduct = new CartDao().showCartList2(uid,cartidArr);
	 		request.setAttribute("cartsProduct", cartsProduct);
		}
  		//3.将已勾选的购物车id再次转发给前台
 		request.setAttribute("cartid", cartid);
 		//4.存储查询的地址
 		request.setAttribute("resultInfo", resultInfo);
		//5.设置包含的页面
		request.setAttribute("mySubOrder", "subOrder2.jsp");
		
		//4.请求转发到cart_order.jsp
		request.getRequestDispatcher("cart/cart_order.jsp").forward(request, response);
	}
	
}
