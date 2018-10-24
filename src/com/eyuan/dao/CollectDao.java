package com.eyuan.dao;

import java.util.ArrayList;
import java.util.List;

import com.eyuan.po.UserColl;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.po.vo.UserCollect;

/**
 * 收藏Dao层
 * @author xueyou
 *
 */
@SuppressWarnings("all")
public class CollectDao {
		
	private BaseDao baseDao = new BaseDao();
	
	/**调用Dao层，查询收藏总数量
	 * 
	 * @param uid
	 * @return
	 */
	public long countNum(Integer uid) {
		String sql = "select count(pid) from user_collect where uid=?";
		
		List params = new ArrayList<>();
		params.add(uid);
		
		long total = (long) baseDao.findSingleValue(sql, params);
		return total;
	}
	
	/**
	 * 查询当前页数显示数据的集合
	 * @param uid
	 * @param currentNum
	 * @param everyNum
	 * @return
	 */
	public List<UserCollect> findNowList(Integer uid, Integer index, Integer everyNum) {
		String sql = "select ctid, subTitle, price, image, u.pid as pid from user_collect u "
				+ "join pclass_product p on u.pid=p.pid "
				+ "where u.uid=? order by u.pid desc limit ?,?";
		
		List params = new ArrayList<>();
		params.add(uid);
		params.add(index);
		params.add(everyNum);
		
		List<UserCollect> userCollects = baseDao.queryRows(sql, params, UserCollect.class);
		return userCollects;
	}
	
	/**
	 * 查询是否存在记录了
	 * @param uid
	 * @param pid
	 * @return
	 */
	public UserColl findColl(Integer uid, String pid) {
		String sql = "select * from user_collect where uid=? and pid=?";
		
		List params = new ArrayList<>();
		params.add(uid);
		params.add(pid);
		
		UserColl uColl = (UserColl) baseDao.queryRow(sql, params, UserColl.class);
		return uColl;
	}
	
	/**
	 * 新增一个收藏记录
	 * @param uid
	 * @param pid
	 * @return
	 */
	public int addCollet(Integer uid, String pid) {
		String sql = "insert into user_collect(uid,pid) values(?,?) ";
		
		List params = new ArrayList<>();
		params.add(uid);
		params.add(pid);
		
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	/**
	 * 删除收藏
	 * @param uid
	 * @param ctid
	 * @return
	 */
	public int deleteCollect(Integer uid, String ctid) {
		String sql = "delete from user_collect where uid=? and ctid=?";
		
		List params = new ArrayList<>();
		params.add(uid);
		params.add(ctid);
		
		int row  = baseDao.executeUpdate(sql, params);
		
		return row;
	}
	
	/**
	 * 查询指定的usercollect对象
	 * @param uid
	 * @param pageNum
	 * @return
	 */
	public ResultInfo<UserCollect> selectCollect(Integer uid, String pageNum) {
		ResultInfo<UserCollect> resultInfo =new ResultInfo<UserCollect>();
		
		String sql = "select ctid, subTitle, price, image, u.pid from user_collect u "
				+ "join pclass_product p on u.pid= p.pid "
				+ "where uid=? order by ctid LIMIT ?,1";
		
		List params = new ArrayList<>();
		params.add(uid);
		params.add((Integer.parseInt(pageNum)*8)-1);
		
		UserCollect userCollect = (UserCollect) baseDao.queryRow(sql, params, UserCollect.class);
		
		if (userCollect!=null) {
			resultInfo.setResult(userCollect);
		}
		
		return resultInfo;
	}
}
