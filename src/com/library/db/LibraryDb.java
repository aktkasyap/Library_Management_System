package com.library.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class LibraryDb implements DbData{
	private static Connection con=null;
	private LibraryDb() {

	}
	static {
		try {
			Class.forName(driver);
			con=DriverManager.getConnection(url,user,pass);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	public static Connection getConnection() {
		return con;
	}
	public static void main(String[] args) {
		System.out.println(getConnection());
	}
}
