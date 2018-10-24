package com.eyuan.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.eyuan.dao.UserInfoDao;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.util.StringUtil;

public class UserInfoService {
	//创建一个ResultInfo对象
	ResultInfo resultinfo = new ResultInfo();
	
	//创建一个UserInfoDao 对象
	UserInfoDao userInfoDao = new UserInfoDao();

	
	//根据昵称和userid找对象
	public int findNick(String userNick, Integer uid) {
		
		int code=0;
		//接收参数，判断参数
		if(StringUtil.isEmpty(userNick)){
			//为空，
			return code;
		}
		
		//2.调用dao层，通过用户id(除此ID)和用户名查询数据库，否存在user记录，
		UserInfoPo	userInfoPo = userInfoDao.findNickByNickUserId(userNick,uid);
		
		// 3、判断对象是否存在，存在返回0，不存在返回1
		if(userInfoPo == null){
			code = 1;
		}
		return code;
	}

	/**
	 * 	1.判断参数
		2调用到层
		3.判断查询的对象是否存在，存在返回0，不存在返回1
	 * @param userEmail
	 * @param usrid
	 * @return
	 */
	public int findEmail(String userEmail, Integer userid) {
		Integer code = 0;
		//1.判断参数
		if(StringUtil.isEmpty(userEmail)){
			return code;
		}
		//2调用到层
		UserInfoPo user = ((UserInfoDao) userInfoDao).findEmailByUserIdAndEmail(userEmail,userid); 
		//判断查询的对象是否存在，存在返回0，不存在返回1
		if(user == null){
			code =1;
		}
		return code;
	}

	/**
	 * @param userPhoneNum
	 * @param userId
	 * @return
	 */
	public Integer findPoneNum(String userPhoneNum, Integer userId) {
		//定义返回变量
		Integer code =0;
		//判断参数
		if(StringUtil.isEmpty(userPhoneNum)){
			return code;
		}
		//调用dao层
		UserInfoPo user = userInfoDao.findPhoneNumByUserIdAndPhoneNum(userPhoneNum, userId);
		
		//判断对象是否存在，存在即被注册，不存在即可用；
		if(userInfoDao == null){
			code = 1;
		}
		//调用Dao层
		return code;
	}


//更新用于信息
	public ResultInfo<UserInfoPo> updateInfo(HttpServletRequest request) {
		ResultInfo<UserInfoPo> resultInfo = new ResultInfo<>();
		// 1、接收参数（昵称、心情）
		
		//String nick = request.getParameter("nick");
		//String mood = request.getParameter("mood");
		//Integer uid = request.getParameter("uid");
		String nick = request.getParameter("userNick");
		String uname = request.getParameter("userName");
		//String upwd = request.getParameter("userNick");
		
		String sex = request.getParameter("userSex");
		String email = request.getParameter("usrEmail");
		String phone = request.getParameter("userPhone");
		String year = request.getParameter("userYear");
		String month = request.getParameter("userMonth");
		String day = request.getParameter("userDay");
		String birth = year+"-"+ month+"-"+day;
		
		
		// 2、判断昵称是否为空（验证昵称的唯一性）
		if (StringUtil.isEmpty(nick)) {
			resultInfo.setCode(0);
			resultInfo.setMsg("用户昵称不能为空！");
			return resultInfo;
		}
		
		// 7、从session作用域中得到用户ID
		UserInfoPo user = (UserInfoPo) request.getSession().getAttribute("user");
		
		// 验证昵称的唯一性,调用找到参数：19行
		Integer code = findNick(nick, user.getUid());
		if (code == 0) {
			resultInfo.setCode(0);
			resultInfo.setMsg("用户昵称已存在，不可使用！");
			return resultInfo;
		}
		//验证邮箱的唯一性
		code=findEmail(email, user.getUid());
		if (code == 0) {
			resultInfo.setCode(0);
			resultInfo.setMsg("邮箱已存在，不可使用！");
			return resultInfo;
		}
		//验证手机号的唯一性
		/*code=findPoneNum(phone, user.getUid());
		if (code == 0) {
			resultInfo.setCode(0);
			resultInfo.setMsg("手机号已存在，不可使用！");
			return resultInfo;
		}*/
		String head = user.getHead();
		
		
			//=================文件上传==============
			try {
				// 3、得到Part对象     file文件域的name属性值
				Part part = request.getPart("head");
				// 判断是否上传了头像
				if (part != null) {
					// 4、得到图片的名称
					String fileName = part.getSubmittedFileName();
					// 5、得到头像存放的路径
					String filePath = request.getServletContext().getRealPath("/WEB-INF/upload/");
					if (!StringUtil.isEmpty(fileName)) {
						// 6、上传图片
						part.write(filePath + fileName);
						// 更新head的值
						head = fileName;
					}
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} 
		
		
		// 8、调用Dao层，通过用户ID修改用户对象，返回受影响的行数
		int row = userInfoDao.updateInfo(user.getUid(), nick, uname,sex,email,phone,birth,head);
		// 9、判断受影响的行数是否大于0，设置resultInfo对象，返回resultInfo对象
		if (row > 0) {
			
			// 更新session作用域中的user对象
			user.setNick(nick);
			user.setUname(uname);
			user.setSex(sex);
			user.setEmail(email);
			user.setPhone(phone);
			user.setBirth(birth);
			user.setHead(head);
			
			
			// 存session作用域
			request.getSession().setAttribute("user", user);
			
			resultInfo.setCode(1);
			resultInfo.setMsg("修改成功！");
		} else {
			resultInfo.setCode(0);
			resultInfo.setMsg("修改失败！");
		}
		
		return resultInfo;
	}
}
