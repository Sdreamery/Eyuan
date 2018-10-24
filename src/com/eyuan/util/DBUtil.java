package com.eyuan.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 数据库工具类
 * @author Lisa Li
 *
 */
public class DBUtil {

	/**
	 * 得到数据库连接
	 * @return
	 */
	public static Connection getConnection () {
		Connection connection = null;
		
		try {
			// 得到配置文件的输入流
			InputStream inputStream = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
			// 创建配置文件对象
			Properties properties = new Properties();
			// 调用配置文件对象的load方法，将输入流加载进去
			properties.load(inputStream);
			
			// 得到配置文件中的属性值
			String jdbcName = properties.getProperty("jdbcName");
			String dbUrl = properties.getProperty("dbUrl");
			String dbUserName = properties.getProperty("dbUserName");
			String dbPassword = properties.getProperty("dbPassword");
			
			// 加载驱动
			Class.forName(jdbcName);
			
			// 得到数据库连接
			connection = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
	/**
	 * 关闭资源
	 * @param resultSet
	 * @param preparedStatement
	 * @param connection
	 */
	public static void close(ResultSet resultSet, PreparedStatement preparedStatement, Connection connection) {
		// 判断资源是否为空，不为空则关闭
		try {
			if (resultSet != null) {
				resultSet.close();
			}
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public static void main(String[] args) {
		Connection connection = getConnection();
		System.out.println(connection);
	}
	
}
