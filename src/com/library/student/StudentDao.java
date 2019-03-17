package com.library.student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.library.db.LibraryDb;
import com.library.utilities.CurrDate;
import com.library.utilities.Password;
import com.library.utilities.Utility;

public class StudentDao {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	@SuppressWarnings("finally")
	public boolean checkMno(String mno) {
		boolean flag = false;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "Select mobile from StudentDb where mobile=" + mno;
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			rs = null;
			ps = null;
			con = null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public boolean checkSid(int sid) {
		boolean flag = false;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "Select * from StudentDb where sid=" + sid;
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			rs = null;
			ps = null;
			con = null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public boolean Authentication(int sid, String pass) {
		boolean flag = false;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "Select * from StudentDb where sid=? and password=?";
			ps = con.prepareStatement(query);
			ps.setInt(1, sid);
			ps.setString(2, Password.encrypt(pass));
			rs = ps.executeQuery();
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			rs = null;
			ps = null;
			con = null;
			return flag;
		}
	}

	
	public boolean addStudent(StudentDto dto) {
		boolean flag = false;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "insert into StudentDb(name,password,mobile,email,date,dob) values(?,?,?,?,?,?)";
			ps = con.prepareStatement(query);
			ps.setString(1, dto.getName());
			ps.setString(2, Password.encrypt(dto.getPassword()));
			ps.setString(3, dto.getMobile());
			ps.setString(4, dto.getEmail());
			ps.setString(5, CurrDate.getCurrDate());
			ps.setString(6, dto.getDob());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception in addStudent : " + e.getMessage());
		} finally {
			con = null;
			ps = null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public StudentDto viewStudent(int sid) {
		StudentDto dto = new StudentDto();
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "select * from StudentDb where sid=?";
			ps = con.prepareStatement(query);
			ps.setInt(1, sid);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setMobile(rs.getString("mobile"));
				dto.setDate(rs.getString("date"));
				dto.setDob(rs.getString("dob"));
				dto.setPassword(Password.decrypt(rs.getString("password")));
				dto.setSid(rs.getInt("sid"));
			}
		} catch (Exception e) {
			System.out.println("Exception in viewStudent : " + e.getMessage());
		} finally {
			rs = null;
			ps = null;
			con = null;
			return dto;
		}
	}

	@SuppressWarnings("finally")
	public boolean removeStudent(int sid) {
		boolean flag = false;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "delete from StudentDb where sid=?";
			ps = con.prepareStatement(query);
			ps.setInt(1, sid);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception in removeStudent : " + e.getMessage());
		} finally {
			rs = null;
			ps = null;
			con = null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public boolean updateStudent(StudentDto dto) {
		boolean flag = false;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "update table StudentDb set name=?,email=?,,mobile=?,"
					+ "password=?,date=?,dob=? where sid=?";
			ps = con.prepareStatement(query);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getEmail());
			ps.setString(3, dto.getMobile());
			ps.setString(4, Password.encrypt(dto.getPassword()));
			ps.setString(5, dto.getDate());
			ps.setString(6, dto.getDob());
			ps.setInt(7, dto.getSid());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception in updateStudent : " + e.getMessage());
		} finally {
			ps = null;
			con = null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public boolean changePassword(String email, String password) {
		boolean flag = true;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "update StudentDb set password=? where email=?";
			ps = con.prepareStatement(query);
			ps.setString(1, Password.encrypt(password));
			ps.setString(2, email);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception in changePassword : " + e.getMessage());
		} finally {
			ps = null;
			con = null;
			return flag;
		}
	}

	@SuppressWarnings("finally")
	public ArrayList<StudentDto> getAllStudent() {
		ArrayList<StudentDto> al = new ArrayList<>();
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "select name,mobile,email,date,password,dob,sid from StudentDb";
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				StudentDto dto = new StudentDto();
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setMobile(rs.getString("mobile"));
				dto.setDate(rs.getString("date"));
				dto.setPassword("password");
				dto.setSid(rs.getInt("sid"));
				dto.setDob(rs.getString("dob"));
				al.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Exception in getAllStudent:" + e);
		} finally {
			rs = null;
			ps = null;
			con = null;
			return al;
		}
	}
	
	public int sendOtp(String email,String mno) {
		int otp=0;
		try {
			if(con == null) {
				con=LibraryDb.getConnection();
			}
			ps=con.prepareStatement("Select * from StudentDb where mobile=? and email=?");
			ps.setString(1, mno);
			ps.setString(2, email);
			rs=ps.executeQuery();
			if(rs.next()) {
				otp=Utility.getRandom();
				if(! new Utility().sendMail(""+otp,email)) {
					otp=0;
				}
			}
		} catch (Exception e) {
			System.out.println("Exception at sendOtp : "+e);
		} finally {
			rs=null;
			ps=null;
			con=null;
			return otp;
		}
	}
	
	@SuppressWarnings("finally")
	public StudentDto studentLogin(String email,String pwd) {
		StudentDto dto = null;
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "select sid from StudentDb where email=? and password=?";
			ps = con.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, Password.encrypt(pwd));
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new StudentDto();
				dto.setSid(rs.getInt("sid"));
			}
		} catch (Exception e) {
			System.out.println("Exception in getAllStudent:" + e);
		} finally {
			rs = null;
			ps = null;
			con = null;
			return dto;
		}
	}
	
	
	public static void main(String[] args) {
		/*StudentDao dao = new StudentDao();
		StudentDto dto = new StudentDto();
		dto.setName("Sanjeet");
		dto.setDate("unybtvrcdex");
		dto.setDob("ytgfr");
		dto.setEmail("yhgtfrde");
		dto.setPassword("juhygtfr");
		dto.setMobile("3456789");
		System.out.println(new StudentDao().addStudent(dto));
		*/
		StudentDao dao=new StudentDao();
		System.out.println(dao.sendOtp("sanjeet.shannonitu25@gmail.com","8987045110"));
	}
}
