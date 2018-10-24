package com.eyuan.po;
/**
 * 用户收货地址实体类
 * @author xueyou
 *
 */
@SuppressWarnings("all")
public class UserAddr {
	
	private Integer aid;     //收货地址ID
	private Integer uid;     //所属用户ID
	private String r_name;   //收货姓名
	private String r_phone;  //收货电话号码
	private String r_mobile; //收货手机号码
	private String r_province; //省份
	private String r_city;     //市
	private String r_district;  //区/县
	private String r_address;  //详细地址
	private String r_zip;      //邮编
	
	
	public Integer getAid() {
		return aid;
	}
	public void setAid(Integer aid) {
		this.aid = aid;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getR_phone() {
		return r_phone;
	}
	public void setR_phone(String r_phone) {
		this.r_phone = r_phone;
	}
	public String getR_mobile() {
		return r_mobile;
	}
	public void setR_mobile(String r_mobile) {
		this.r_mobile = r_mobile;
	}
	public String getR_province() {
		return r_province;
	}
	public void setR_province(String r_province) {
		this.r_province = r_province;
	}
	public String getR_city() {
		return r_city;
	}
	public void setR_city(String r_city) {
		this.r_city = r_city;
	}
	public String getR_district() {
		return r_district;
	}
	public void setR_district(String r_district) {
		this.r_district = r_district;
	}
	public String getR_address() {
		return r_address;
	}
	public void setR_address(String r_address) {
		this.r_address = r_address;
	}
	public String getR_zip() {
		return r_zip;
	}
	public void setR_zip(String r_zip) {
		this.r_zip = r_zip;
	}
		
}
