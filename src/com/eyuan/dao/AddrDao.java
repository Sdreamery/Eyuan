package com.eyuan.dao;

import java.util.ArrayList;
import java.util.List;
import com.eyuan.po.UserAddr;
import com.eyuan.util.StringUtil;

public class AddrDao {
	
	private BaseDao baseDao = new BaseDao();
	
	
	public int deleteNote(String aid) {
		//定义SQL语句
		String sql = "delete from user_addr where aid = ?";
		
		List<Object> params = new ArrayList<Object>();
		
		params.add(aid);
		//受影响的行数
		int row = baseDao.executeUpdate(sql, params);
		
		return row;
	}
	
	/**进入收货地址页面
	 * Dao层
	 * @param uid
	 * @return
	 */
	public List<UserAddr> showUserAddrList(Integer uid) {
		
		String sql = "select * from user_addr where uid = ?";
		
		List<Object> params = new ArrayList<Object>();
		
		params.add(uid);
		
		List<UserAddr> userAddrs = baseDao.queryRows(sql, params, UserAddr.class);
		
		return userAddrs;
	}

	public int saveAddr(Integer uid, String aid, String r_name, String r_province, String r_city, String r_district, String r_address, String r_zip, String r_mobile, String r_phone) {
		
		String sql = "";
		List<Object> params = new ArrayList<Object>();
		
		params.add(r_name);
		params.add(r_province);
		params.add(r_city);
		params.add(r_district);
		params.add(r_address);
		params.add(r_zip);
		params.add(r_mobile);
		params.add(r_phone);
		// 判断aid是否为空，为空则是添加操作，不为空时修改操作
		if (StringUtil.isEmpty(aid)) { // 添加操作
			params.add(uid);
			sql = "insert into user_addr (r_name,r_province,r_city,r_district,r_address,r_zip,r_mobile,r_phone,uid) values (?,?,?,?,?,?,?,?,?)";
		} else {
			params.add(aid);
			sql = "update user_addr set r_name = ? ,r_province = ? ,r_city = ? , r_district = ? ,r_address = ? ,r_zip = ? ,r_mobile = ?, r_phone = ?  where aid =  ? ";
		}
		
		//受影响的行数
		int row = baseDao.executeUpdate(sql, params);
			
		return row;	
	}

}
