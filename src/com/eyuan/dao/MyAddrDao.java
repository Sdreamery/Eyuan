package com.eyuan.dao;

import java.util.ArrayList;
import java.util.List;

import com.eyuan.po.UserAddr;
import com.eyuan.po.vo.ResultInfo;

/**
 * 用户地址信息 Dao层
 * @author xueyou
 *
 */
public class MyAddrDao {
	
	
	private BaseDao baseDao = new BaseDao();
	/**
	 * 查询该用户下所有用户地址
	 * Dao层
	 * @param uid
	 * @return
	 */
	public List<UserAddr> showAddrList(Integer uid) {
		//1.定义sql
		String sql = "select * from user_addr where uid=?";
		//2.设置参数
		List params = new ArrayList<>();
		params.add(uid);
		//3.调用baseDao
		List<UserAddr> list = baseDao.queryRows(sql, params, UserAddr.class);
		return list;
	}

}
