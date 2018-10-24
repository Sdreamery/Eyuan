package com.eyuan.service;

import java.util.List;

import com.eyuan.dao.MyAddrDao;
import com.eyuan.po.UserAddr;
import com.eyuan.po.vo.ResultInfo;

/**
 * 用户地址Service层
 * @author xueyou
 *
 */
public class UserAddrService {
	
	private MyAddrDao addrDao = new MyAddrDao();
	
	/**
	 * 查询该用户下所有用户地址
	 * Service层
	 * @param uid
	 * @return
	 */
	public ResultInfo<List> showAddrList(Integer uid) {
		ResultInfo<List> resultInfo = new ResultInfo<>();
		//调用Dao层查询
		List<UserAddr> list  = addrDao.showAddrList(uid);
		
		if (list!=null && list.size()>0) {
			resultInfo.setCode(1);
			resultInfo.setResult(list);
		}else {
			resultInfo.setCode(0);
			resultInfo.setMsg("暂未添加地址！！");
		}
		return resultInfo;
	}
	
	
}
