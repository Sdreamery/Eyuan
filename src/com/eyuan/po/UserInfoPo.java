package com.eyuan.po;

import java.util.Date;

public class UserInfoPo {
	private Integer uid; //用户ID
	private String nick;//用户名
	private String uname;//用户真实姓名
	private String upwd;//用户密码
	private String birth;//出生日期
	private String sex;//用户性别 男 1 女 0  秘密 -1
	private String email;//邮箱
	private String phone;//手机号码
	private String head;//头像
	private String year;
	private String month;
	private String day;
	

	
	
	public Integer getUid() {
		return uid;
	}




	public void setUid(Integer uid) {
		this.uid = uid;
	}




	public String getNick() {
		return nick;
	}




	public void setNick(String nick) {
		this.nick = nick;
	}




	public String getUname() {
		return uname;
	}




	public void setUname(String uname) {
		this.uname = uname;
	}




	public String getUpwd() {
		return upwd;
	}




	public void setUpwd(String upwd) {
		this.upwd = upwd;

	}




	public String getBirth() {
		return birth;
	}




	public void setBirth(String birth) {
		this.birth = birth;
		if(birth == null){
		birth="1970-01-01";
		}
		this.year=birth.split("-")[0];
		this.month=birth.split("-")[1];
		this.day=birth.split("-")[2];
	}




	public String getSex() {
		return sex;
	}




	public void setSex(String sex2) {
		this.sex = sex2;
	}




	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}




	public String getPhone() {
		return phone;
	}




	public void setPhone(String phone) {
		this.phone = phone;
	}




	public String getHead() {
		return head;
	}




	public void setHead(String head) {
		this.head = head;
	}




	public String getYear() {
		return year;
	}




	public void setYear(String year) {
		this.year = year;
	}




	public String getMonth() {
		return month;
	}




	public void setMonth(String month) {
		this.month = month;
	}




	public String getDay() {
		return day;
	}




	public void setDay(String day) {
		this.day = day;
	}




	@Override
	public String toString() {
		return "UserInfoPo [uid=" + uid + ", nick=" + nick + ", uname=" + uname + ", upwd=" + upwd + ", birth=" + birth
				+ ", sex=" + sex + ", email=" + email + ", phone=" + phone + ", head=" + head + ", year=" + year
				+ ", month=" + month + ", day=" + day + "]";
	}
	


	
	
		
	
	
}
