<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "shoe.ShoeDAO" %>
    <%@ page import = "shoe.Shoe" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BCD MART</title>
</head>
<body>
    <%
    String user_id = null;
    if(session.getAttribute("userID") != null) {
    	user_id = (String) session.getAttribute("userID");
    }
    if(user_id == null) {
    	 PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('Need to login.')");
         script.println("location.href = 'login.jsp'");
         script.println("</script>");
    }
    String upload_id = null;
    if(session.getAttribute("upload_id") != null){
    	upload_id = (String)session.getAttribute("upload_id");
    }
	
	if(upload_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('This shoe is no longer available')");
		script.println("location.href='buy.jsp'");
		script.println("</script");
	}
    
    ShoeDAO dao = ShoeDAO.getInstance();
        	    	
        	    			int result = dao.deleteComment(user_id, upload_id);
                	    	if(result == -1) {
                	    		PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('Failed to delete')");
                	            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
                	            script.println("</script>");
                	           
                	            
                	    	} 
                	    	else {
                	            PrintWriter script = response.getWriter();
                	            script.println("<script>");
                	            script.println("alert('Successfully deleted.')");
                	            script.println("location.href = 'buy.jsp'");
                	            script.println("</script>");
                	        }

    %>
 
</body>
</html>
