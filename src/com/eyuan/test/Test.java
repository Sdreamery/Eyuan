package com.eyuan.test;

import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.eyuan.dao.CartDao;
import com.eyuan.dao.ProductDao;
import com.eyuan.po.Pclass;
import com.eyuan.po.vo.CartProduct;

public class Test {

	@org.junit.Test
	public void test() {
		fail("Not yet implemented");
	}
	
/*	@org.junit.Test
	public void test01() {
		List<CartProduct> list = new CartDao().showCartList(1);
		//System.out.println(list);
		System.out.println(list.size());
	}
	
	@org.junit.Test
	public void test02() {
		Map<Pclass, List<Pclass>> pclasses = new ProductDao().listPclass();
		System.out.println(pclasses);
	}*/
	@org.junit.Test
	public void test03() {
		Map<Pclass, List<Pclass>> pclasses = new ProductDao().listPclass();
		System.out.println(pclasses);
		int[] aaa = {2,3,1,44,22,6};
		Arrays.sort(aaa);
		int bbb = Arrays.binarySearch(aaa, 2);
		System.out.println(bbb);
	}
}
