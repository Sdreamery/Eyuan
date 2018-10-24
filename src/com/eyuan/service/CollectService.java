package com.eyuan.service;

import java.util.List;

import com.eyuan.dao.CollectDao;
import com.eyuan.po.UserColl;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.po.vo.UserCollect;
import com.eyuan.util.Page;
import com.eyuan.util.StringUtil;

/**
 * 收藏Service层
 * @author xueyou
 *
 */
public class CollectService {
	
	private CollectDao collectDao = new CollectDao();
	
	
	/**收藏分页列表
	 * 1.判断参数
	 * 2.调用Dao层，查询收藏总数量
	 * 3.调用Dao层，查询当前页数显示数据的集合
	 * 4.设置ResultInfo对象，返回给Servlet层
	 * @param currentPage
	 * @param everyPage
	 * @param uid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ResultInfo<Page<UserCollect>> collectList(String currentPage, String everyPage, Integer uid) {
		ResultInfo resultInfo = new ResultInfo<>();
		
		Integer currentNum = 1;
		Integer everyNum = 8;
		
		//1.判断参数
		if (!StringUtil.isEmpty(currentPage)) {
			currentNum = Integer.parseInt(currentPage);
		}
		if (!StringUtil.isEmpty(everyPage)) {
			everyNum = Integer.parseInt(everyPage);
		}
		
		//2.调用Dao层，查询收藏总数量
		long total = collectDao.countNum(uid);
		int totalNum = (int) total;
		
		//得到起始的角标
		int index = (currentNum-1)*everyNum;
		
		//3.调用Dao层，查询当前页数显示数据的集合
		List<UserCollect> userCollects = collectDao.findNowList(uid,index,everyNum);
		
		//4.设置ResultInfo对象，返回给Servlet层
		Page page = new Page(currentNum, everyNum, totalNum);
		page.setDatas(userCollects);
		
		resultInfo.setResult(page);
		
		return resultInfo;
	}

	/**增加收藏
	 * 1.调用Dao层，查询是否存在记录了
	 * 2.判断是否存在对象
	 * 3.新增一个收藏记录
	 * 4.返货code
	 * @param uid
	 * @param pid
	 * @return
	 */
	public Integer addCollect(Integer uid, String pid) {
		//1.调用Dao层，查询是否存在记录了
		UserColl userColl  = collectDao.findColl(uid,pid);
		
		//2.判断是否存在对象
		if (userColl!=null) {
			return 0;
		}
		
		//3.新增一个收藏记录
		int row = collectDao.addCollet(uid,pid);
		
		return row;
	}
}
