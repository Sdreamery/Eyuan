package com.eyuan.po.vo;

/**
 * 用户收藏Po类
 * @author xueyou
 *
 */
public class UserCollect {
	private Integer ctid;     //收藏表的主键
	private String subTitle;  //产品名字
	private Double price;     //商品单价
	private String image;     //商品图片地址
	private Integer pid;      //产品id
	
	
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getCtid() {
		return ctid;
	}
	public void setCtid(Integer ctid) {
		this.ctid = ctid;
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
