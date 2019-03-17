<%
Integer aid=(Integer)session.getAttribute("aid");
if(aid==null){
	response.sendRedirect("adminsignin.jsp");
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/style.css">

</head>
<body>
	<jsp:include page="header.html"></jsp:include>
	<jsp:include page="adminmenu.html"></jsp:include>

	<div class="container">
		<div style="text-align: center; font-weight: bold; font-size: 20px;">Add
			Books</div>

		<%
			if (request.getMethod().equalsIgnoreCase("post")) {
		%>
		<jsp:useBean id="dto" class="com.library.book.BookDto"></jsp:useBean>
		<jsp:setProperty property="*" name="dto" />
		<jsp:useBean id="dao" class="com.library.book.BookDao"></jsp:useBean>

		<%
			if (dao.addBook(dto)) {
		%>
		<jsp:forward page="viewAllBooks.jsp"></jsp:forward>
		<%
			} else {
		%>
		<br />
		<center style="color: red;">Add Book Failed</center>
		<%
			}
			}
		%>
		<form action="addBook.jsp" method="post">

			<label>BookName</label> <input type="text" id="bookname"
				name="bookname" placeholder="Book name.." autofocus
				required="required" pattern="[A-Za-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert only alphabets' : '');">

			<label>Author</label> <input type="text" id="author" name="author"
				placeholder="Author name.." required="required"
				pattern="[A-Za-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert only alphabets' : '');">

			<label>Publication</label> <input type="text" id="publication"
				name="publication" placeholder="Publisher name.."
				required="required" pattern="[A-Za-z|\s]*"
				onchange="this.setCustomValidity(validity.patternMismatch ? 'Insert only alphabets' : '');">

			<label>Quantity</label> <input type="number" id="quantity"
				name="quantity" placeholder="Quantity.." required="required">

			&nbsp&nbsp <label>Category</label> <select name="category"
				required="required">
				<option value="">Select Category</option>
				<option value="technical">Technical</option>
				<option value="non technical">Non Technical</option>
			</select> <br /> <br />
			<center>
				<input type="submit" value="Add Book">
			</center>
		</form>
	</div>
</body>
</html>