package com.eyuan.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.regex.Pattern;

import com.eyuan.po.Cart;
import com.eyuan.po.User_Order;
import com.eyuan.po.vo.CartProduct;
import com.eyuan.util.StringUtil;
import com.mysql.fabric.xmlrpc.base.Params;
import com.sun.org.apache.xpath.internal.operations.And;

@SuppressWarnings("all")
public class CartDao {

	private BaseDao baseDao = new BaseDao();
	
	/**
	 * 购物车添加记录操作
	 * Service层
	 * @param pid
	 * @param num
	 * @param size
	 * @param uid
	 * @param cartPrice 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int addCart(String pid, String num, String size, Integer uid, String cartPrice) {
		//1.定义sql
		String sql = "insert into user_cart(uid,pid,num,cartprice,size) values(?,?,?,?,?)";
		
		//设置每条记录的价格
		Double newCatrPrice = Double.parseDouble(cartPrice);
		Integer newSize = Integer.parseInt(size);
		Integer newnum = Integer.parseInt(num);
		if (newSize==1) {
			newCatrPrice = newCatrPrice*newnum;
		}
		if (newSize==2) {
			newCatrPrice = newCatrPrice*newnum*1.2;
		}
		if (newSize==3) {
			newCatrPrice = newCatrPrice*newnum*1.5;
		}
		//2.设置参数
		List params = new ArrayList<>();
		params.add(uid);
		params.add(pid);
		params.add(num);
		params.add(newCatrPrice);
		params.add(size);
		
		//3.调用baseDao，返回一个受影响的行数
		Integer row  = baseDao.executeUpdate(sql, params);
		return row;
		
	}
	
	/**
	 * 展示购物车清单
	 * @param uid
	 * @return
	 */
	public List<CartProduct> showCartList(Integer uid) {
		//1.定义sql
		String sql = "select cartid,p.pid as pid, pname, image, subTitle, u.num as num, size, cartprice, "
						+ "checked from pclass_product p "
						+ "join user_cart u on p.pid=u.pid where uid=?";
		
		//2.定义参数
		List params = new ArrayList<>();
		params.add(uid);
		
		
		//3.调用baseDao返回一个对象集合
		List<CartProduct> cartsProduct = baseDao.queryRows(sql, params, CartProduct.class);
		return cartsProduct;
	}
	/**
	 * 展示已勾选购物车清单
	 * @param uid
	 * @return
	 */
	public List<CartProduct> showCartList2(Integer uid , String[] pids) {
		//1.定义sql
		String sql = "select cartid, pname, image, subTitle, u.num as num, size, cartprice, "
						+ "checked from pclass_product p "
						+ "join user_cart u on p.pid=u.pid where uid=? ";
		if (pids.length>0) {
			sql += "and cartid in (";
			for (int i = 0; i < pids.length; i++) {
				if (i==pids.length-1) {
					sql += pids[i];
				}else {
					sql += (pids[i]+",");
				}
			}
			sql += ")";
		}
		//2.定义参数
		List params = new ArrayList<>();
		params.add(uid);

		//3.调用baseDao返回一个对象集合
		List<CartProduct> cartsProduct = baseDao.queryRows(sql, params, CartProduct.class);
		return cartsProduct;
	}
	
	/**
	 * 通过pid查询出该购物车记录对象
	 * @param pid
	 * @return
	 */
	public Cart findCartByPid(String pid) {
		//1.定义sql
		String sql = "select * from user_cart where cartid=?";
		//2.设置参数
		List params = new ArrayList<>();
		params.add(pid);
		//3.调用baseDao
		Cart cart= (Cart) baseDao.queryRow(sql, params, Cart.class);
		return cart;
	}
	
	/**
	 * 增加用户订单，返回受影响的行数
	 * @param uid
	 * @param aid 
	 * @param totalPrice
	 * @param orderNum
	 * @return
	 */
	public int addOrder(Integer uid, String aid, Double totalPrice, String orderNum) {
		//1.定义sql
		String sql = "insert into user_order(uid,o_no,pay,create_datetime,aid) values(?,?,?,now(),?)";
		//2.设置参数
		List params = new ArrayList<>();
		params.add(uid);
		params.add(orderNum);
		params.add(totalPrice);
		params.add(aid);
		//3.调用baseDao
		int row  = baseDao.executeUpdate(sql, params);
		return row;
	}

	/**
	 * 给订单字表增加记录
	 * @param oid
	 * @param string
	 * @param num
	 * @param integer 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int addItemOrder(Integer oid, Integer pid, Integer num, Integer size) {
		String sql ="insert into user_order_item(oid,pid,num,size) values(?,?,?,?)";
		List params = new ArrayList<>();
		params.add(oid);
		params.add(pid);
		params.add(num);
		params.add(size);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 购物车订单删除操作
	 * @param string
	 * @return
	 */
	public int deleteCartByPid(String pid) {
		String sql = "delete from user_cart where cartid=?";
		List params = new ArrayList<>();
		params.add(pid);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 查询出用户订单的ID通过订单编号
	 * @param orderNum
	 * @return
	 */
	public Integer findOIDByOrderNum(String orderNum) {
		String sql = "select oid from user_order where o_no=?";
		List params = new ArrayList<>();
		params.add(orderNum);
		Integer oid = (Integer) baseDao.findSingleValue(sql, params);
		return oid;
	}
	
	/**
	 * 展示已提交订单
	 * @param uid
	 * @param status 
	 * @param searchKey 
	 * @return
	 */
	public List<User_Order> findOrderListByUID(Integer uid, String status, String searchKey) {
		//1.定义sql
		String sql = "select * from user_order where uid=? ";
		List params = new ArrayList<>();
		params.add(uid);
		
		if (!StringUtil.isEmpty(status)) {
			sql+=" and status=?";
			params.add(status);
		}
		
		//判断参数的类型
		if (StringUtil.isNotEmpty(searchKey)) {
			if (isInteger(searchKey) && searchKey.length()==16) {
				sql+=" and o_no=?";
				params.add(searchKey);
			}
		}
		
		sql+=" order by oid desc";
		List<User_Order> orderList = baseDao.queryRows(sql, params, User_Order.class);
		return orderList;
	}
	
	
	/**
	 * 判断是否为整数 
	 * @param str 传入的字符串 
	 * @return 是整数返回true,否则返回false 
	 */
	public static boolean isInteger(String str) {  
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");  
        return pattern.matcher(str).matches();  
	}
	/**
	 * 删除购物车记录
	 * @param uid
	 * @param cartid
	 * @return
	 */
	public int deleteCart(Integer uid, String cartid) {
		//1、定义sql语句
		String sql = "delete from user_cart where uid = ? and cartid = ?";
		//2、传参数
		List params = new ArrayList<>();
		params.add(uid);
		params.add(cartid);
		return baseDao.executeUpdate(sql, params);
	}
	/**
	 * 查询当前用户的购物车记录数量
	 * @param uid
	 * @return
	 */
	public long cartCount(String uid) {
		//1、定义sql语句
		String sql = "select count(1) from user_cart where uid = ? ";
		//2、传参数
		List params = new ArrayList<>();
		params.add(uid);
		return (long) baseDao.findSingleValue(sql, params);
	}
	
	/**
	 * 减少库存的数量
	 * @param pid
	 * @param num
	 * @return
	 */
	public int deleteKuCun(Integer pid, Integer num) {
		String sql = "update pclass_product set num=? where pid=?";
		
		List params = new ArrayList<>();
		params.add(num);
		params.add(pid);
		
		int row = baseDao.executeUpdate(sql, params);
		
		return row;
	}
	
	/**
	 * 获取当前库存的数量
	 * @param pid
	 * @return
	 */
	public Integer findKun(Integer pid) {
		String sql = "select num from pclass_product where pid=?";
		
		List params = new ArrayList<>();
		params.add(pid);
		
		Integer num = (Integer) baseDao.findSingleValue(sql, params);
		
		return num;
	}
	
	/**
	 * 立即购买，给订单表新增一个记录
	 * @param uid
	 * @param price
	 * @param aid
	 * @param orderNum2 
	 * @return
	 */
	public int addFa(Integer uid, String price, String aid, String orderNum2) {
		//1.定义sql
		String sql = "insert into user_order(uid,o_no,pay,create_datetime,aid) values(?,?,?,now(),?)";
		//2.设置参数
		List params = new ArrayList<>();
		params.add(uid);
		params.add(orderNum2);
		params.add(price);
		params.add(aid);
		//3.调用baseDao
		int row  = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 立即购买，字表增加一条记录
	 * @param oid
	 * @param pid
	 * @param num
	 * @param size
	 * @return
	 */
	public int addSon(Integer oid, String pid, String num, String size) {
		String sql ="insert into user_order_item(oid,pid,num,size) values(?,?,?,?)";
		List params = new ArrayList<>();
		params.add(oid);
		params.add(pid);
		params.add(num);
		params.add(size);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	
	
	
}	
