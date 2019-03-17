<%@page import="com.library.book.BookDao"%>
<%
	Integer sid = (Integer) session.getAttribute("sid");
	if (sid == null) {
		response.sendRedirect("signin.jsp");
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
<script type="text/javascript">
function bookList1(){
	var data=document.getElementById('n1').value;
	window.location.replace("studentBooks.jsp?category=" + data);
}
function bookList2(){
	var data=document.getElementById('n2').value;
	window.location.replace("studentBooks.jsp?category=" + data);
}
</script>
</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<jsp:include page="studentMenu.jsp"></jsp:include>
	<jsp:useBean id="dao" class="com.library.book.BookDao"></jsp:useBean>
	<h1>
		<center>Books</center>
	</h1>
	<br/>
	<%
		String category = request.getParameter("category");
		if (category == null) {
	%>
	<center>
	<input type="radio" onclick="bookList1()" id="n1" value="non technical"
		name="category">Non Technical&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="radio" onclick="bookList2()" id="n2" value="technical"
		name="category">Technical
		</center>
	<%
		} else {
			if (category.equalsIgnoreCase("technical")) {
	%>
	<center>
	<input type="radio" onclick="bookList1()" id="n1" value="non technical"
		name="category">Non Technical&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="radio" onclick="bookList2()" id="n2" value="technical"
		checked="checked" name="category">Technical
	</center>
	<%
		} else {
	%>
	<center>
	<input type="radio" onclick="bookList1()" id="n1" value="non technical"
		checked="checked" name="category">Non Technical&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<input type="radio" onclick="bookList2()" id="n2" value="technical"
		name="category">Technical
	</center>
	<%
		}
		}
	%>
	<%
		ArrayList<BookDto> al = null;
		if (category != null) {
			al = new BookDao().getAllBooksByCat(category);
		} else {
			al = new BookDao().getAllBooks();
		}
		int x = 0;
		if (al == null) {
	%>
	<br/><br/><center style="color: white;">No Books Available</center>
	<%
		} else {
	%>
	<br/>
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
			<td><a href="#">Issue</td>
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