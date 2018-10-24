package com.eyuan.po;

import java.util.ArrayList;
import java.util.List;

import com.eyuan.dao.BaseDao;

public class UserDao {

	BaseDao baseDao =new BaseDao();
	
	public UserInfoPo findUserByUname(String uname) {

		
		// 1、写sql语句  
		String sql = "select * from user where nick = ?";
		
		List <Object> params = new ArrayList<Object>();
		params.add(uname);
		
		UserInfoPo userInfoPo = (UserInfoPo) baseDao.queryRows(sql, params, UserInfoPo.class);
		return userInfoPo;
	}
	
	

}
