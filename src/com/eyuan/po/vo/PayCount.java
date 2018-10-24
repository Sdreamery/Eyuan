package com.eyuan.po.vo;

import java.util.Date;

/**
 * 充值记录实体类
 * @author xueyou
 *
 */
public class PayCount {
	
	private Double money;   //充值金额
	private Date time;      //充值时间  记得取别名
	private Integer method;  //1 代表微信 2代表支付宝
	private String payNum;    //充值订单号
	
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Integer getMethod() {
		return method;
	}
	public void setMethod(Integer method) {
		this.method = method;
	}
	public String getPayNum() {
		return payNum;
	}
	public void setPayNum(String payNum) {
		this.payNum = payNum;
	}
	
}
