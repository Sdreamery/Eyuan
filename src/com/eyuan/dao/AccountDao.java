package com.eyuan.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import com.eyuan.po.Product;
import com.eyuan.po.vo.Money;
import com.eyuan.po.vo.PayCount;

@SuppressWarnings("all")
public class AccountDao {
	
	
	private BaseDao baseDao = new BaseDao();
	/********************个人中心查询**************************/
	/**
	 * 查询个人账户余额（充值总额-支付总额）
	 * @param uid
	 * @return
	 */
	public Double findBalance(Integer uid) {
		String sql = "SELECT sum(case style when 0 then money else - money end) from user_account where uid = ? ";
		
		List params = new ArrayList<>();
		params.add(uid);
		
		double moneys = (double) baseDao.findSingleValue(sql, params);
		
		return moneys;
	}
	/**
	 * 查询已发货订单数量
	 * @param uid
	 * @return
	 */
	public long findPaiedOrders(Integer uid) {
		String sql = "select count(1) from user_order where status = 3 and uid = ? ";
		
		List params = new ArrayList<>();
		params.add(uid);
		
		long orders = (long) baseDao.findSingleValue(sql, params);
		
		return orders;
	}
	/**
	 * 查询收藏商品数量
	 * @param uid
	 * @return
	 */
	public long findCollects(Integer uid) {
		String sql = "select count(1) from user_collect where uid = ? ";
		

		List params = new ArrayList<>();
		params.add(uid);
		
		long collects = (long) baseDao.findSingleValue(sql, params);
		
		return collects;
	}
	/**
	 * 查询个人收货地址数量
	 * @param uid
	 * @return
	 */
	public long findAddrs(Integer uid) {
		String sql = "select count(1) from user_addr where uid = ? ";
		

		List params = new ArrayList<>();
		params.add(uid);
		
		long addrs = (long) baseDao.findSingleValue(sql, params);
		
		return addrs;
	}
	/**
	 * 查询已完成订单的产品信息集合
	 * @param uid
	 * @return
	 */
	public List<Product> findProducts1(Integer uid) {
		//连表查询该用户订单状态为4（交易成功）的订单商品信息集合
		String sql = "select  p.pid pid,cid,pname pname,subTitle,detail,image,price,oi.num num from pclass_product p  left join  user_order_item  oi on oi.pid = p.pid left join user_order o on oi.oid =  o.oid WHERE o.status = 4 and o.uid = ? GROUP BY p.pid;";

		List params = new ArrayList<>();
		params.add(uid);
		
		List<Product> products1 = baseDao.queryRows(sql, params, Product.class);
		
		return products1;
	}
	/**
	 * 查询已收藏商品信息集合
	 * @param uid
	 * @return
	 */
	public List<Product> findProducts2(Integer uid) {
		//连表查询该用户收藏的订单商品信息集合
		String sql = "select  p.pid pid,cid,pname,subTitle,detail,image,price,num from pclass_product p  left join  user_collect  uc on uc.pid = p.pid WHERE uid = ? ";

		List params = new ArrayList<>();
		params.add(uid);
		
		List<Product> products2 = baseDao.queryRows(sql, params, Product.class);
		
		return products2;
	}
	/**********************************************/
	/**
	 * 查询充值总额
	 * @param uid
	 * @return
	 */
	public Double findRecharge(Integer uid) {
		String sql = "select money from user_account where uid=? and style=0";
		
		List params = new ArrayList<>();
		params.add(uid);
		
		List<Money> moneys = baseDao.queryRows(sql, params, Money.class);
		
		Double num =0.00;
		
		for (Money m1 : moneys) {
			num += m1.getMoney();
		}
		return num;
	}
	/**
	 * 查询交易支付的总金额
	 * @param uid
	 * @return
	 */
	public Double findPay(Integer uid) {
		String sql = "select money from user_account where uid=? and style=1";
		
		List params = new ArrayList<>();
		params.add(uid);
		
		List<Money> moneys = baseDao.queryRows(sql, params, Money.class);
		
		Double num =0.00;
		
		for (Money m1 : moneys) {
			num += m1.getMoney();
		}
		return num;
	}
	
	/**
	 * 充值
	 * @param uid
	 * @param money
	 * @param method 
	 * @return
	 */
	public int deposit(Integer uid, String money, String method) {
		String sql = "insert into user_account(uid,money,method,recharge_time,payNum,style) values(?,?,?,now(),?,0)";
		String payNum = getOrderNum();
		
		List params = new ArrayList<>();
		params.add(uid);
		params.add(Double.parseDouble(money));
		params.add(Integer.parseInt(method));
		params.add(payNum);
		
		int row  = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 随机生成一个订单号
	 */
	public String getOrderNum(){
		String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
		String secnods = new SimpleDateFormat("HHmmss").format(new Date());
		Random rad = new Random();
		
		String result = rad.nextInt(100)+"";
		
		if (result.length()==1) {
			result = "0" +result;
		}
		
		return date+secnods+result;
	}
	
	/**
	 *  展示页面充值记录
	 * @param uid
	 * @return
	 */
	public List<PayCount> findList(Integer uid) {
		String sql = "select money, recharge_time as time, method, payNum from user_account where uid =? and style=0";
		
		List params = new ArrayList<>();
		params.add(uid);
		
		List<PayCount> list = baseDao.queryRows(sql, params, PayCount.class);
		
		return list;
	}



}
