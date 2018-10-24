package com.eyuan.web;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.dao.CollectDao;
import com.eyuan.dao.ProductDao;
import com.eyuan.po.Product;
import com.eyuan.po.UserColl;
import com.eyuan.po.UserInfoPo;



/**
 * 商品详情模块
 */
@WebServlet("/product")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDao productDao = new ProductDao();
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//得到用户参数
		String  pidStr = request.getParameter("pid");
		
		if ("".equals(pidStr)||pidStr==null) {
			request.getRequestDispatcher("index").forward(request, response);
			return;
		}
		
		Product product = productDao.findProductByUserId(pidStr);
		
		//TODO 从session从获取用户id
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		UserColl uColl = new UserColl();
		if (user!=null) {
			Integer uid = user.getUid();
			//调用收藏模块，查看该商品是否被收藏  
			 uColl = new CollectDao().findColl(uid, pidStr);
		}
		
		//设置 商品对象
		request.setAttribute("product", product);
		request.setAttribute("uColl", uColl);
		//请求转发跳转到商品页面
		request.getRequestDispatcher("product.jsp").forward(request, response);
	}
	
	
}
