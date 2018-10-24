package com.eyuan.service;

import java.util.ArrayList;
import java.util.List;

import com.eyuan.dao.AccountDao;
import com.eyuan.po.Product;

/**
 * 用户资金模块 Service层
 * @author xueyou
 *
 */
public class AccountService {
	
	AccountDao accountDao = new AccountDao();
	/**
	 *  响应个人中心的所有请求信息:个人账户、订单数、订单产品信息、收藏商品信息
	 * @param uid
	 * @return
	 */
	public List<Object> userCenter(Integer uid) {
		List<Object> list = new ArrayList<>();
		//1.查询个人账户余额
		Double money = accountDao.findBalance(uid);
		//2.查询已发货订单数量
		long orders = accountDao.findPaiedOrders(uid);
		//3.查询收藏商品数量
		long collects = accountDao.findCollects(uid);
		//4.查询个人收获地址数量
		long addrs = accountDao.findAddrs(uid);
		//5.查询已完成订单的商品信息集合
		List<Product> products1 = accountDao.findProducts1(uid);
		//6.查询已收藏商品信息集合
		List<Product> products2 = accountDao.findProducts2(uid);
		list.add(money);
		list.add(orders);
		list.add(collects);
		list.add(addrs);
		list.add(products1);
		list.add(products2);
		return list;
	}
	
}
