package com.eyuan.po.vo;
/**
 * 返回响应数据的封装类
 * 包括：code 状态码 
 * 		msg  返回的提示信息   result 返回的数据对象
 * @author xueyou
 * @param <T>
 */
public class ResultInfo<T> {
	
	private Integer code;  //状态码。相应成功code=1,响应失败 code=0;
	private String msg; //返回的提示消息
	private T result;  //返回的数据对象，泛型实现多值传递
	
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public T getResult() {
		return result;
	}
	public void setResult(T result) {
		this.result = result;
	}
	
}
