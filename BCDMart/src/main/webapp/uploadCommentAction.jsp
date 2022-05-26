<%@page import="java.io.PrintWriter"%>
<%@ page import = "shoe.ShoeDAO" %>
    <%@ page import = "shoe.Shoe" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="shoe" class="shoe.Shoe" scope="page" />
<jsp:setProperty name="shoe" property="upload_id" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BCD MART</title>
</head>
<body>
	<%
	String userid = null;
	if(session.getAttribute("userID") != null){
		userid = (String)session.getAttribute("userID");
	}
	String upload_id = null;
	if(session.getAttribute("upload_id") != null){
		upload_id = (String)session.getAttribute("upload_id");
	}	
		System.out.println(upload_id);
    if(upload_id == null) {
   	 PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('Not valid shoe.')");
       script.println("location.href = 'buy.jsp'");
       script.println("</script>");
   }
    ShoeDAO da = new ShoeDAO();
    Shoe s = da.getShoeinfo(upload_id);
		if(request.getParameter("comment") == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You missed the comment')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			ShoeDAO sDAO = new ShoeDAO();
			int result = sDAO.InsertIntoComment(upload_id, userid,request.getParameter("comment"));
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('You can upload only one comment')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Successfully uploaded')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>