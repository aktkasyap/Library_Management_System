package com.library.book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.library.db.LibraryDb;
import com.library.book.BookDto;
import com.library.utilities.CurrDate;
import com.library.utilities.Password;

public class BookDao {

	Connection con=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	@SuppressWarnings("finally")
	public boolean checkBookName(String bookname) {
		boolean flag=false;
		try {
			if(con==null) {
				con=LibraryDb.getConnection();
			}
			String query="Select * from BookDb where bookname="+bookname;
			ps=con.prepareStatement(query);
			rs=ps.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		finally {
			rs=null;
			ps=null;
			con=null;
			return flag;
		}
	}
	@SuppressWarnings("finally")
	public boolean checkBid(int bid) {
		boolean flag=false;
		try {
			if(con==null) {
				con=LibraryDb.getConnection();
			}
			String query="Select * from BookDb where bid="+bid;
			ps=con.prepareStatement(query);
			rs=ps.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		finally {
			rs=null;
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean addBook(BookDto dto) {
		boolean flag=false;
		try {
			if(con==null) {
				con=LibraryDb.getConnection();
			}
			String query="insert into BookDb(bookname,author,publication,category,quantity) values(?,?,?,?,?)";
			ps=con.prepareStatement(query);
			ps.setString(1, dto.getBookname());
			ps.setString(2, dto.getAuthor());
			ps.setString(3, dto.getPublication());
			ps.setString(4, dto.getCategory());
			ps.setInt(5, dto.getQuantity());
			if(ps.executeUpdate()>0) {
				flag=true;
			}
		}
		catch(Exception e){
			System.out.println("Exception in addBook : "+e.getMessage());
		}
		finally {
			con=null;
			ps=null;
			return flag;
		}
	}
	
	
	@SuppressWarnings("finally")
	public BookDto viewBook(int bid) {
		BookDto dto=new BookDto();
		try {
			if(con==null) {
				con=LibraryDb.getConnection();
			}
			String query="select * from BookDb where bid=?";
			ps=con.prepareStatement(query);
			ps.setInt(1, bid);
			rs=ps.executeQuery();
			if(rs.next()) {
				dto.setBookname(rs.getString("bookname"));
				dto.setAuthor(rs.getString("author"));
				dto.setBid(rs.getInt("bid"));
				dto.setCategory(rs.getString("category"));
				dto.setPublication(rs.getString("publication"));
				dto.setQuantity(rs.getInt("quantity"));
			}
		}
		catch (Exception e){
			System.out.println("Exception in viewBook : "+e.getMessage());
		}
		finally {
			rs=null;
			ps=null;
			con=null;
			return dto;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean removeBook(int bid) {
		boolean flag=false;
		try {
			if(con==null) {
				con=LibraryDb.getConnection();
			}
			String query="delete from BookDb where bid=?";
			ps=con.prepareStatement(query);
			ps.setInt(1, bid);
			if(ps.executeUpdate()>0) {
				flag=true;
			}
		}
		catch (Exception e){
			System.out.println("Exception in removeBook : "+e.getMessage());
		}
		finally {
			rs=null;
			ps=null;
			con=null;
			return flag;
		}
	}
	
	@SuppressWarnings("finally")
	public boolean updateBook(BookDto dto) {
		boolean flag=false;
		try {
			if(con==null) {
				con=LibraryDb.getConnection();
			}
			String query="update BookDb set bookname=?,author=?,publication=?,"
					+ "category=?,quantity=? where bid=?";
			ps=con.prepareStatement(query);
			ps.setString(1, dto.getBookname());
			ps.setString(2, dto.getAuthor());
			ps.setString(3, dto.getPublication());
			ps.setString(4, dto.getCategory());
			ps.setInt(5, dto.getQuantity());
			ps.setInt(6, dto.getBid());
			if(ps.executeUpdate()>0) {
				flag=true;
			}
		}
		catch(Exception e) {
			System.out.println("Exception in updateStudent : "+e.getMessage());
		}
		finally {
			ps=null;
			con=null;
			return flag;
		}
	}
	

	@SuppressWarnings("finally")
	public ArrayList<BookDto> getAllBooks() {
		ArrayList<BookDto> al = new ArrayList<>();
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "select bookname,author,publication,category,quantity,bid from BookDb";
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				BookDto dto = new BookDto();
				dto.setBookname(rs.getString("bookname"));
				dto.setAuthor(rs.getString("author"));
				dto.setPublication(rs.getString("publication"));
				dto.setCategory(rs.getString("category"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setBid(rs.getInt("bid"));
				al.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("Exception in getAllStudent:" + e);
		} finally {
			if (al.isEmpty()) {
				al = null;
			}
			rs = null;
			ps = null;
			con = null;
			return al;
		}
	}
	
	public ArrayList<BookDto> getAllBooksByCat(String cat) {
		ArrayList<BookDto> al = new ArrayList<>();
		try {
			if (con == null) {
				con = LibraryDb.getConnection();
			}
			String query = "select bookname,author,publication,quantity,bid from BookDb where category=?";
			ps = con.prepareStatement(query);
			ps.setString(1, cat);
			rs = ps.executeQuery();
			while (rs.next()) {
				BookDto dto = new BookDto();
				dto.setBookname(rs.getString("bookname"));
				dto.setAuthor(rs.getString("author"));
				dto.setPublication(rs.getString("publication"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setBid(rs.getInt("bid"));
				al.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("Exception in getAllStudent:" + e);
		} finally {
			if (al.isEmpty()) {
				al = null;
			}
			rs = null;
			ps = null;
			con = null;
			return al;
		}
	}
	
	public static void main(String[] args) {
		/*BookDao dao=new BookDao();
		BookDto dto= new BookDto();
		dto.setAuthor("James");
		dto.setBid(5);
		dto.setBookname("Java");
		dto.setCategory("technical");
		dto.setPublication("Oracle Java");
		dto.setQuantity(100);
		System.out.println(dao.updateBook(dto));*/
	}
}
