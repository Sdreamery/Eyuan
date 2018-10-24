package com.eyuan.po;

public class Product {
	private Integer pid;
	private Integer cid;
	private String pname;
	private String subTitle;
	private String detail;
	private String image;
	private Double price;
	private long num;
	
	
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "Product [pid=" + pid + ", cid=" + cid + ", pname=" + pname + ", subTitle=" + subTitle + ", detail="
				+ detail + ", image=" + image + ", price=" + price + ", num=" + num + ", getPid()=" + getPid()
				+ ", getCid()=" + getCid() + ", getPname()=" + getPname() + ", getSubTitle()=" + getSubTitle()
				+ ", getDetail()=" + getDetail() + ", getImage()=" + getImage() + ", getPrice()=" + getPrice()
				+ ", getNum()=" + getNum() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	
	
}
