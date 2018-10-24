package com.eyuan.service;

import com.eyuan.dao.UserDao;
import com.eyuan.po.User;
import com.eyuan.po.UserInfoPo;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.util.StringUtil;




public class UserService {

	private UserDao userDao = new UserDao();
	/**
	 * 用户登录
	 * @param uname
	 * @param upwd
	 * @return
	 */
	public ResultInfo<UserInfoPo> userLogin(String nick,String upwd){
		ResultInfo<UserInfoPo> resultInfo = new ResultInfo<>();
		//1、判断参数是否能为空
		if(StringUtil.isEmpty(nick)||StringUtil.isEmpty(upwd)){
		//如果为空，设置resultInfo封装类的值 code=0，msg=用户名或密码不能为空，返回resultInfo对象
			resultInfo.setCode(0);
			resultInfo.setMsg("用户名或密码不能为空！");
			return resultInfo;
		}
		//数据回显
		UserInfoPo u = new UserInfoPo();
		u.setUname(nick);
		u.setUpwd(upwd);
		
		
		//2、调用Dao层，通过用户名查询用户对象，返回user对象
		UserInfoPo user = userDao.findUserByUname(nick);
		//如果user对象为空，设置resultInfo封装类的值 code=0，msg=用户名不存在，result回显，返回resultInfo对象
		if(user==null){
			resultInfo.setCode(0);
			resultInfo.setMsg("用户名不存在!");
			resultInfo.setResult(u);
			return resultInfo;
		}
		
		//3、如果user对象不为空，判断前台传过来的密码是否和数据库查询到的密码一致
		//如果密码不一致，设置resultInfo封装类的值 code=0，msg=密码不正确，result回显，返回resultInfo对象
		if(!upwd.equals(user.getUpwd())){
			resultInfo.setCode(0);
			resultInfo.setMsg("用户密码不正确!");
			resultInfo.setResult(u);
			return resultInfo;
		}
		
		//4、登录成功
		//设置resultInfo封装类的值 code=1，msg=登录成功，result，返回resultInfo对象
		resultInfo.setCode(1);
		resultInfo.setMsg("登录成功！");
		resultInfo.setResult(user);
		
		return resultInfo;
		
	}
	
	/**
	 * 判断用户名是否唯一
	 * @param uname
	 * @return
	 */
	public int checkUserName(String uname) {
		int code = 0;
		//1.判断参数
		if (StringUtil.isEmpty(uname)) {
			return code;
		}
		//2.调用Dao层,通过用户名查询数据库是否存在user记录
		UserInfoPo user = userDao.findUserByUname(uname);
		
		//3.判断对象是否存在,存在返回0,不存在返回1
		if(user == null){
			code = 1;
		}
		return code;
	}
	
	/**
	 * 判断手机号码是否唯一
	 * @param uname
	 * @return
	 */
	public int checkPhone(String phone) {
		int code = 0;
		//1.判断参数
		if (StringUtil.isEmpty(phone)) {
			return code;
		}
		//2.调用Dao层,通过用户名查询数据库是否存在user记录
		User user = userDao.findUserByPhone(phone);
				
		//3.判断对象是否存在,存在返回0,不存在返回1
		if(user == null){
			code = 1;
		}
		return code;
	}
	
	/**
	 * 判断邮箱是否唯一
	 * @param uname
	 * @return
	 */
	public int checkEmail(String email) {
		int code = 0;
		//1.判断参数
		if (StringUtil.isEmpty(email)) {
			return code;
		}
		//2.调用Dao层,通过用户名查询数据库是否存在user记录
		User user = userDao.findUserByEmail(email);
				
		//3.判断对象是否存在,存在返回0,不存在返回1
		if(user == null){
			code = 1;
		}
		return code;
	}
	
	public ResultInfo<User> addUser(String nick,String upwd,String phone,String email) {
		ResultInfo<User> resultInfo = new ResultInfo<>();
		//判断用户名不能为空
		if (StringUtil.isEmpty(nick)) {
			resultInfo.setCode(0);
			resultInfo.setMsg("用户名不能为空！");
			return resultInfo;
		}
		//验证用户名的唯一性
		int code = checkUserName(nick);
		if (code == 0) {
			resultInfo.setCode(0);
			resultInfo.setMsg("用户名已存在，不可使用！");
			return resultInfo;
		}
		// 调用dao层,添加用户,返回受影响的行数
		int row = userDao.addUser(nick, upwd, phone, email);
		//判断受影响的行数是否大于0，设置resultInfo对象，返回resultInfo对象
		if (row>0){
			resultInfo.setCode(1);
			resultInfo.setMsg("注册成功！");
		}else {
			resultInfo.setCode(0);
			resultInfo.setMsg("注册失败！");
		}
		return resultInfo;
	}	
	
}
