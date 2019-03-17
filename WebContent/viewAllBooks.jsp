<%
Integer aid=(Integer)session.getAttribute("aid");
if(aid==null){
	response.sendRedirect("adminsignin.jsp");
}
%>
<%@page import="com.library.book.BookDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Books</title>
<link type="text/css" rel="stylesheet" href="css/style.css">

</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<jsp:include page="adminmenu.html"></jsp:include>
	<jsp:useBean id="dao" class="com.library.book.BookDao"></jsp:useBean>
	<h1>
		<center>Books</center>
	</h1>
	<%
		String bid = request.getParameter("bid");
		if (bid != null) {
			int bookid = Integer.parseInt(bid);
			dao.removeBook(bookid);
		}
		ArrayList<BookDto> al = dao.getAllBooks();
		int x = 0;
		if (al == null) {
	%>
	No Data in Database
	<%
		} else {
	%>
	<table id="book">
		<tr>
			<th>S.No</th>
			<th>Book Id</th>
			<th>Name</th>
			<th>Author</th>
			<th>Publication</th>
			<th>Category</th>
			<th>Quantity</th>
			<th>Operation</th>
		</tr>
		<%
			for (BookDto dto : al) {
		%>
		<tr>
			<td><%=++x%></td>
			<td><%=dto.getBid()%></td>
			<td><%=dto.getBookname()%></td>
			<td><%=dto.getAuthor()%></td>
			<td><%=dto.getPublication()%></td>
			<td><%=dto.getCategory()%></td>
			<td><%=dto.getQuantity()%></td>
			<td><a href="updateBook.jsp?bid=<%=dto.getBid()%>">Edit</a>
				&nbsp&nbsp&nbsp <a href="viewAllBooks.jsp?bid=<%=dto.getBid()%>">Delete</a></td>
		</tr>

		<%
			}
		%>
	</table>
	<%
		}
	%>
</body>
</html>