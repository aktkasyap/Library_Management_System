package com.library.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.library.db.LibraryDb;
import com.library.utilities.Password;

public class AdminDao {
	
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
				String query = "Select mobile from AdminDb where mobile=" + mno;
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
		public boolean checkaid(int aid) {
			boolean flag = false;
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "Select * from AdminDb where aid=" + aid;
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
		public AdminDto Authentication(String email, String pass) {
			AdminDto dto=null;
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "Select aid from AdminDb where email=? and password=?";
				ps = con.prepareStatement(query);
				ps.setString(1, email);
				ps.setString(2, Password.encrypt(pass));
				rs = ps.executeQuery();
				if (rs.next()) {
					dto=new AdminDto();
					dto.setAid(rs.getInt("aid"));
				}
			} catch (Exception e) {
				System.out.println("Exception in Authentication : "+e);
			} finally {
				rs = null;
				ps = null;
				con = null;
				return dto;
			}
		}

		
		public boolean addAdmin(AdminDto dto) {
			boolean flag = false;
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "insert into AdminDb(name,password,mobile,email,dob) values(?,?,?,?,?)";
				ps = con.prepareStatement(query);
				ps.setString(1, dto.getName());
				ps.setString(2, Password.encrypt(dto.getPassword()));
				ps.setString(3, dto.getMobile());
				ps.setString(4, dto.getEmail());
				ps.setString(5, dto.getDob());
				if (ps.executeUpdate() > 0) {
					flag = true;
				}
			} catch (Exception e) {
				System.out.println("Exception in addAdmin : " + e.getMessage());
			} finally {
				con = null;
				ps = null;
				return flag;
			}
		}

		@SuppressWarnings("finally")
		public AdminDto viewAdmin(int aid) {
			AdminDto dto = new AdminDto();
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "select * from AdminDb where aid=?";
				ps = con.prepareStatement(query);
				ps.setInt(1, aid);
				rs = ps.executeQuery();
				if (rs.next()) {
					dto.setName(rs.getString("name"));
					dto.setEmail(rs.getString("email"));
					dto.setMobile(rs.getString("mobile"));
					dto.setDob(rs.getString("dob"));
					dto.setPassword(Password.decrypt(rs.getString("password")));
					dto.setAid(rs.getInt("aid"));
				}
			} catch (Exception e) {
				System.out.println("Exception in viewAdmin : " + e.getMessage());
			} finally {
				rs = null;
				ps = null;
				con = null;
				return dto;
			}
		}

		@SuppressWarnings("finally")
		public boolean removeAdmin(int aid) {
			boolean flag = false;
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "delete from AdminDb where aid=?";
				ps = con.prepareStatement(query);
				ps.setInt(1, aid);
				if (ps.executeUpdate() > 0) {
					flag = true;
				}
			} catch (Exception e) {
				System.out.println("Exception in removeAdmin : " + e.getMessage());
			} finally {
				rs = null;
				ps = null;
				con = null;
				return flag;
			}
		}

		@SuppressWarnings("finally")
		public boolean updateAdmin(AdminDto dto) {
			boolean flag = false;
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "update table AdminDb set name=?,email=?,,mobile=?,"
						+ "password=?,dob=? where aid=?";
				ps = con.prepareStatement(query);
				ps.setString(1, dto.getName());
				ps.setString(2, dto.getEmail());
				ps.setString(3, dto.getMobile());
				ps.setString(4, Password.encrypt(dto.getPassword()));
				ps.setString(5, dto.getDob());
				ps.setInt(6, dto.getAid());
				if (ps.executeUpdate() > 0) {
					flag = true;
				}
			} catch (Exception e) {
				System.out.println("Exception in updateAdmin : " + e.getMessage());
			} finally {
				ps = null;
				con = null;
				return flag;
			}
		}

		@SuppressWarnings("finally")
		public boolean changePassword(int aid, String password) {
			boolean flag = true;
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "update table AdminDb set password=? where aid=?";
				ps = con.prepareStatement(query);
				ps.setString(1, Password.decrypt(password));
				ps.setInt(2, aid);
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
		public ArrayList<AdminDto> getAllAdmin() {
			ArrayList<AdminDto> al = new ArrayList<>();
			try {
				if (con == null) {
					con = LibraryDb.getConnection();
				}
				String query = "select name,mobile,email,password,dob,aid from AdminDb";
				ps = con.prepareStatement(query);
				rs = ps.executeQuery();
				while (rs.next()) {
					AdminDto dto = new AdminDto();
					dto.setName(rs.getString("name"));
					dto.setEmail(rs.getString("email"));
					dto.setMobile(rs.getString("mobile"));
					dto.setPassword("password");
					dto.setAid(rs.getInt("aid"));
					dto.setDob(rs.getString("dob"));
					al.add(dto);
				}
			} catch (Exception e) {
				System.out.println("Exception in getAllAdmin:" + e);
			} finally {
				rs = null;
				ps = null;
				con = null;
				return al;
			}
		}

		public static void main(String[] args) {
			/*AdminDao dao = new AdminDao();
			AdminDto dto = new AdminDto();
			dto.setName("Sanjeet");
			dto.setDate("unybtvrcdex");
			dto.setDob("ytgfr");
			dto.setEmail("yhgtfrde");
			dto.setPassword("juhygtfr");
			dto.setMobile("3456789");
			System.out.println(new AdminDao().addAdmin(dto));
			*/
		}
	}
