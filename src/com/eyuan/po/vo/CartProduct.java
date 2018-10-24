package com.eyuan.po.vo;

/**
 * 购物车清单实体类
 * @author xueyou
 *
 */
public class CartProduct {
	
	private Integer cartid;   //购物车id
	private Integer pid;  //产品id
	private String pname;    //产品名称
	private String image;    //产品主图地址
	private String subTitle;  //产品副标题
	private Integer num;      //库存数量
	private Integer size;     //产品的规格
	private Double  cartprice;  //该购物车记录商品的结算价格
	private Integer checked;   //是否勾选，0=未勾选 1=已勾选
	
	
	public Integer getCartid() {
		return cartid;
	}
	public void setCartid(Integer cartid) {
		this.cartid = cartid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	public Double getCartprice() {
		return cartprice;
	}
	public void setCartprice(Double cartprice) {
		this.cartprice = cartprice;
	}
	public Integer getChecked() {
		return checked;
	}
	public void setChecked(Integer checked) {
		this.checked = checked;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	@Override
	public String toString() {
		return "CartProduct [cartid=" + cartid + ", pid=" + pid + ", pname=" + pname + ", image=" + image
				+ ", subTitle=" + subTitle + ", num=" + num + ", size=" + size + ", cartprice=" + cartprice
				+ ", checked=" + checked + "]";
	}

	
}
