package com.eyuan.po;

/**
 * 用户购物车实体类
 * @author xueyou
 *
 */
public class Cart {
	
	private Integer cartid;   //购物车记录ID
	private Integer uid;      //用户ID
	private Integer pid;      //商品ID
	private Integer num;	  //商品数量
	private Integer checked;  //购物车记录是否被勾选，0==未勾选，1==勾选
	private Double cartprice;    //该购物车记录商品的结算价格
	private Integer size;    //产品的规格
	public Integer getCartid() {
		return cartid;
	}
	public void setCartid(Integer cartid) {
		this.cartid = cartid;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getChecked() {
		return checked;
	}
	public void setChecked(Integer checked) {
		this.checked = checked;
	}
	public Double getCartprice() {
		return cartprice;
	}
	public void setCartprice(Double cartprice) {
		this.cartprice = cartprice;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	
}
