package com.eyuan.po.vo;

/**
 * 用户订单数量，类
 * @author xueyou
 *
 */
public class OrderNumber {
	
	private Integer totalNum;  //订单总数量
	private Integer num1;      //订单已取消的数量  0
	private Integer num2;      //未付款的订单数量  1
	private Integer num3;      //已付款的订单数量   2
	private Integer num4;      //已发货的订单数量   3
	private Integer num5;      //交易成功的订单数量  4
	private Integer num6;      //退货退款的订单数量  5
	
	
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	public Integer getNum1() {
		return num1;
	}
	public void setNum1(Integer num1) {
		this.num1 = num1;
	}
	public Integer getNum2() {
		return num2;
	}
	public void setNum2(Integer num2) {
		this.num2 = num2;
	}
	public Integer getNum3() {
		return num3;
	}
	public void setNum3(Integer num3) {
		this.num3 = num3;
	}
	public Integer getNum4() {
		return num4;
	}
	public void setNum4(Integer num4) {
		this.num4 = num4;
	}
	public Integer getNum5() {
		return num5;
	}
	public void setNum5(Integer num5) {
		this.num5 = num5;
	}
	public Integer getNum6() {
		return num6;
	}
	public void setNum6(Integer num6) {
		this.num6 = num6;
	}
	
}
