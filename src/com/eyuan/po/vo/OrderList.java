package com.eyuan.po.vo;

/**
 * 用户子订单PO类
 * @author xueyou
 *
 */
public class OrderList {
	
	private Integer pid;      //商品Id
	private String subTitle;  //产品名字
	private Double price;     //产品单价
	private Integer size;     //产品规格
	private Integer num ;     //产品数目
	private String image;     //产品图片
	private Integer oid;      //产品订单ID
	
	
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getOid() {
		return oid;
	}
	public void setOid(Integer oid) {
		this.oid = oid;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
