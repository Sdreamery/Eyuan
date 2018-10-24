package com.eyuan.web;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.soap.Detail;

import com.eyuan.po.Pclass;
import com.eyuan.po.Product;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.IndexService;
import com.eyuan.util.Page;
import com.eyuan.util.StringUtil;

/**
 * 商城首页
 */
@WebServlet("/mall")
public class IndexMallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static IndexService indexService = new IndexService();
	
	// 获得查询条件
	String searchInfo = null;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 得到请求行为
		String action = request.getParameter("action");
		
		// 得到排序参数
		String pid = request.getParameter("pid");
		String price = request.getParameter("price");
		String num = request.getParameter("num");
		
		//========================= 排序条件  ===============================
		/*// 当进行综合排序时
		if (StringUtil.isNotEmpty(pid)) {
			// 设置页面的高亮值
			request.setAttribute("menu", "pid");
			
			// 添加分页排序参数
			searchInfo += "&pid=" + pid;
			request.setAttribute("searchInfo", searchInfo);
		}
		// 当进行价格排序时
		if (StringUtil.isNotEmpty(price)) {
			// 设置页面的高亮值
			request.setAttribute("menu", "price");
			
			// 添加分页排序参数
			searchInfo += "&price=" + price;
			request.setAttribute("searchInfo", searchInfo);
		}
		// 当进行销量排序时
		if (StringUtil.isNotEmpty(num)) {
			// 设置页面的高亮值
			request.setAttribute("menu", "num");
			
			// 添加分页排序参数
			searchInfo = "&num=" + num;
			request.setAttribute("searchInfo", searchInfo);
		}*/
		//========================= 排序条件  ===============================
	
		////////////////////////// 判断行为 ////////////////////////////////////
		if ("searchType".equals(action)) {  // 商品类型查询
			// 得到商品类型
			String cid = request.getParameter("cid");
			
			// 将用户行为和查询条件存到request作用域中  (给分页跳转和类型搜索使用的参数)
			searchInfo =  "&action=" + action +  "&cid=" + cid;
			
			request.setAttribute("searchInfo", searchInfo);
			
			//========================= 排序条件  ===========================
			// 默认为综合排序
			// 设置页面的高亮值
			request.setAttribute("menu", "pid");
			
			/*searchInfo = searchInfo + ("&pid=" + pid);*/
			
			// 当进行价格排序时
			if (StringUtil.isNotEmpty(price)) {
				// 设置页面的高亮值
				request.setAttribute("menu", "price");
			}
			
			// 当进行销量排序时
			if (StringUtil.isNotEmpty(num)) {
				// 设置页面的高亮值
				request.setAttribute("menu", "num");
			}
			//========================= 排序条件  ===========================
			
			// 商品类型分页查询商品列表
			productListByPage(request, response, cid, null, pid, price, num);
			
		} else if ("searchKey".equals(action)) { // 商品信息搜索
			// 得到商品信息的值
			String detail = request.getParameter("detail");
			
			// 将商品信息的值设置到request作用域中（回显）
			request.setAttribute("detail", detail);
			
			// 将用户行为和查询条件存到request作用域中  (给分页跳转和类型搜索使用的参数)
			searchInfo =  "&action=" + action +  "&detail=" + detail;
			
			request.setAttribute("searchInfo", searchInfo);
			
			//========================= 排序条件  ===========================
			// 默认为综合排序
			// 设置页面的高亮值
			request.setAttribute("menu", "pid");
			
			// 当进行价格排序时
			if (StringUtil.isNotEmpty(price)) {
				// 设置页面的高亮值
				request.setAttribute("menu", "price");
			}
			
			// 当进行销量排序时
			if (StringUtil.isNotEmpty(num)) {
				// 设置页面的高亮值
				request.setAttribute("menu", "num");
			}
			//========================= 排序条件  ===========================
			
			// 商品信息分页查询商品列表
			productListByPage(request, response, null, detail, pid, price, num);
		
		} else {  // 无条件查询

			//========================= 排序条件  ===========================
			// 默认为综合排序
			// 设置页面的高亮值
			request.setAttribute("menu", "pid");
			
			// 当进行价格排序时
			if (StringUtil.isNotEmpty(price)) {
				// 设置页面的高亮值
				request.setAttribute("menu", "price");
			}
			
			// 当进行销量排序时
			if (StringUtil.isNotEmpty(num)) {
				// 设置页面的高亮值
				request.setAttribute("menu", "num");
			}
			//========================= 排序条件  ===========================
			
			// 无条件分页查询商品列表
			productListByPage(request, response, null, null, pid, price, num);
		
		}
		
	}
	
	
	/**
	 * 分页查询商品列表
	 *  1、接收参数（当前页、每页显示的数量）
		2、调用Service层，返回resultInfo对象
		3、将resultInfo对象存到request作用域中
		//4、设置首页动态包含的页面值
		//5、请求转发跳转到首页
	 * @param request
	 * @param response
	 * @param cid
	 * @param pname
	 * @param detail 
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void productListByPage(HttpServletRequest request, HttpServletResponse response, String cid, String detail, String pid, String price, String num) throws ServletException, IOException {
		
		// 1、接收参数（当前页、每页显示的数量）
		String pageNumStr = request.getParameter("pageNum");
		String pageSizeStr = request.getParameter("pageSize");
		
		// 2、调用Service层，返回resultInfo对象
		ResultInfo<Page<Product>> resultInfo = indexService.listProductsByPage(pageNumStr, pageSizeStr, cid, detail, pid, price, num);
		
		//2、调用Service层查询，返回商品类别Pclass对象Map集合
		Map<Pclass, List<Pclass>> pclass = indexService.listPclass();
		
		//3.把商品Product对象集合、类别Pclass对象Map集合存到request作用域
		request.setAttribute("resultInfo", resultInfo);
		request.setAttribute("pclass", pclass);
		

		////////////////////////给行为action添加排序参数 ///////////////////////
		/*// 当进行综合排序时
		if (StringUtil.isNotEmpty(pid)) {
			// 设置页面的高亮值
			request.setAttribute("menu", "pid");
			
			// 添加分页排序参数
			searchInfo = "&pid=" + pid;
			request.setAttribute("searchInfo", searchInfo);
		
			
		}
		
		// 当进行价格排序时
		if (StringUtil.isNotEmpty(price)) {
			// 设置页面的高亮值
			request.setAttribute("menu", "price");
			
			// 添加分页排序参数
			searchInfo = "&price=" + price;
			request.setAttribute("searchInfo", searchInfo);
		
		}
		
		// 当进行销量排序时
		if (StringUtil.isNotEmpty(num)) {
			// 设置页面的高亮值
			request.setAttribute("menu", "num");
			
			// 添加分页排序参数
			searchInfo = "&num=" + num;
			request.setAttribute("searchInfo", searchInfo);

		}*/
		
		// 5、请求转发跳转到首页
		request.getRequestDispatcher("index/indexList.jsp").forward(request, response);
		
	}


}
