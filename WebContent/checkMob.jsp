<jsp:useBean id="dao" class="com.library.student.StudentDao"></jsp:useBean>
<%
String mobile=request.getParameter("mobile");
if(mobile!=null){
if(dao.checkMno(mobile)){
%>
<%="Mobile number already exists.. "%>
<%} else {%>
<%="No error" %>
<%}
}%>