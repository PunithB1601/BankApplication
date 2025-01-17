package com.bank.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connector {
	static String url="jdbc:mariadb://database-1.c7qmwgiq68r6.ap-south-1.rds.amazonaws.com:3306/bank";
	static String user="root";
	static String password="tiger";
	static Connection con=null;
	public static Connection requestConnection() 
	{		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con= DriverManager.getConnection(url, user, password);	
		}
		catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
}
