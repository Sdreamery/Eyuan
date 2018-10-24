package com.eyuan.dao;

import java.util.ArrayList;
import java.util.List;

import com.eyuan.po.UserInfoPo;

public class UserInfoDao {
	BaseDao baseDao =new BaseDao();
	
	/**
	 * 验证昵称（用户名）唯一性，（不包含当前用户）
	 * @param userNick
	 * @param uid
	 * @return
	 */
	public UserInfoPo findNickByNickUserId(String nick, Integer uid) {

		String sql = "select * from user where nick = ? and uid != ?";
		List<Object> paramas = new ArrayList <Object>();
		paramas.add(nick);
		paramas.add(uid);
		//查询结果存在，说明昵称，其他用户占用，null不存在，昵称可用
		UserInfoPo  userInfoPo = (UserInfoPo) baseDao.queryRow(sql, paramas,UserInfoPo.class);
		
		return userInfoPo;
	}

	
	/** 1、定义sql语句
		2、设置参数
		3、调用BaseDao
	 * @param userEmail
	 * @param userid
	 * @return
	 */
	public UserInfoPo findEmailByUserIdAndEmail(String email, Integer uid) {
		//1、定义sql语句
		String sql="select * from user where email = ? and uid != ?";
		List<Object> params = new ArrayList <Object>();
		params.add(email);
		params.add(uid);
		//调用BaseDao,返回userinfopo 对象
		UserInfoPo user = (UserInfoPo) baseDao.queryRow(sql, params,UserInfoPo.class);
		return user;
	}


	/**
	 *写SQl语句
	 *配置参数
	 *调用Bsedao
	 *返回函数
	 * @param userPhoneNum
	 * @param userId
	 * @return
	 */
	public UserInfoPo findPhoneNumByUserIdAndPhoneNum(String userPhoneNum, Integer userId) {
		
		String sql = "select * from user where phone = ? and uid != ?";
		List <Object> params = new ArrayList<Object>();
		params.add(userPhoneNum);
		params.add(userId);
		UserInfoPo userInfoPo = (UserInfoPo) baseDao.queryRow(sql, params, UserInfoPo.class);
		return userInfoPo;
	}


	public int updateInfo(Integer uid, String nick, String uname, String sex, String email, String phone, String birth, String head) {
		
		String sql = "update user set nick = ?,uname = ?,sex = ?,email = ?,phone = ?,birth = ?, head=? where uid = ?";
		List<Object> params = new ArrayList<Object>();
		params.add(nick);
		params.add(uname);
		params.add(sex);
		params.add(email);
		params.add(phone);
		params.add(birth);
		params.add(head);
		params.add(uid);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}




}

