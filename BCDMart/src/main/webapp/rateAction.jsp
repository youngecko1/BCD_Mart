<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shoe.ShoeDAO"%>
<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="shoe" class="shoe.Shoe" scope="page"></jsp:useBean>
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="shoe" property="upload_id" />
<jsp:setProperty name="user" property="email" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BCD MART</title>
</head>
<body>
<%
String userid = null;
if(session.getAttribute("userID") != null){
	userid = (String)session.getAttribute("userID");
}

if(userid == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Log in!')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
}

String upload_id = null;
if(session.getAttribute("upload_id") != null){
	upload_id = (String)session.getAttribute("upload_id");
}
if(upload_id == null) {
	 PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('Not valid shoe.')");
    script.println("location.href = 'buy.jsp'");
    script.println("</script>");
}
if(request.getParameter("rate") == null) {
	System.out.println(request.getParameter("rate"));
	 PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('You missed the rating.')");
     script.println("history.back()");    // 이전 페이지로 사용자를 보냄
     script.println("</script>");
} else{
	ShoeDAO sd = new ShoeDAO();
	int rating = sd.getUserRating(upload_id,userid);
	if(rating == 0){
		sd.setRating(userid, upload_id,Integer.parseInt(request.getParameter("rate")));
		PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('Successfully rated.')");
	    script.println("location.href = 'buy.jsp'");    // 이전 페이지로 사용자를 보냄
	    script.println("</script>");
	}
	else{
		sd.updateRating(userid, upload_id, Integer.parseInt(request.getParameter("rate")));
		PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('Successfully re-rated.')");
	    script.println("location.href = 'buy.jsp'");    // 이전 페이지로 사용자를 보냄
	    script.println("</script>");
	}
	
}
%>
</body>