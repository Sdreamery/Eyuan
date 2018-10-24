package com.eyuan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eyuan.po.User;
import com.eyuan.po.UserInfoPo;
import com.eyuan.util.DBUtil;


//	Dao层：（数据库操作层：增删改查）
//	通过用户名查询用户对象
public class UserDao {
	
	BaseDao baseDao = new BaseDao();
	
	public UserInfoPo findUserByUname(String nick){
		
		String sql = "select * from user where nick = ?";
		
		List<Object> params = new ArrayList<Object>();
		params.add(nick);
		
		UserInfoPo user = (UserInfoPo) baseDao.queryRow(sql, params, UserInfoPo.class);
		return user;
/*		User user = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
//	1、得到数据库连接
		try {
			connection = DBUtil.getConnection();
//	2、写sql语句
			String sql = "select * from user where uname = ?";
//	3、预编译
			preparedStatement = connection.prepareStatement(sql);
//	4、设置参数
			preparedStatement.setString(1, uname);
//	5、执行查询，返回结果集
			resultSet = preparedStatement.executeQuery();
//	6、判断并分析结果集
			if(resultSet.next()){
				user =  new User();
				user.setEmail(resultSet.getString("email"));
				user.setPhone(resultSet.getString("phone"));
				user.setUid(resultSet.getInt("uid"));
				user.setUname(resultSet.getString("uname"));
				user.setUpwd(resultSet.getString("upwd"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
//	7、关闭资源
		DBUtil.close(resultSet, preparedStatement, connection);
//	8、返回user对象
		return user;*/
		
	}


//	通过手机号查询用户对象
	public User findUserByPhone(String phone) {
		String sql = "select * from user where phone = ?";
		
		List<Object> params = new ArrayList<Object>();
		params.add(phone);
		
		User user = (User) baseDao.queryRow(sql, params, User.class);
		return user;
	}

//通过邮箱查询用户对象
	public User findUserByEmail(String email) {
		String sql = "select * from user where email = ?";
		
		List<Object> params = new ArrayList<Object>();
		params.add(email);
		
		User user = (User) baseDao.queryRow(sql, params, User.class);
		return user;
	}

//添加用户	
	public int addUser(String nick,String upwd,String phone,String email){
		String sql = "insert into user (nick,upwd,email,phone) values (?,?,?,?)";
		List<Object> params = new ArrayList<Object>();
		params.add(nick);
		params.add(upwd);
		params.add(phone);
		params.add(email);
		int row = baseDao.executeUpdate(sql, params);
		return row;
	}
	
	
}
