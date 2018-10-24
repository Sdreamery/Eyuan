package com.eyuan.po;

public class Pclass {
	private Integer cid;
	private Integer parent_id;
	private String cname;
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	@Override
	public String toString() {
		return "Pclass [cid=" + cid + ", parent_id=" + parent_id + ", cname=" + cname + "]";
	}
	
	
}
