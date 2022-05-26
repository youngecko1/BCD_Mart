<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    <%@ page import = "java.io.PrintWriter"%>
            <%@ page import = "user.UserDAO" %>
       <%@ page import = "user.User" %>
        <%@ page import = "coupon.CouponDAO" %>
       <%@ page import = "coupon.Coupon" %>
       <jsp:useBean id="cp" class="coupon.Coupon" scope="page" />
       <jsp:setProperty name="cp" property="amount" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>BCD MART </title>
</head>
<body>
<% 
String userid = null;
if(session.getAttribute("userID") != null) {
	userid = (String) session.getAttribute("userID");
}
if(session.getAttribute("userID") == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('You need to log in!')");
	script.println("location.href='login.jsp");
	script.println("</script>");
}
System.out.println(request.getParameter("amount"));
if(request.getParameter("amount") == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('Coupon is not inserted correctly')");
	script.println("history.back()");
	script.println("</script>");
} else{
	CouponDAO dao = new CouponDAO();
	int amnt = Integer.parseInt(request.getParameter("amount"));
	int result = dao.insertCoupon(amnt, userid);
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Something went wrong')");
		script.println("history.back()");
		script.println("</script>");
	}else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Successfully added')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
}
	
}
%>
</body>
</html>