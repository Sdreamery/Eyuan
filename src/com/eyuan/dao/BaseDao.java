package com.eyuan.dao;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

import com.eyuan.util.DBUtil;

/**
 * 公用的基础数据库操作工具类
 * 	1、更新操作 （添加、修改、删除）
 * 	2、查询某一个字段 （常用于查询总数量  count()）
 * 	3、查询对象集合 
 * 	4、查询对象
 * 
 *
 */
public class BaseDao {
	/**
	 * 更新操作
	 * 	添加操作
	 * 	修改操作
	 * 	删除操作
	 * @param sql
	 * @param params
	 * @return
	 */
	public int executeUpdate(String sql,List<Object> params){
		int row = 0;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			//1、得到数据库连接
			connection = DBUtil.getConnection();
			//2、预编译
			preparedStatement = connection.prepareStatement(sql);
			//3、设置参数，判断参数集合是否为空
			if (params != null && params.size()>0) {
				//循环设置参数
				for(int i=0;i<params.size();i++){
					//下标从1开始设置
					preparedStatement.setObject(i+1, params.get(i));
				}
			}
			//4、执行更新，返回受影响的行数
			row = preparedStatement.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//关闭资源
			DBUtil.close(null, preparedStatement, connection);
		}
		return row;
	}
	/**
	 * 查询某一个字段 （常用场景：查询总数量 count()）
	 * @param sql
	 * @param params
	 * @return
	 */
	public Object findSingleValue(String sql,List<Object> params){
		Object object = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			//1、得到数据库连接
			connection = DBUtil.getConnection();
			//2、预编译
			preparedStatement = connection.prepareStatement(sql);
			//3、设置参数，判断参数集合是否为空
			if (params!=null&&params.size()>0) {
				//循环设置参数
				for(int i=0;i<params.size();i++){
					//下标从1开始设置
					preparedStatement.setObject(i+1, params.get(i));
				}
			}
			//4、执行查询，返回结果集
			resultSet = preparedStatement.executeQuery();
			//5、判断结果集，并得到查询到的字段
			if (resultSet.next()) {
				object = resultSet.getObject(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet, preparedStatement, connection);
		}
		
		
		return object;
	}
	/**
	 * 查询对象集合
	 * @param sql
	 * @param params
	 * @param cls
	 * @return
	 */
	@SuppressWarnings({"rawtypes","unchecked"})
	public List queryRows(String sql,List<Object> params,Class cls){
		List list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			//1、得到数据库连接
			connection = DBUtil.getConnection();
			//2、预编译
			preparedStatement = connection.prepareStatement(sql);
			//3、设置参数，判断参数集合是否为空
			if (params!=null&&params.size()>0) {
				//循环设置参数
				for(int i=0;i<params.size();i++){
					//下标从1开始设置
					preparedStatement.setObject(i+1, params.get(i));
				}
			}
			//4、执行查询，返回结果集
			resultSet = preparedStatement.executeQuery();
			//5、得到resultSet结果集的元数据，能够得到数据库查询到的所有字段以及查询到的字段数量
			ResultSetMetaData metaData = resultSet.getMetaData();
			//6、得到查询到的字段数量
			int columnCount = metaData.getColumnCount();
			//判断并分析结果集
			while (resultSet.next()) {
				//创建对象
				Object object = cls.newInstance();
				//循环得到数据库查询到的字段名
				for(int i=1;i<=columnCount;i++){
					//得到所查询飚的字段名
					String columnName=metaData.getColumnLabel(i);
					//通过反射得到filed对象
					Field field = cls.getDeclaredField(columnName);
					//拼接set方法
					String methodName = "set"+columnName.substring(0, 1).toUpperCase()+columnName.substring(1);
					//通过反射得到method方法
					Method method = cls.getDeclaredMethod(methodName, field.getType());
					//调用方法
					method.invoke(object, resultSet.getObject(columnName));
				}
				//将对象添加到集合中
				list.add(object);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			DBUtil.close(resultSet, preparedStatement, connection);
		}
		return list;
	}
	/**
	 * 查询对象
	 * @param sql
	 * @param params
	 * @param cls
	 * @return
	 */
	public Object queryRow(String sql,List<Object> params,Class cls){
		Object object = null;
		List list = queryRows(sql, params, cls);
		if (list!=null && list.size()>0) {
			object = list.get(0);
		}
		return object;
	}
}
