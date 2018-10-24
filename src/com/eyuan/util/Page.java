package com.eyuan.util;

import java.util.List;

public final class Page<T> {
	private Integer pageNum; // 当前页(前台传的参，若前台未传参则为第一页)
	private Integer pageSize; // 每页要显示的数量（前台传递或后台设置，若前台传参用前台的，未传参用后台设置的）
	private Integer totalCount; // 总数量（查询数据库得到总数量 count函数）
	
	private Integer totalPages; // 总页数（当前总数量/每页要显示的数量（要转浮点类型），向上取整）
	private Integer prePage; // 上一页（当前页-1，如果减1之后小于1，值就是1）
	private Integer nextPage; // 下一页（当前页+1，如果加1之后大于总页数，值就是总页数）
	private Integer startNavPage; // 导航开始数（当前页减5，如果减5之后小于1，则为1，此时结束页为开始数+9，如果开始数+9大于总页数，则结束数为总页数）
	private Integer endNavPage; // 导航结束页（当前页+4，如果加4之后大于总页数，则结束页为为结束数-9，如果结束数-9小于1，则开始数为1）
	
	private List<T> datas; // 查询数据库的列表
	
	/**
	 * 带参构造用于传参
	 * @param pageNum
	 * @param pageSize
	 * @param totalCount
	 */
	public Page(Integer pageNum, Integer pageSize, Integer totalCount) {
		super();
		this.pageNum = pageNum;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		
		// 总页数（当前总数量/每页要显示的数量（要转浮点类型），向上取整）
		totalPages = (int) Math.ceil(totalCount * 1.0 / pageSize);
		
		// 上一页（当前页-1，如果减1之后小于1，值就是1）
		prePage = pageNum - 1 < 1 ? 1 : pageNum - 1;
		
		// 下一页（当前页+1，如果加1之后大于总页数，值就是总页数）
		nextPage = pageNum + 1 > totalPages ? totalPages : pageNum + 1;
		
		// 导航开始数（当前页减5，如果减5之后小于1，则为1，此时结束页为开始数+9，如果开始数+9大于总页数，则结束数为总页数）
		startNavPage = pageNum - 5 ;
		
		// 导航结束页（当前页+4，如果加4之后大于总页数，则结束页为为结束数-9，如果结束数-9小于1，则开始数为1）
		endNavPage = pageNum + 4;
		
		// 当前页减5，如果减5之后小于1，则为1，此时结束页为开始数+9，如果开始数+9大于总页数，则结束数为总页数
		if (startNavPage < 1) {
			startNavPage = 1;
			endNavPage = startNavPage + 9 > totalPages ? totalPages : totalPages + 9;
		}
		
		// 当前页+4，如果加4之后大于总页数，则结束页为为结束数-9，如果结束数-9小于1，则开始数为1
		if (endNavPage > totalPages) {
			endNavPage = totalPages;
			startNavPage = endNavPage - 9 < 1 ? 1 : endNavPage - 9;
		}
		
	}

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public Integer getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(Integer totalPages) {
		this.totalPages = totalPages;
	}

	public Integer getPrePage() {
		return prePage;
	}

	public void setPrePage(Integer prePage) {
		this.prePage = prePage;
	}

	public Integer getNextPage() {
		return nextPage;
	}

	public void setNextPage(Integer nextPage) {
		this.nextPage = nextPage;
	}

	public Integer getStartNavPage() {
		return startNavPage;
	}

	public void setStartNavPage(Integer startNavPage) {
		this.startNavPage = startNavPage;
	}

	public Integer getEndNavPage() {
		return endNavPage;
	}

	public void setEndNavPage(Integer endNavPage) {
		this.endNavPage = endNavPage;
	}

	public List<T> getDatas() {
		return datas;
	}

	public void setDatas(List<T> datas) {
		this.datas = datas;
	}
	
}


