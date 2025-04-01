package com.plick.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String user = "semi2";
	private static final String pwd = "1234";

	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConn() throws SQLException {
		return DriverManager.getConnection(url, user, pwd);
	}
}
