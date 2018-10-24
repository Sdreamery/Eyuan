package com.eyuan.service;

import java.util.List;
import java.util.Map;

import com.eyuan.dao.ProductDao;
import com.eyuan.po.Pclass;
import com.eyuan.po.Product;
import com.eyuan.po.vo.ResultInfo;
import com.eyuan.util.Page;
import com.eyuan.util.StringUtil;

/**
 * 
 * 首页服务层
 *
 */
public class IndexService {
	
	private ProductDao productDao = new ProductDao();
	/**
	 * 查询数据库所有的商品集合
	 * @return
	 */
	public List<Product> listProducts() {
		List<Product> products = productDao.findAllProducts();
		return products;
	}
	/**
	 * 查询数据库所有商品类别对象集合
	 * @return
	 */
	public Map<Pclass, List<Pclass>> listPclass() {
		Map<Pclass, List<Pclass>> pclasses = productDao.listPclass();
		return pclasses;
	}
	/**
	 * 通过商品类别id查询所有商品集合
	 * @param cid
	 * @return
	 */
	public List<Product> listByParentId(String cid) {
		List<Product> products = productDao.listByParentId(cid);
		if (products.size()>10) {
			products = products.subList(0, 10);
		}
		return products;
	}
	/**
	 * 分页查询商品列表
	 * 	1、判断参数（如果参数为空，使用默认值）
		2、调用Dao层，查询商品总数量
		3、判断总数量是否大于0
		3、得到page对象
		4、调用Dao层，分页查询商品列表
		5、将商品列表设置到page对象中
		6、将page对象设置到resultInfo对象中
	 * @param pageNumStr
	 * @param pageSizeStr
	 * @param parentid
	 * @param cid
	 * @param sort
	 * @return
	 */
	public ResultInfo<Page<Product>> findProductListByPage(String pageNumStr, String pageSizeStr, String parentid,
			String cid, String sort,String keyWord ) {
		ResultInfo<Page<Product>> resultInfo = new ResultInfo<>();
		
		Integer pageNum = 1; 
		Integer pageSize = 10;
		// 1、判断参数（如果参数为空，使用默认值）
		if (StringUtil.isNotEmpty(pageNumStr)) {
			pageNum = Integer.parseInt(pageNumStr);
		}
		if (StringUtil.isNotEmpty(pageSizeStr)) {
			pageSize = Integer.parseInt(pageSizeStr);
		}
		
		// 2、调用Dao层，查询商品总数量
		long count = productDao.findProductCount( parentid, cid, keyWord);
		
		// 3、判断总数量是否大于0
		if (count < 1) {
			resultInfo.setCode(0);
			resultInfo.setMsg("暂未查询到商品数据！");
			return resultInfo;
		}
		int totalCount = (int) count;
		
		// 4、得到page对象
		Page<Product> page = new Page<>(pageNum, pageSize, totalCount);

		// 5、分页查询云记列表
		// 得到开始查询的下标
		Integer index = (pageNum -1) * pageSize;
		List<Product> list = productDao.findNoteListByPage( index, pageSize, parentid, cid, sort,keyWord);
		
		// 6、将集合设置到page对象中
		page.setDatas(list);
		
		// 7、将page对象设置到resultInfo中
		resultInfo.setResult(page);
		resultInfo.setCode(1);
		
		return resultInfo;
	}

	
/////////////////////////////////////// XSS ///////////////////////////////////////////
	/**
	 * 分页查询商品列表
	 *  1、判断参数（如果参数为空，使用默认值）
		2、调用Dao层，查询商品总数量
		3、判断总数量是否大于0
		4、得到page对象
		5、分页查询云记列表
		6、将商品列表设置到page对象中
		7、将page对象设置到resultInfo对象中
	 * @param pageNumStr
	 * @param pageSizeStr
	 * @param cid
	 * @param pname 
	 * @param detail 
	 * @return
	 */
	public ResultInfo<Page<Product>> listProductsByPage(String pageNumStr, String pageSizeStr, String cid, String detail, String pid, String price, String num) {
		ResultInfo<Page<Product>> resultInfo = new ResultInfo<>();
		
		// 设置默认值
		Integer pageNum = 1;
		Integer pageSize = 10;
		
		// 1、判断参数（如果参数为空，使用默认值）
		if (StringUtil.isNotEmpty(pageNumStr)) {
			pageNum = Integer.parseInt(pageNumStr);
		}
		if (StringUtil.isNotEmpty(pageSizeStr)) {
			pageSize = Integer.parseInt(pageSizeStr);
		}
		
		/*2、调用Dao层，查询商品总数量*/
		long count = productDao.findProductCount( cid, detail);
		
		// 3、判断总数量是否大于0
		if (count < 1) {
			resultInfo.setCode(0);
			resultInfo.setMsg("该类型暂未查询到商品！");
			return resultInfo;
		}
		
		// long类型转成Integer类型
		int totalCount = (int) count;
		// 4、得到page对象
		Page<Product> page = new Page<>(pageNum, pageSize, totalCount);
		
		// 5、分页查询云记列表
		// 得到开始查询的下标
		Integer index = (pageNum -1) * pageSize;
		
		
		/*调用Dao层分页查询商品列表*/
		List<Product> list = productDao.listProductsByPage(pageSize, index, cid, detail, pid, price, num);
		
		
		// 6、将集合设置到page对象中
		page.setDatas(list);
		
		// 7、将page对象设置到resultInfo中
		resultInfo.setResult(page);
		resultInfo.setCode(1);
		
		return resultInfo;
	}
	
	
}
