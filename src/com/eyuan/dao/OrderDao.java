package com.eyuan.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import com.eyuan.po.UserAddr;
import com.eyuan.po.User_Item;
import com.eyuan.po.User_Order;
import com.eyuan.po.vo.CartProduct;
import com.eyuan.po.vo.DetaliOrder;
import com.eyuan.po.vo.OrderList;
import com.eyuan.po.vo.OrderNumber;
import com.eyuan.util.StringUtil;

/**
 * 用户中心，用户订单Dao层
 * @author xueyou
 *
 */
@SuppressWarnings("all")
public class OrderDao {
	
	private BaseDao baseDao = new BaseDao();
	
	
	/**
	 * 查询所有订单的数量，以及订单状态的数目
	 * @param uid
	 * @return
	 */
	public OrderNumber findNumberByUid(Integer uid) {
		OrderNumber number = new OrderNumber();
		//总数目的查询
		List params = new ArrayList<>();
		params.add(uid);
		//总数量
		String sql = "select count(1) from user_order where uid=?";
		long totalNum =  (long) baseDao.findSingleValue(sql, params);
		//关闭订单数量
		String sql1 = "select count(1) from user_order where uid=? and status=0";
		long num1 =  (long) baseDao.findSingleValue(sql1, params);
		//未付款订单
		String sql2 = "select count(1) from user_order where uid=? and status=1";
		long num2 =  (long) baseDao.findSingleValue(sql2, params);
		//已付款订单
		String sql3 = "select count(1) from user_order where uid=? and status=2";
		long num3 =  (long) baseDao.findSingleValue(sql3, params);
		//已发货订单
		String sql4 = "select count(1) from user_order where uid=? and status=3";
		long num4 =  (long) baseDao.findSingleValue(sql4, params);
		//交易成功订单
		String sql5 = "select count(1) from user_order where uid=? and status=4";
		long num5 =  (long) baseDao.findSingleValue(sql5, params);
		//交易成功订单
		String sql6 = "select count(1) from user_order where uid=? and status=5";
		long num6 =(long) baseDao.findSingleValue(sql6, params);
		
		//给Number对象设置值
		number.setTotalNum((int)totalNum);
		number.setNum1((int)num1);
		number.setNum2((int)num2);
		number.setNum3((int)num3);
		number.setNum4((int)num4);
		number.setNum5((int)num5);
		number.setNum6((int)num6);
		return number;
	}

	//把子订单的信息查询出来
	public List<OrderList> findSonListByUID(Integer uid) {
		//1.定义sql
		String sql = "select u.pid as pid ,subTitle, p.price as price, u.size as size,"
				+ " u.num as num, image, u.oid as oid from user_order_item u "
				+ "join pclass_product p join user_order u1 on u.oid=u1.oid"
				+ " and u.pid=p.pid where u1.uid=?";
		//2.设置参数
		List params = new ArrayList<>();
		params.add(uid);
		
		//3.调用baseDao
		List<OrderList> sonlist  = baseDao.queryRows(sql, params, OrderList.class);
		return sonlist;
	}
	
	/***
	 * 字表删除
	 * @param oid
	 * @return
	 */
	public int deleteFromSon(String oid) {
		String sql = "delete  from user_order_item where oid=?";
		List params = new ArrayList<>();
		params.add(oid);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 主表删除
	 * @param oid
	 * @return
	 */
	public int deleteFromFather(String oid) {
		String sql = "delete  from user_order where oid=?";
		List params = new ArrayList<>();
		params.add(oid);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**批量收货
	 * 
	 * @param status
	 * @return
	 */
	public int updateStatus(String status) {
		String sql = "update user_order set status=4, end_datetime=now() where status=?";
		
		List params = new ArrayList<>();
		params.add(status);
		
		int row = baseDao.executeUpdate(sql, params);
		
		return row;
	}
	
	/**
	 *批量删除
	 * @param status
	 * @param uid 
	 * @return
	 */
	public int allDeleteByStatus(String status, Integer uid) {
		String sql = "delete from user_order where status=? and uid=?";
		
		List params = new ArrayList<>();
		params.add(status);
		params.add(uid);
		
		int row = baseDao.executeUpdate(sql, params);
		
		return row;
	}
	
	/**单独收货某个订单
	 * 
	 * @param oid
	 * @return
	 */
	public int onePay(String oid) {
		String sql = "update user_order set status=4, end_datetime=now() where oid=?";
		
		List params = new ArrayList<>();
		params.add(oid);
		
		int row = baseDao.executeUpdate(sql, params);
		return row;
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
	 * 调用Dao层，修改订单表记录，返回受影响行数
	 * @param oid
	 * @param aid
	 * @return
	 */
	public int updateOrder(String oid, String aid) {
		String sql = "update user_order set status=2, pay_datetime=now(), aid=? where oid=?";
		
		List params = new ArrayList<>();
		params.add(aid);
		params.add(oid);
		
		int row  = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 查询支出金额
	 * @param oid
	 * @return
	 */
	public Double findMoney(String oid) {
		String sql = "select pay from user_order where oid=?";
		
		List params = new ArrayList<>();
		params.add(oid);
		
		Double p1 = (Double) baseDao.findSingleValue(sql, params);
		return p1;
	}
	
	/**
	 * 给金额表新增纪录
	 * @param uid
	 * @param money
	 * @return
	 */
	public int addRows(Integer uid, Double money) {
		String sql = "insert into user_account(uid,style,money) values(?,1,?)";
		
		List params = new ArrayList<>();
		params.add(uid);
		params.add(money);
		
		int row  = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 显示记录详情
	 * @param oid
	 * @param uid
	 * @return
	 */
	public DetaliOrder detali(String oid, Integer uid) {
		DetaliOrder order = new DetaliOrder();
		//获取地址 aid
		String sql = "select aid from user_order where oid=?";
		List params = new ArrayList<>();
		params.add(oid);
		Integer aid = (Integer) baseDao.findSingleValue(sql, params);
		//查询地址对象
		String sql1 = "select * from user_addr where aid=?";
		List params1 = new ArrayList<>();
		params1.add(aid);
		UserAddr uAddr = (UserAddr) baseDao.queryRow(sql1, params1, UserAddr.class);
		//查询订单对象
		String sql2 = "select * from user_order where oid=?";
		List params2 = new ArrayList<>();
		params2.add(oid);
		User_Order order2 = (User_Order) baseDao.queryRow(sql2, params2, User_Order.class);
		//设置相应的参数
		order.setO_no(order2.getO_no()); //订单号
		order.setPay(order2.getPay());   //订单金额
		order.setTime(order2.getCreate_datetime());  //订单创建时间
		order.setTime1(order2.getPay_datetime());   //订单支付事件
		if (order2.getEnd_datetime()!=null) {
			order.setTime2(order2.getEnd_datetime());     //订单完成时间
		}
		order.setPo(uAddr.getR_province());
		order.setCo(uAddr.getR_city());
		order.setDoo(uAddr.getR_district());
		order.setAo(uAddr.getR_address());
		order.setName(uAddr.getR_name());
		order.setPhone(uAddr.getR_mobile());
		return order;
	}
	
	
	/**
	 * 获得所有字表的集合
	 * @param i
	 * @return
	 */
	public List<User_Item> selectList(int oid) {
		String sql = "select * from user_order_item where oid=?";
		List params = new ArrayList<>();
		params.add(oid);
		List<User_Item> items = baseDao.queryRows(sql, params, User_Item.class);
		return items;
	}
	
	
	/**
	 * 给产品表增加相应的库存
	 * @param num
	 * @param pid
	 * @return
	 */
	public int addKuCun(Integer num, Integer pid) {
		String sql = "update pclass_product set num=num+? where pid=?";
		List params = new ArrayList<>();
		params.add(num);
		params.add(pid);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 获取订单实体类状态码为1的集合
	 * @param status
	 * @param uid 
	 * @return
	 */
	public List<User_Order> findOrderList(String status, Integer uid) {
		String sql = "select * from user_order where status=1 and uid=?";
		
		List params = new ArrayList<>();
		
		params.add(uid);
		
		List<User_Order> uList = baseDao.queryRows(sql, params, User_Order.class);
		
		return uList;
	}
}
