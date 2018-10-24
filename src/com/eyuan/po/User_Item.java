package com.eyuan.po;

/**
 * 用户订单子表实体类
 * @author xueyou
 *
 */
public class User_Item {
	
	private Integer o_itemid;  //订单子表ID
	private Integer oid;       //订单所属ID
	private Integer pid;       //商品id
	private Integer num;       //商品数量
	private Integer size;      //订单规格  1代表规格一  2代表规格二  3代表规格三 
	
	public Integer getO_itemid() {
		return o_itemid;
	}
	public void setO_itemid(Integer o_itemid) {
		this.o_itemid = o_itemid;
	}
	public Integer getOid() {
		return oid;
	}
	public void setOid(Integer oid) {
		this.oid = oid;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getSize() {
		return size;
	}
	public void setSize(Integer size) {
		this.size = size;
	}
	
}
