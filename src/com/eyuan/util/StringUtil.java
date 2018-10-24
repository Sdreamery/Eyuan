package com.eyuan.util;


/**
 * 字符串工具类
 * @author Lisa Li
 *
 */
public class StringUtil {

	/**
	 * 判断字符串是否为空
	 * @param str
	 * @return
	 */
	public static boolean isEmpty (String str) {
		if (str == null || "".equals(str)) {
			return true;
		}
		return false;
	}
	
	/**
	 * 判断字符串是否不为空
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty (String str) {
		if (str == null || "".equals(str)) {
			return false;
		}
		return true;
	}
}
