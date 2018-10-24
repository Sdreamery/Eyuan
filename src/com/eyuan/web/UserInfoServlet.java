package com.eyuan.web;

import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.service.UserInfoService;


/**
 * Servlet implementation class UserInfoServlet
 */
@WebServlet("/userinfo")
@MultipartConfig

public class UserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//定义一个Service层的一个类的对象
	UserInfoService userInfoService = new UserInfoService();
	public static void aa(){
		System.out.println("进入user类的界面");
	}
	/**
	 * 
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//定义一个行为，接收用户行为参数
		String action=request.getParameter("action");
		
		
		if("userInfo".equals(action)){
			//判断行为是否user_info的行为模式userInfo,用户信息界面包含到user.jsp中
			findUserInfo(request,response);
			System.out.println("进入userinfo界面");
			
//==================验证唯一性start===============
		}else if("checkNick".equals(action)){
			//checkNick用户行为查询昵称,是否存在,存在返回1，被使用，不存在返回0
			findNick(request,response);
			
		}else if("checkEmail".equals(action)){
			//checkEmail用户行为查询昵称,是否存在,存在返回1，被使用，不存在返回
			findEmail(request,response);
		}else if("checkPhoenNum".equals(action)){
			//checkPhoenNum用户行为查询手机号,是否存在,存在返回1，被使用，不存在返回
			findPhoneNum(request,response);
//==================验证唯一性end===================
		}else if("updateUserInfo".equals(action)){
			System.out.println("进入修改界面");
			updateUserInfo(request,response);
		}else if("userHeadInfo".equals(action)){
			//加载头像
			userHead(request, response);
		}
	}

	
	private void userHead(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 	1、得到图片名称
		String imageName = request.getParameter("imageName");
		// 	2、得到图片存放的路径
		String filePath = request.getServletContext().getRealPath("/WEB-INF/upload/" + imageName);
		// 	3、通过路径得到file对象
		File file = new File(filePath);
		// 	4、判断file对象是否存在并且是标准文件
		if (file.exists() && file.isFile()) {
			//	5、通过截取图片名称得到图片后缀
			String pic  = imageName.substring(imageName.lastIndexOf(".") + 1, imageName.length());
			String type = "";
			// 	6、根据不同的图片后缀设置不同的响应类型
			if ("png".equalsIgnoreCase(pic)) {
				type = "image/png;charset=UTF-8";
			} else if ("gif".equalsIgnoreCase(pic)) {
				type = "image/gif;charset=UTF-8";
			} else if ("jpg".equalsIgnoreCase(pic) || "jpeg".equalsIgnoreCase(pic)) {
				type = "image/jpeg;charset=UTF-8";
			}
			response.setContentType(type);
			// 	7、利用FileUutils.copyFile()的方法，拷贝图片
			FileUtils.copyFile(file, response.getOutputStream());
		}
		
	}
	/**修改用户信息，点击确认按钮
	 * 
	 * 	1、调用Service层的方法，返回resultInfo对象
		2、将resultInfo对象存到request作用域中
		3、请求转发跳转到user?action=userCenter
	 * 
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	@SuppressWarnings("safety")
	private void updateUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//	1、调用Service层的方法，返回resultInfo对象
		@SuppressWarnings("unchecked")
		ResultInfo<UserInfoPo> resultInfo=  userInfoService.updateInfo(request);
		
		//将resultInfo对象存到request作用域中
		request.setAttribute("resultInfo", resultInfo);
		
		//请求转发跳转到user?action=userCenter
		findUserInfo(request,response);
	}
	/**测试手机号码唯一性
	 * 1.接收参数
		2.从session作用域中，得到用户Id
		3.调用Service层，返回是否存在（0存在，1不存在）
		4.响应
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void findPhoneNum(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//1.接收参数
		String userPhoneNum = request.getParameter("userPhoneNum");
		
		//2.从session作用域中，得到用户Id
		UserInfoPo user = (UserInfoPo) request.getAttribute("user");
		Integer userId =user.getUid();
		//3.调用Service层，返回是否存在（0存在，1不存在）
		Integer code = userInfoService.findPoneNum(userPhoneNum,userId);
		
		//响应
		//创建流
		PrintWriter out=response.getWriter();
		//输出
		out.write(code+"");
		//关闭流
		out.close();
				
	}
	/**
	 * email唯一性
	 * 	1.接收参数
		2.从session作用域中，得到用户Id
		3.调用Service层，返回是否存在（0存在，1不存在）
		4.响应
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void findEmail(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//接受参数
		String userEmail =request.getParameter("usrEmail");
		
		//获取用户id
		UserInfoPo user=(UserInfoPo)request.getSession().getAttribute("user");
		Integer userid=user.getUid();
	
		//调用service层，返回查询结果
		int code = userInfoService.findEmail(userEmail,userid);
		
		//响应，给Ajax的回调函数值，让回调
		//创建流，
		PrintWriter out = response.getWriter();
		//输出内容
		out.write(code);
		out.close();
		
	}
	/**
	 * 检查昵称唯一性userNick
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	private void findNick(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//接收参数
		String userNick = request.getParameter("userNick");
		//2.从session作用域中得到用户Id
		UserInfoPo user =(UserInfoPo) request.getSession().getAttribute("user");
		Integer uid = user.getUid();
		
		//调用service层
		int code = userInfoService.findNick(userNick,uid);
		
		//4、响应，利用流输出，设置返回值，返回ajax的回调函数（输出到客户端网页，只能用流）
		//创建流
		PrintWriter out = response.getWriter();
		//程序select输出到内容到容器，然后输出到connector，connector输出到，浏览器
		out.write(code + "");
		//管理输出流；
		out.close();
		
	}
	/**		
	 * 
	 * @param request
	 * @param response
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void findUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*//获取session，
		//获取参数,
		//设置作用域
		// 1、接收参数
		//UserInfoPo user=(UserInfoPo) request.getSession().getAttribute("user");
		//System.out.println(user.getBirth());
		//System.out.println(user.getNick());
		//System.out.println(user.toString());
		
		//手动创建一个UserInfoPo对象user，作为session
		UserInfoPo user = new UserInfoPo();
		user.setUid(3);
		user.setNick("wuhan");
		user.setUpwd("123456");
		user.setUname("武汉");
		user.setSex("-1");
		user.setEmail("23423qq.com");
		user.setPhone("1235878");
		user.setBirth("1992-02-03");
		user.setHead("people.png");
		request.setAttribute("user", user);*/
		
		
		String userChangePage="user/user_info.jsp";
		request.setAttribute("userChangePage",userChangePage);
		request.getRequestDispatcher("user.jsp").forward(request, response);
		
	}
	

}