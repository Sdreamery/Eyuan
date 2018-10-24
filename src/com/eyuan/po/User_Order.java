package com.eyuan.po;

import java.util.Date;

/**
 * 用户提交订单实体类
 * @author xueyou
 *
 */
public class User_Order {
	
	private Integer oid;  //订单ID
	private Integer uid;  //所属用户ID
	private String  o_no;  //订单号
	private Double pay;    //支付金额
	private Integer status;  //订单状态：0=已取消，1=未付款，2=已付款，3=已发货，4=交易成功，5=交易关闭
	private Date create_datetime;  //订单创建时间（用于未付款订单的时间）
	private Date pay_datetime;     //订单支付时间
	private Date send_datetime;	   //发货时间
	private Date end_datetime;     //交易完成时间
	private Date close_datetime;   //订单关闭时间
	private Integer aid;           //该订单的收货地址
	
	
	
	public Integer getAid() {
		return aid;
	}
	public void setAid(Integer aid) {
		this.aid = aid;
	}
	public Date getClose_datetime() {
		return close_datetime;
	}
	public void setClose_datetime(Date close_datetime) {
		this.close_datetime = close_datetime;
	}
	public Integer getOid() {
		return oid;
	}
	public void setOid(Integer oid) {
		this.oid = oid;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
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
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getCreate_datetime() {
		return create_datetime;
	}
	public void setCreate_datetime(Date create_datetime) {
		this.create_datetime = create_datetime;
	}
	public Date getPay_datetime() {
		return pay_datetime;
	}
	public void setPay_datetime(Date pay_datetime) {
		this.pay_datetime = pay_datetime;
	}
	public Date getSend_datetime() {
		return send_datetime;
	}
	public void setSend_datetime(Date send_datetime) {
		this.send_datetime = send_datetime;
	}
	public Date getEnd_datetime() {
		return end_datetime;
	}
	public void setEnd_datetime(Date end_datetime) {
		this.end_datetime = end_datetime;
	}
	
	
}
