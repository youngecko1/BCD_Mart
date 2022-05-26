<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    <%@page import="user.UserDAO"%>
           <%@ page import = "java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
</head>
<body>
<%
String user_id = null;
String nickname = null;
if(session.getAttribute("newID") != null) {
	user_id = (String) session.getAttribute("newID");	

	
}
String id = null;
if(session.getAttribute("userID") != null) {
	id = (String) session.getAttribute("userID");
	UserDAO dao = UserDAO.getInstance();
	nickname = dao.getUserinfo(user_id).getNickname();
}
if(id != null) {
	 PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('Already logged in.')");
     script.println("location.href = 'main.jsp'");
     script.println("</script>");
}


%>
  <nav class ="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">BCD MART</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
              <li><a href="buy.jsp">BUY</a></li>
                    <li><a href="sell.jsp">SELL</a></li>
                 <li><a href="community.jsp">COMMUNITY</a></li>
                   <li><a href="coupon.jsp">COUPON</a></li>
            
            </ul>
            <%
            if(user_id == null) {
            	 %>
            	<ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">User<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">Login</a></li>
                        <li><a href="join.jsp">Register</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            } else {
            	 %>
            	 <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">Welcome <%= nickname %><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                    <li><a href="userpage.jsp">Mypage</a></li>      
                        <li><a href="modify.jsp">Modify</a></li>      
                        <li><a href="logoutAction.jsp">Logout</a></li>                  
                    </ul>
                </li>
            </ul>
            	 <%
            }
            %>
            
        </div>
    </nav>
 <!-- 회원가입 양식 -->
	<div class="container">		<!-- 하나의 영역 생성 -->
		<div class="col-lg-4">	<!-- 영역 크기 -->
			<!-- 점보트론은 특정 컨텐츠, 정보를 두드러지게 하기 위한 큰 박스 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align: center;">Registration</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="ID" name="nickname" maxlength="50">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="Password" name="password" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="FirstName" name="first_name" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="LastName" name="last_name" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="PhoneNum" name="cell_num" maxlength="20">
					</div>
					<div class="form-group">
					<%
                    UserDAO d = UserDAO.getInstance();
                    ArrayList<String> dlist = d.findcity();
                    	%>
					 <select name = "district" onchange="SetTypeTail(district.options[this.selectedIndex].value)">
                        <option value="notSelected" >::Choose the city::</option>
   <%  for(int i = 0; i < dlist.size(); i++) {
           String option = (String)dlist.get(i);
   %>
   <option value="<%= option %>"><%= option %></option>
   <% } %>
</select>
</div>
					<div class="form-group">
						<input type="number" class="form-control" placeholder="balance" name="balance" maxlength="20">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="gender" autocomplete="off" value="male" checked>Male
							</label>
							<label class="btn btn-primary active">
								<input type="radio" name="gender" autocomplete="off" value="female" checked>Female
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="email" name="email" maxlength="50">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="Join">
				</form>
			</div>
		</div>	
	</div>

</body>
</html>