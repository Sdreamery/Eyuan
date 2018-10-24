package com.eyuan.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eyuan.dao.CollectDao;
import com.eyuan.po.UserColl;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.po.vo.UserCollect;
import com.eyuan.service.CollectService;
import com.eyuan.util.JsonUtil;
import com.eyuan.util.Page;

/**
 * 用户收藏模块
 */
@WebServlet("/collect")
public class CollectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CollectService cService = new CollectService();
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if ("collectList".equals(action)) {
			//收藏分页列表
			collectList(request,response);
		}else if ("addCollect".equals(action)) {
			//增加收藏
			addCollect(request,response);
		}else if ("deleteCollect".equals(action)) {
			//删除收藏
			deleteCollect(request,response);
		}
		
		
	}
		
	/**删除收藏
	 * Servlet层
	 * 1.接受参数
	 * 2.调用Dao层，删除指定的收藏记录
	 * 3.响应给ajax
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void deleteCollect(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.接受参数
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		String ctid = request.getParameter("ctid");
		String pageNum = request.getParameter("pageNum");
		
		//2.调用Dao层，删除指定的收藏记录
		int row  = new CollectDao().deleteCollect(uid,ctid);
		
		//3.调用Dao层，返回一个ResultInfo对象
		ResultInfo<UserCollect> uInfo = new CollectDao().selectCollect(uid,pageNum);
		
		//4.响应给ajax
		if (row>0) {
			uInfo.setCode(1);
			uInfo.setMsg(pageNum);
		}else {
			uInfo.setCode(0);
		}
		
		JsonUtil.toJson(uInfo, response);
		
	}

	/**增加收藏
	 * Servlet层
	 * 1.接受参数
	 * 2.调用Service层，返回一个code
	 * 3.把code返回给ajax会调函数
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void addCollect(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.接受参数  TODO
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		String pid = request.getParameter("pid");
		
		//2.调用Service层，返回一个code
		Integer code = cService.addCollect(uid,pid);
		
		//3.把code返回给ajax会调函数
		response.getWriter().write(""+code);
		
	}

	/**收藏分页列表
	 * Servlet层
	 * 1.从session中，获取到uid
	 * 2.调用Service层，返回一个ResultInfo对象
	 * 3.存作用域
	 * 4.存动态页面包含值
	 * 5.请求转发到首页
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void collectList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.从session中，获取到uid
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		String currentPage = request.getParameter("currentPage");
		String everyPage = request.getParameter("everyPage");
		
		//2.调用Service层，返回一个ResultInfo对象
		ResultInfo<Page<UserCollect>> resultInfo = cService.collectList(currentPage,everyPage,uid);
		
		//收藏的总数量
		long total = new CollectDao().countNum(uid);
		
		//3.存作用域
		request.setAttribute("resultInfo", resultInfo);
		request.setAttribute("totalNum", total);
		
		//4.设置动态包含页面
		request.setAttribute("userChangePage", "user/user_collect.jsp");
		
		//5.请求转发到首页
		request.getRequestDispatcher("user.jsp").forward(request, response);
		
	}

}
