package com.eyuan.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.tomcat.util.codec.binary.Base64;

/**
 * 字符串加密
 * @author Lisa Li
 *
 */
public class MD5Util {

	public static String encode(String str) {
		String string  = "";
		
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("md5");
			byte[] bytes = messageDigest.digest(str.getBytes());
			string = Base64.encodeBase64String(bytes);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return string;
	}
}
