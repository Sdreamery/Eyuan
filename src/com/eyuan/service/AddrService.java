package com.eyuan.service;

import java.util.List;

import com.eyuan.dao.AddrDao;
import com.eyuan.po.UserAddr;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.util.StringUtil;

public class AddrService {
	
	AddrDao user_AddrDao = new AddrDao();

	
	/**
	 * 删除地址
	 * @param aid
	 * @return
	 */
	public int deleteAddr(String aid) {
		//1表示删除,0表示未删除
		int code = 0;
		//判断是否存在
		if (StringUtil.isEmpty(aid)) {
			return code;
		}
		//定义受影响的行数
		int row = new AddrDao().deleteNote(aid);
		
		if  (row > 0) {
			code = 1;
		}
		
		return code;
	}
	
	/**
	 * 进入收货地址页面
	 * @param uid
	 * @return
	 */
	public List<UserAddr> showUserAddrList(Integer uid) {
		
		//调用Dao层
		List<UserAddr> userAddrs = user_AddrDao.showUserAddrList(uid);
		
		return userAddrs;
	}
	/**
	 * 添加收货地址
	 * @param uid
	 * @param aid
	 * @param r_name
	 * @param r_province
	 * @param r_city
	 * @param r_district
	 * @param r_address
	 * @param r_zip
	 * @param r_mobile
	 * @param r_phone
	 * @return
	 */
	public ResultInfo<List<UserAddr>> saveAddr(Integer uid, String aid, String r_name, String r_province, String r_city, String r_district, String r_address, String r_zip, String r_mobile, String r_phone) {
		
		ResultInfo<List<UserAddr>> resultInfo = new  ResultInfo<>();
		
		//判断不能为空
		if (StringUtil.isEmpty(r_name)) {
			resultInfo.setCode(0);
			resultInfo.setMsg("收件人不能为空！");
			return resultInfo;
		}
		if (StringUtil.isEmpty(r_province)||StringUtil.isEmpty(r_city)||StringUtil.isEmpty(r_district)||StringUtil.isEmpty(r_address)) {
			resultInfo.setCode(0);
			resultInfo.setMsg("收件地址不能为空！");
			return resultInfo;
		}
		if (StringUtil.isEmpty(r_zip)) {
			resultInfo.setCode(0);
			resultInfo.setMsg("邮编不能为空！");
			return resultInfo;
		}
		if (StringUtil.isEmpty(r_mobile)) {
			resultInfo.setCode(0);
			resultInfo.setMsg("电话不能为空！");
			return resultInfo;
		}
		
		
		//调用Dao层，添加一条记录，返回受影响的行数
		int row = user_AddrDao.saveAddr(uid,aid,r_name,r_province,r_city ,r_district, r_address, r_zip,r_mobile, r_phone);
		
		//判断受影响的行数，返回resultInfo对象
		if ( row > 0) {
			resultInfo.setCode(1);
			resultInfo.setMsg("保存成功！");
			List<UserAddr> userAddrs = user_AddrDao.showUserAddrList(uid);
			resultInfo.setResult(userAddrs);
		} else {
			resultInfo.setCode(0);
			resultInfo.setMsg("保存失败！");
		}
		
		return resultInfo;
	
	}

}
