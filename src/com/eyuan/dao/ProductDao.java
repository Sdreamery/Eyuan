package com.eyuan.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.print.attribute.HashAttributeSet;

import com.eyuan.po.Pclass;
import com.eyuan.po.Product;
import com.eyuan.util.StringUtil;

public class ProductDao {
	private BaseDao baseDao = new BaseDao();

	/**
	 * 通过商品id查询单个商品对象
	 * @param userId
	 * @return
	 */
	public Product findProductByUserId(String pidStr){
		String sql = "select * from pclass_product where pId=?";
		List<Object> params = new ArrayList<>();
		params.add(pidStr);
		Product product = (Product) baseDao.queryRow(sql, params, Product.class);
		return product;
	}
	/**
	 * 查询所有的商品集合
	 * @return
	 */
	public List<Product> findAllProducts() {
		String sql = "select * from pclass_product";
		List<Product> products = baseDao.queryRows(sql, null, Product.class);
		return products;
	}
	/**
	 * 查询所有的商品类别集合
	 * @return
	 */
	public Map<Pclass, List<Pclass>> listPclass() {
		Map<Pclass, List<Pclass>> pclasses = new HashMap<>();
		//1、查询所有的父类id：parent_id为0的类别，即根基类
		List<Pclass> parent_pclass = new ProductDao().listPclassById(0);
		//2、遍历商品父类集合
		for (Iterator iterator = parent_pclass.iterator(); iterator.hasNext();) {
			Pclass pclass = (Pclass) iterator.next();
			//3、查询属于该父类的所有商品类
			List<Pclass> subClasses = new ProductDao().listPclassById(pclass.getCid());
			pclasses.put(pclass, subClasses);
		}
		return pclasses;
	}
	/**
	 * 通过商品父类id查询子类对象集合
	 * @param parent_id
	 * @return
	 */
	public List<Pclass> listPclassById(Integer parent_id) {
		String sql = "select * from pclass where parent_id = ?";
		List<Object> params = new ArrayList<>();
		params.add(parent_id);
		List<Pclass> pclasses = baseDao.queryRows(sql, params, Pclass.class);
		return pclasses;
	}
	/**
	 * 通过商品父类id查询所属商品集合
	 * @param cid
	 * @return
	 */
	public List<Product> listByParentId(String cid) {
		String sql = "select pid,p.cid cid,pname,subTitle,detail,image,price,num from pclass_product p LEFT JOIN pclass c on p.cid = c.cid where parent_id = ?";
		List<Object> params = new ArrayList<>();
		params.add(cid);
		List<Product> products = baseDao.queryRows(sql, params, Product.class);
		return products;
	}
	/**
	 * 查询商品总数量
	 * @param parentid
	 * @param cid
	 * @param sort
	 * @return
	 */
	public long findProductCount(String parentid, String cid, String keyWord) {
		
		String sql = "";
		List<Object> params = new ArrayList<Object>();
		// 判断商品父类是否为空
		if (StringUtil.isNotEmpty(parentid)) {
			
			// 拼接sql语句并设置对应的参数
			sql = "SELECT COUNT(1) FROM pclass_product p inner join pclass c on p.cid=c.cid where parent_id =  ?";
			params.add(parentid);
		}
		// 判断商品子类id是否为空
		else if (StringUtil.isNotEmpty(cid)) {
			// 拼接sql语句并设置对应的参数
			sql = " SELECT COUNT(1) FROM pclass_product where cid = ? ";
			params.add(cid);
		} 
		// 判断查询关键字是否为空
		else if (StringUtil.isNotEmpty(keyWord)) {
			// 拼接sql语句并设置对应的参数
			sql = "select count(1) from pclass_product p JOIN pclass c  ON p.cid=c.cid  WHERE p.pname like concat('%',?,'%') OR p.subTitle like concat('%',?,'%') OR p.detail like concat('%',?,'%') OR c.cname like concat('%',?,'%')";
			params.add(keyWord);
			params.add(keyWord);
			params.add(keyWord);
			params.add(keyWord);
		}
		else {//如果都为空，查询所有商品
			sql = " SELECT COUNT(1) FROM pclass_product ";
		}
		long count = (long) baseDao.findSingleValue(sql, params);
		return count;
	}
	/**
	 * 查询分页商品
	 * @param index
	 * @param pageSize
	 * @param parentid
	 * @param cid
	 * @param sort
	 * @return
	 */
	public List<Product> findNoteListByPage(Integer index, Integer pageSize, String parentid, String cid, String sort,String keyWord) {
		String sql = "";
		List<Object> params = new ArrayList<Object>();
		// ===========搜索条件==============
		// 判断商品父类是否为空
		if (StringUtil.isNotEmpty(parentid)) {
			
			// 拼接sql语句并设置对应的参数
			sql = "SELECT pid,p.cid cid,pname,subTitle,detail,image,price,num FROM pclass_product p inner join pclass c on p.cid=c.cid where parent_id =  ? ";
			params.add(parentid);
		}
		// 判断商品子类id是否为空
		else if (StringUtil.isNotEmpty(cid)) {
			// 拼接sql语句并设置对应的参数
			sql = " SELECT * FROM pclass_product where cid = ? ";
			params.add(cid);
		} 
		// 判断查询关键字是否为空
		else if (StringUtil.isNotEmpty(keyWord)) {
			// 拼接sql语句并设置对应的参数
			sql = "select pid,p.cid cid,pname,subTitle,detail,image,price,num from pclass_product p JOIN pclass c  ON p.cid=c.cid  WHERE p.pname like concat('%',?,'%') OR p.subTitle like concat('%',?,'%') OR p.detail like concat('%',?,'%') OR c.cname like concat('%',?,'%')";
			params.add(keyWord);
			params.add(keyWord);
			params.add(keyWord);
			params.add(keyWord);
		}
		else {//如果都为空，查询所有商品
			sql = " SELECT * FROM pclass_product ";
		}
		
		if ("price".equals(sort)) {//判断排序条件
			sql += " order by price desc ";
		} else if ("sales".equals(sort)) {
			sql += " order by num ";
		} else {
			
		}
		// ===========搜索条件==============
		
		
		// 排序及分页sql（条件语句要写在排序和分页之前）
		sql += " limit ?,?";
		params.add(index);
		params.add(pageSize);
		List<Product> list = baseDao.queryRows(sql, params, Product.class);
		return list;
	}
	
/////////////////////////////////////// XSS ///////////////////////////////////////////
	/**
	 * 查询商品总数量
	 * @param cid
	 * @return
	 */
	public long findProductCount(String cid, String detail) {
		
		String sql = "select count(1) from pclass_product ";
		List<Object> params = new ArrayList<>();
		
		// ===================搜索条件====================
		// 判断查询类型是否为空
		if (StringUtil.isNotEmpty(cid)) {
			// 拼接sql语句并设置对应的参数
			sql += " where cid = ? ";
			params.add(cid);
		}
		
		// 判断搜索信息是否为空
		if (StringUtil.isNotEmpty(detail)) {
			// 拼接sql语句并设置对应的参数
			sql += " where pname like concat('%',?,'%') ";
			params.add(detail);
		}
		// ===================搜索条件=====================
		
		long count = (long) baseDao.findSingleValue(sql, params);

		return count;
	}
	
	
	/**
	 * 分页查询商品列表
	 * @param pageSize
	 * @param index
	 * @param pname
	 * @param cid
	 * @param detail 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Product> listProductsByPage(Integer pageSize, Integer index,  String cid, String detail, String pid, String price, String num) {
		String sql = "select * from pclass_product ";
		
		List<Object> params = new ArrayList<Object>();
		
		// ===================搜索条件====================
		// 判断查询类型是否为空
		if (StringUtil.isNotEmpty(cid)) {
			// 拼接sql语句并设置对应的参数
			sql += " where cid = ? ";
			params.add(cid);
		}
		
		// 判断搜索信息是否为空
		if (StringUtil.isNotEmpty(detail)) {
			// 拼接sql语句并设置对应的参数
			sql += "where pname like concat('%',?,'%') OR subTitle like concat('%',?,'%') OR detail like concat('%',?,'%')";
			params.add(detail);
			params.add(detail);
			params.add(detail);
		}
		// ===================搜索条件=====================
		
		
		// ==================排序及分页sql（条件语句要写在排序和分页之前）=================
		
		///////////////////// 排序 ////////////////////
		// 综合排序（按照商品ID升序）
		if (StringUtil.isNotEmpty(pid)) {
			sql += " order by pid ";
		}
		
		// 价格排序 （按照价格降序）
		if (StringUtil.isNotEmpty(price)) {
			sql += " order by price desc ";
		}
		
		// 销量排序（按照销量降序）
		if (StringUtil.isNotEmpty(num)) {
			sql += " order by (1000-num) desc ";
		}
		
		
		///////////////////// 分页 ////////////////////
		sql += " limit ?,? "; 
		params.add(index);
		params.add(pageSize);
		List<Product> list = baseDao.queryRows(sql, params, Product.class);
		
		return list;
	}
	
	
}
