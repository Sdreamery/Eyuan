package com.eyuan.util;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
import com.alibaba.fastjson.JSON;

public class JsonUtil {
	
	/**
	 * 将对象转换成JSON字符串，响应给ajax的回调函数
	 * @param object
	 * @param response
	 * @throws IOException
	 */
	public static void toJson(Object object, HttpServletResponse response) throws IOException{
		
		//设置响应的MIME类型
		response.setContentType("application/json;charset=utf-8");
		
		//将resultInfo对象转换成Json字符串，响应给ajax的回调函数
		PrintWriter pw = response.getWriter();
		
		//将resultInfo对象转换成JSON字符串
		String json = JSON.toJSONString(object);
		pw.write(json);
		pw.close();
	}
}
