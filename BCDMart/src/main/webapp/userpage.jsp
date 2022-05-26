<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import = "java.io.PrintWriter"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import = "shoe.ShoeDAO" %>
<%@ page import = "shoe.Shoe" %>
<%@ page import = "community.CommunityDAO" %>
<%@ page import = "community.Community" %>
<%@ page import = "java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1" >        
<link rel="stylesheet" href = "resources/css/bootstrap.css">
<link rel="stylesheet" href = "resources/css/NewFile.css">
<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src = "resources/js/bootstrap.js"></script>
<title>BCD MART</title>
</head>
<style>
.float-container {
    border: 3px solid #fff;
    padding: 20px;
}

.float-child {
    width: 50%;
    float: left;
    padding: 20px;
    border: 2px solid red;
}  
</style>
<body>
<% 
String userid = null;
String nickname= null;
if(session.getAttribute("userID") != null) {
	userid = (String) session.getAttribute("userID");
	UserDAO dao = UserDAO.getInstance();
	nickname = dao.getUserinfo(userid).getNickname();
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
                    <li><a href="facility.jsp">SELL</a></li>
                 
                 <li><a href="community.jsp">COMMUNITY</a></li>
                   <li><a href="coupon.jsp">COUPON</a></li>
            
            </ul>
            <%
            if(userid == null) {
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
    
    <div class="float-container">

  <div class="float-child">
    <div style="text-align:center"><strong><a href="/room/modify.jsp">Details</a></strong></div>
  <%
    UserDAO udao = UserDAO.getInstance();
    User userlist = udao.getUserinfo(userid);
    
    %>
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
    <thead>
					<tr>
					<th style="background-color: #eeeeee; text-align: center;">First Name</th>
						<th style="background-color: #eeeeee; text-align: center;">Last Name</th>
						<th style="background-color: #eeeeee; text-align: center;">JoinDate</th>
						<th style="background-color: #eeeeee; text-align: center;">Address</th>
						<th style="background-color: #eeeeee; text-align: center;">balance</th>
					</tr>
				</thead>
				<tbody><tr>
						<td><%= userlist.getFirst_name()%></td>
						<td><%= userlist.getLast_name()%></td>
						<td><%= userlist.getJoindate() %></td>
						<td><%= userlist.getDistrict() %></td>
						<td><%= userlist.getBalance() %></td>
</tr></tbody>

					</table>
  </div>
  
  <div class="float-child">
    <div style="text-align:center"><strong>History of Articles</strong></div>
 
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
    <thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">Title</th>
						<th style="background-color: #eeeeee; text-align: center;">View</th>
						<th style="background-color: #eeeeee; text-align: center;">Likes</th>
						<th style="background-color: #eeeeee; text-align: center;">Date</th>
					</tr>
					 <%
    CommunityDAO cdao = CommunityDAO.getInstance();
    ArrayList<Community> commlist = cdao.getList(userid);
    for(int i = 0; i < commlist.size(); i++){
    %>
				</thead>
				<tbody><tr>
						<td><%= commlist.get(i).getTitle() %></td>
						<td><%= commlist.get(i).getView_cnt() %></td>
						<td><%= commlist.get(i).getLikes() %></td>
						<td><%= cdao.getDate(commlist.get(i).getArticle_id()) %></td>
</tr></tbody>
    					
					<%
    }
					%>
					</table>
  </div>
  
</div>
<div class="float-container">

  <div class="float-child">
    <div style="text-align:center"><strong>History of Purchase</strong></div>
    
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
    <thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">ShoeName</th>
						<th style="background-color: #eeeeee; text-align: center;">Brand</th>
						<th style="background-color: #eeeeee; text-align: center;">Sizes</th>
						<th style="background-color: #eeeeee; text-align: center;">Color</th>
						<th style="background-color: #eeeeee; text-align: center;">Date</th>
					</tr>
					<%
    ShoeDAO sdao = ShoeDAO.getInstance();
    ArrayList<Shoe> shoelist = sdao.getShoeinfoByEmail(userid);
    for(int i = 0; i < shoelist.size(); i++){
    %>
				</thead>
				<tbody><tr>
						<td><%= shoelist.get(i).getShoe_name() %></td>
						<td><%= shoelist.get(i).getBrand() %></td>
						<td><%= shoelist.get(i).getSizes() %></td>
						<td><%= shoelist.get(i).getColor() %></td>
						<td><%= sdao.getBuyDate(shoelist.get(i).getUpload_id(), userid) %></td>
</tr></tbody>
    					
					<%
    }
					%>
					</table>
  </div>

  <div class="float-child">
    <div style="text-align:center"><strong>History of Uploads</strong></div>
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
    <thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">ShoeName</th>
						<th style="background-color: #eeeeee; text-align: center;">Brand</th>
						<th style="background-color: #eeeeee; text-align: center;">Sizes</th>
						<th style="background-color: #eeeeee; text-align: center;">Color</th>
						<th style="background-color: #eeeeee; text-align: center;">Date</th>
					</tr>
    <%
    ShoeDAO sdao2 = ShoeDAO.getInstance();
    ArrayList<Shoe> shoelist2 = sdao2.getUploadedShoeinfoByEmail(userid);
    for(int i = 0; i < shoelist2.size(); i++){
    %>
    
				</thead>
				<tbody><tr>
						<td><%= shoelist2.get(i).getShoe_name() %></td>
						<td><%= shoelist2.get(i).getBrand() %></td>
						<td><%= shoelist2.get(i).getSizes() %></td>
						<td><%= shoelist2.get(i).getColor() %></td>
						<td><%= sdao.getSellDate(shoelist2.get(i).getUpload_id(), userid) %></td>
</tr></tbody>
    					
					<%
    }
					%>
					</table>
  </div>
  </div>
  
  
</div>
     <div class = "footer">
     <p> Copyright (C) 2021 Hyungtaek Kwon and Youngwon Choi All Right Reserved</p>
     </div>

</body>
</html>