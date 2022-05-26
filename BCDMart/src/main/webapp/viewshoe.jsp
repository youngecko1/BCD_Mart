<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="shoe.Shoe" %>
<%@ page import="shoe.ShoeDAO" %>
<%@ page import = "user.UserDAO"%>
<%@ page import = "user.User"%>
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
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userid = null;
String nickname= null;
if(session.getAttribute("userID") != null) {
	userid = (String) session.getAttribute("userID");
	UserDAO dao = UserDAO.getInstance();
	nickname = dao.getUserinfo(userid).getNickname();
}
		String upload_id = null;
		if(request.getParameter("upload_id") != null){
			upload_id = request.getParameter("upload_id");
			session.setAttribute("upload_id", upload_id);
			}		

		if(upload_id == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This shoe is no longer available valid')");
			script.println("location.href='buy.jsp'");
			script.println("</script");
		}
		System.out.println(upload_id);
		ShoeDAO dao = ShoeDAO.getInstance();
		Shoe s = dao.getShoeinfo(upload_id);
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
    <div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">Shoe Specs</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">Name</td>
						<td colspan="2"><%= s.getShoe_name().replaceAll(" ", "&nbsp;")
								.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>Brand</td>
						<td colspan="2"><%= s.getBrand() %></td>
					</tr>
					<tr>
						<td>Color</td>
						<td colspan="2"><%= s.getColor() %></td>
					</tr>
					<tr>
						<td>Seller</td>
						<td colspan="2"><%= dao.getUploader(upload_id) %></td>
					</tr>
					
					<%
						ShoeDAO com = new ShoeDAO(); // 인스턴스 생성
						Shoe shoe = com.getShoeinfo(upload_id);
							String address = com.getPic(shoe.getBrand(), shoe.getShoe_name());
							address = "resources/" + address;
							
					%>
					<tr>
						<td>Picture</td>
						<td><img src="<%=address %>" width=120, height=120></td>
					</tr>
					<tr>
						<td>Quantity</td>
						<td colspan="2"><%= s.getQuantity() %></td>
					</tr>
					<tr>
						<td>Sizes</td>
						<td colspan="2"><%= s.getSizes()%></td>
					</tr>
					<tr>
						<td>Gender</td>
						<td colspan="2"><%= dao.getGender(s.getSizes())%></td>
					</tr>
					<tr>
						<td>Price</td>
						<td colspan="2"><%= dao.getPrice(s.getBrand(), s.getShoe_name()) %></td>
					</tr>
					<tr>
						<td>Type</td>
						<td colspan="2"><%= dao.getType(s.getBrand())%></td>
					</tr>
					<tr>
						<td>Rating</td>
						<td colspan="2"><%= dao.getRating(upload_id)%> by <%=dao.getRatingNum(upload_id) %> Users</td>
					</tr>
					<tr>
						<td>MyRating</td>
						<td colspan="2">Current rate: <%= dao.getUserRating(upload_id, userid)%>  
						<form method = "post" action="rateAction.jsp">
						<select name="rate" 
onchange="SetTypeTail(type.options[this.selectedIndex].value)">
    <option value="notSelected" >::Reset the rating::</option>
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4</option>
    <option value="5">5</option>
   </select>
   <input type="submit" class="btn btn-primary " value="Rate the Shoe">
						                </form>
					</tr>
					
					<tr>
						<td>Wishes</td>
						<td colspan="2"><%= dao.getWishes(upload_id)%></td>
					</tr>
					
					<tr>
						<td>Comments</td>
						<td colspan="2"><%
						ArrayList<String> coments = dao.getComment(upload_id);
						ArrayList<String> date = dao.getCommentDate(upload_id);
						for(int i = 0; i < coments.size(); i++){
							
						%>
						<%=
								coments.get(i)
						%>
						written in
						<%=
								date.get(i)
						%>
						</td>
						<%	
						}
						
						%>
						

						
					</tr>
					<tr>
						<td>MyComments</td>
						<td colspan="2"><%
						ArrayList<String> mycoments = dao.getMyComment(upload_id, userid);
						ArrayList<String> mydate = dao.getMyCommentDate(upload_id,userid);
						for(int i = 0; i < mycoments.size(); i++){
							
						%>
						<%=
								mycoments.get(i)
						%>
						written in
						<%=
								mydate.get(i)
						%>
						
					<a href="deleteCommentAction.jsp?upload_id=<%= upload_id %>" class="btn btn-primary">Delete</a>
						</td>
					
					
			
						<%	
						}
						
						%>
						

						
					</tr>
					<tr>
						<td>Write Comments</td>
						<td><form method = "post" action = "uploadCommentAction.jsp">
						<input type="text" class="form-control" placeholder="comment" name="comment" maxlength="50">
						<input type="submit" class="btn btn-primary " value="Upload">
						</form>
					</tr>
					
				</tbody>
			</table>
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<div>
			<a href="buy.jsp" class="btn btn-primary">List</a>
			<%
			if(userid != null && !userid.equals(dao.getEmail(upload_id))){
			%>
			<%
			if(dao.getUserWishes(upload_id, userid) == 1){
			%>
			<a href="wishaction.jsp" class="btn btn-primary">Unwish</a>
			<%
			}
			%>
			<%
			if(dao.getUserWishes(upload_id, userid) == 0){
			%>
			<a href="wishaction.jsp" class="btn btn-primary">Wish</a>
			<%
			}
			%>
			<a href="buyaction.jsp" class="btn btn-primary">Buy</a>
			<%
			}
			%>
			
			<%
				if(userid != null && userid.equals(dao.getEmail(upload_id))){
			%>
					<a href="deleteShoeAction.jsp?upload_id=<%= upload_id %>" class="btn btn-primary">Delete</a>
			<%
				}
			%>
			</div>
			
		</div>
		
	</div>
	
</body>
</html>