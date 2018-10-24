package com.eyuan.po.vo;

import java.util.Date;

import com.eyuan.po.UserAddr;

/**
 * 订单详情页实体类
 * @author xueyou
 *
 */
public class DetaliOrder {
	
	private String o_no;  //订单号
	private Double pay;  //订单总额
	private Date time;    //订单创建时间
	private Date time1;    //订单付款时间
	private Date time2;    //订单完成时间
	private String po;   //市名字
	private String co;   //区名字
	private String doo;   //县城
	private String ao;     //详细地址
	private String name;   //收货人
	private String phone;  //手机号码
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPo() {
		return po;
	}
	public void setPo(String po) {
		this.po = po;
	}
	public String getCo() {
		return co;
	}
	public void setCo(String co) {
		this.co = co;
	}
	public String getDoo() {
		return doo;
	}
	public void setDoo(String doo) {
		this.doo = doo;
	}
	public String getAo() {
		return ao;
	}
	public void setAo(String ao) {
		this.ao = ao;
	}
	public String getO_no() {
		return o_no;
	}
	public void setO_no(String o_no) {
		this.o_no = o_no;
	}
	
	public Double getPay() {
		return pay;
	}
	public void setPay(Double pay) {
		this.pay = pay;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Date getTime1() {
		return time1;
	}
	public void setTime1(Date time1) {
		this.time1 = time1;
	}
	public Date getTime2() {
		return time2;
	}
	public void setTime2(Date time2) {
		this.time2 = time2;
	}
	
}
