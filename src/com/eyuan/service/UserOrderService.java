package com.eyuan.service;

import java.util.ArrayList;
import java.util.List;

import com.eyuan.dao.OrderDao;
import com.eyuan.po.User_Item;
import com.eyuan.po.User_Order;
import com.eyuan.po.vo.CartProduct;
import com.eyuan.po.vo.OrderList;
import com.eyuan.po.vo.OrderNumber;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.util.StringUtil;
import com.sun.org.apache.regexp.internal.recompile;

/**
 * 用户中心，用户订单Service层
 * @author xueyou
 *
 */
public class UserOrderService {
	
	private OrderDao orderDao = new OrderDao();
	
	/**Service层
	 * 返回一个Number对象
	 * @param uid
	 * @return
	 */
	public OrderNumber findNumberByUid(Integer uid) {
		//调用Dao层
		OrderNumber number = orderDao.findNumberByUid(uid);
		
		return number;
	}
	
	/**
	 * 把子订单的信息查询出来
	 * @param uid
	 * @param searchKey 
	 * @return
	 */
	public List<OrderList> findSonListByUID(Integer uid) {
		List<OrderList> list = new ArrayList();
		//调用Dao层  
		list = orderDao.findSonListByUID(uid);
		return list;
	}
	
	/**删除用户指定订单
	 * Service层
	 * 1.调用dao层，先删除从表
	 * 2.根据判断，再删除主表中的数据
	 * 3.最后根据影响的行数，设置响应的resultInfo对象给Servlet层
	 * @param oid
	 * @param status 
	 * @return
	 */
	public ResultInfo userOrderDelete(String oid, String status) {
		ResultInfo resultInfo = new ResultInfo();
		int row2=0;
		if ("1".equals(status)) {  //未支付订单
			//获得所有字表的集合
			List<User_Item> items = orderDao.selectList(Integer.parseInt(oid));
			//遍历
			for(int i=0; i<items.size();i++){
				//给产品表增加相应的库存
				row2 = orderDao.addKuCun(items.get(i).getNum(),items.get(i).getPid());
			}
		}
		//1.调用dao层，先删除从表
		int row = orderDao.deleteFromSon(oid);
		int row1 =0;
		//2.根据判断，再删除主表中的数据
		if (row>0) { //成功
			row1 = orderDao.deleteFromFather(oid);
		}else {
			resultInfo.setCode(0);
			resultInfo.setMsg("啊哦，删除错误！！");
			return resultInfo;
		}
		
		//3.最后根据影响的行数，设置响应的resultInfo对象给Servlet层
		if (row1>0) {  //成功
			resultInfo.setCode(1);
			resultInfo.setMsg("恭喜，删除成功！！");
		}else {
			resultInfo.setCode(0);
			resultInfo.setMsg("啊哦，删除错误！！");
		}
		
		return resultInfo;
	}
	
	/**批量收货
	 * Service层
	 * 1.调用Dao层返回受影响的行数
	 * 2.判断，设置响应的resultInfo对象
	 * 
	 * @param status
	 * @return
	 */
	public ResultInfo updateStatus(String status) {
		ResultInfo resultInfo = new ResultInfo<>();
		//1.调用Dao层返回受影响的行数
		int row =	orderDao.updateStatus(status);
		
		//2.判断，设置响应的resultInfo对象
		if (row>0) {
			resultInfo.setCode(1);
			resultInfo.setMsg("批量收货成功！！");
		}else {
			resultInfo.setCode(0);
			resultInfo.setMsg("操作失败！！");
		}
		
		return resultInfo;
	}
	
	/**批量删除订单
	 * Service层
	 * 1.调用Dao层返回受影响的行数
	 * 2.判断，设置响应的resultInfo对象
	 * @param status
	 * @param uid 
	 * @return
	 */
	public ResultInfo allDeleteByStatus(String status, Integer uid) {
		ResultInfo resultInfo = new ResultInfo<>();
		
		if ("1".equals(status)) {
			//获取订单实体类状态码为1的集合
			List<User_Order> oList = orderDao.findOrderList(status,uid);
			//遍历集合
			for (int i = 0; i < oList.size(); i++) {
				//通过每一个oid去查询此订单下的子订单，返回一个订单子表集合
				List<User_Item> items = orderDao.selectList(oList.get(i).getOid());
				//遍历每个订单子表，给相应的库存增加
				for (int j = 0; j < items.size(); j++) {
					//给每个产品库存增加
					int row  = orderDao.addKuCun(items.get(j).getNum(), items.get(j).getPid());
				}
				
			}
			
		}
		
		
		//1.调用Dao层返回受影响的行数
		int row = orderDao.allDeleteByStatus(status,uid);
		
		//2.判断，设置响应的resultInfo对象
		if (row>0) {
			resultInfo.setCode(1);
		}else {
			resultInfo.setCode(0);
		}
		
		return resultInfo;
	}
	
	/**单独收货某个订单
	 * Service层
	 * 1.调用Dao层返回受影响的行数
	 * 2.判断，设置响应的resultInfo对象
	 * @param oid
	 * @return
	 */
	public ResultInfo onePay(String oid) {
		ResultInfo resultInfo = new ResultInfo();
		//1.调用Dao层返回受影响的行数
		int row  = orderDao.onePay(oid);
		
		//2.判断，设置响应的resultInfo对象
		if (row>0) {
			resultInfo.setCode(1);
		}else{
			resultInfo.setCode(0);
		}
		
		return resultInfo;
	}
	
	/**支付订单
	 * 1.判断参数
	 * 2.调用Dao层，修改订单表记录，返回受影响行数
	 * 3.判断受影响的行数,给支出表新增记录，返回受影响行数
	 * 4.根据影响行数返回code
	 * @param uid 
	 * @param oid
	 * @param aid
	 * @return
	 */
	public int payOrder(Integer uid, String oid, String aid) {
		//1.判断参数
		if (StringUtil.isEmpty(aid)) {
			return 0;
		}
		
		//2.调用Dao层，修改订单表记录，返回受影响行数
		int row  = orderDao.updateOrder(oid,aid);
		
		int row1=0;
		//3.判断受影响的行数,给支出表新增记录，返回受影响行数
		if (row>0) {
			//查询支出金额
			Double money = orderDao.findMoney(oid);
			//给金额表新增纪录
			row1 = orderDao.addRows(uid,money);
		}else{
			return 0;
		}
		
		return row1;
	}
	
	
}
