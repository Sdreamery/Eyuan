package com.eyuan.web;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.po.Pclass;
import com.eyuan.po.Product;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.IndexService;
import com.eyuan.util.JsonUtil;
import com.eyuan.util.Page;

/**
 * 首页模块
 */
@WebServlet("/index")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static IndexService indexService = new IndexService();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//得到请求行为
		String action = request.getParameter("action");
		//判断行为
		if ("listAll".equals(action)) {//商城界面
			indexView(request,response,2,null,null,null,null);
		} else if ("listFu".equals(action)) {//选择父类类别的商品
			String parentid = request.getParameter("parentid");
			request.setAttribute("parentid",parentid);//回传参数
			indexView(request,response,2,parentid,null,null,null);
		} else if ("listZi".equals(action)) {//选择子类类别的商品
			String cid = request.getParameter("cid");
			request.setAttribute("cid",cid);//回传参数
			indexView(request,response,2,null,cid,null,null);
		} else if ("listSort".equals(action)) {
			String cid = request.getParameter("cid");//得到子类id
			String parentid = request.getParameter("parentid");//得到父类id
			String sort = request.getParameter("sort");//得到排序条件
			request.setAttribute("parentid",parentid);//回传参数
			request.setAttribute("cid",cid);//回传参数
			request.setAttribute("sort",sort);//回传参数
			indexView(request,response,2,parentid,cid,sort,null);
		} else if ("serch".equals(action)) {
			String keyWord = request.getParameter("keyWord");
			request.setAttribute("keyWord",keyWord);//回传参数
			indexView(request,response,2,null,null,null,keyWord);
		} else if("listByParentId".equals(action)){//根据父类商品类别列出商品
			listByParentId(request,response);
		} else { //首页界面
			indexView(request,response,1,null,null,null,null);
		}
				
	}
	
	/**
	 * 根据传来的商品类别父类的id检索出商品
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void listByParentId(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//2、得到商品父类id
		String cid = request.getParameter("cid");
		//1、调用Service层查询，返回Product对象集合
		List<Product> products = indexService.listByParentId(cid);
		JsonUtil.toJson(products, response);
	}
	/**
	 * 展示首页
	 * @param request
	 * @param response
	 * @param sort 
	 * @param cid 
	 * @param parentid 
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void indexView(HttpServletRequest request, HttpServletResponse response,int page, String parentid, String cid, String sort,String keyWord) throws ServletException, IOException {
		if (page==1) {
			//1、调用Service层查询，返回Product对象集合
			List<Product> products = indexService.listProducts();
			//2、调用Service层查询，返回商品类别Pclass对象Map集合
			Map<Pclass, List<Pclass>> pclass = indexService.listPclass();
			//2.把Product对象集合、商品类别Pclass对象Map集合存到request作用域
			request.setAttribute("products", products);
			request.setAttribute("pclass", pclass);
			//3.请求转发到index.jsp
			request.getRequestDispatcher("index.jsp").forward(request, response);
		} else if (page==2) {
			//  1、调用Service层查询，返回商品类别Pclass对象Map集合
			Map<Pclass, List<Pclass>> pclass = indexService.listPclass();
			//  2.把Product对象集合、商品类别Pclass对象Map集合存到request作用域
			request.setAttribute("pclass", pclass);
			//  3、接收参数（当前页、每页显示的数量）
			String pageNumStr = request.getParameter("pageNum");
			String pageSizeStr = request.getParameter("pageSize");
			// 再次设置action
			request.setAttribute("action", request.getParameter("action"));
			// 4、调用Service层，返回resultInfo对象
			ResultInfo<Page<Product>> resultInfo = indexService.findProductListByPage(pageNumStr, pageSizeStr, parentid, cid, sort,keyWord);
				
			// 5、将resultInfo对象出到request作用域中
			request.setAttribute("resultInfo", resultInfo);
			
			// 6、请求转发到indexList.jsp
			request.getRequestDispatcher("index/indexList.jsp").forward(request, response);
		}
		
		
	}

}
