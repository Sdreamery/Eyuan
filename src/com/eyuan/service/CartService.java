package com.eyuan.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import com.eyuan.dao.CartDao;
import com.eyuan.po.Cart;
import com.eyuan.po.User_Order;
import com.eyuan.po.vo.CartProduct;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.util.StringUtil;
import sun.security.util.Length;

public class CartService {

	private CartDao cartDao = new CartDao();
	/**
	 * 查询当前用户的购物车记录数量
	 * @param uid
	 * @return
	 */
	public long cartCount(String uid){
		if (StringUtil.isEmpty(uid)) {
			return 0;
		}
		return cartDao.cartCount(uid) ;
	}
	/**
	 * 购物车添加记录操作
	 * Service层
	 * 1.判断参数
	 * 2.调用Dao层，返回受影响的行数
	 * 3.判断受影响的行数，给ResultInfo对象赋值
	 * 4.返回ResultInfo对象
	 * @param pid
	 * @param num
	 * @param size
	 * @param uid
	 * @param cartPrice 
	 * @return
	 */
	public ResultInfo addCart(String pid, String num, String size, Integer uid, String cartPrice) {
		ResultInfo resultInfo = new ResultInfo<>();
		//1.判断参数
		if (StringUtil.isEmpty(pid)) {
			resultInfo.setCode(0);
			return resultInfo;
		}
		if (StringUtil.isEmpty(num)) {
			resultInfo.setCode(0);
			return resultInfo;
		}
		if (StringUtil.isEmpty(size)) {
			resultInfo.setCode(0);
			return resultInfo;
		}
		if (StringUtil.isEmpty(cartPrice)) {
			resultInfo.setCode(0);
			return resultInfo;
		}
		
		//2.调用Dao层，返回受影响的行数
		int row = cartDao.addCart(pid,num,size,uid,cartPrice);
		
		//3.判断受影响的行数，给ResultInfo对象赋值
		if (row>0) {
			resultInfo.setCode(1);
		}else{
			resultInfo.setCode(0);
		}
		
		return resultInfo;
	}
	
	/**
	 * 购物车提交订单
	 * 1.判断参数，截取参数
	 * 2.调用Dao层,增加用户订单，返回受影响的行数
	 * 3.判断受影响的行数，调用Dao层删除购物车订单
	 * 4.判断响应的情况，设置响应的code
	 * @param pid
	 * @param uid 
	 * @param aid 
	 * @return
	 */
	public ResultInfo orderCart(String cartid, Integer uid, String aid) {
		ResultInfo resultInfo = new ResultInfo<>();
		
		//1.判断参数，截取参数
		if (StringUtil.isEmpty(cartid)) {
			resultInfo.setCode(0);
			return resultInfo;
		}
		String [] cartidArr = cartid.split("-");
		if (cartidArr==null || cartidArr.length<1) {
			resultInfo.setCode(0);
			return resultInfo;
		}
		//定义一个该提交订单的初始价格
		Double totalPrice =0.0;
		for(int i=0; i<cartidArr.length;i++){
			//1.通过cartid查询出该购物车记录对象
			Cart cart = cartDao.findCartByPid(cartidArr[i]);
			if (cart!=null) {
				totalPrice+=cart.getCartprice();
			}
		}
		//编辑订单号
		String orderNum = getOrderNum();
		//2.调用Dao层,增加用户订单，返回受影响的行数
		int row = cartDao.addOrder(uid,aid,totalPrice,orderNum);
		
		//3.判断row
		if (row>0) {  //增加成功
			//查询出用户订单的ID
			Integer oid = cartDao.findOIDByOrderNum(orderNum);
			
			for(int i=0; i<cartidArr.length;i++){
				//查询出订单字表的数量
				Cart cart = cartDao.findCartByPid(cartidArr[i]);
				
				//给订单子表增加记录
				
				int row1 = cartDao.addItemOrder(oid,cart.getPid(),cart.getNum(),cart.getSize());
				
				int row3=0;
				if (row1>0) {
					//获取当前库存的数量
					Integer num3 = cartDao.findKun(cart.getPid());
					//库存操作减少
					row3 = cartDao.deleteKuCun(cart.getPid(),num3-cart.getNum());
				}
				
				
				if (row3>0) {
					//购物车订单删除操作
					int row2 = cartDao.deleteCartByPid(cartidArr[i]);
					if (row2>0) {
						resultInfo.setCode(1);//回传是否成功
						resultInfo.setResult(oid);//回传订单id
					}
				}
			}
		}
		
		return resultInfo;
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
	 * 展示已提交订单
	 * 1.调用Dao层，查询用户订单集合
	 * 2.返回集合对象
	 * @param uid
	 * @param status 
	 * @param searchKey 
	 * @return
	 */
	public List<User_Order> findOrderListByUID(Integer uid, String status, String searchKey) {
		//1.调用Dao层，查询用户订单集合
		List<User_Order> orderList = cartDao.findOrderListByUID(uid,status,searchKey);
		//2.返回集合对象
		return orderList;
	}
	
}
