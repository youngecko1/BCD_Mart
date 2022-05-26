package user;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
 
public class UserDAO {
    
    private Connection conn;            // DB에 접근하는 객체
    private PreparedStatement pstmt;    // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static UserDAO instance;
    
    public UserDAO(){
        try {
            String dbURL = "jdbc:mysql://localhost:3306/shoe_db";
            String dbID = "grader";
            String dbPassword = "allowme";
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
    public static Connection getConnection() {
		Connection conn = null;
		String dbURL = "jdbc:mysql://localhost:3306/shoe_db";
        String dbID = "grader";
        String dbPassword = "allowme";
		try {
			//드라이버 로드
			Class.forName("org.mariadb.jdbc.Driver");
			//커넥션 가져오기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		System.out.println("Success");
		return conn;
	}
    
    public static UserDAO getInstance() {
    	if(instance == null)
    		instance = new UserDAO();
    	return instance;
    }
    
    public Date getDate() {
    	String SQL = "SELECT NOW()";
    try {
    PreparedStatement pstmt = conn.prepareStatement(SQL); 
    rs = pstmt.executeQuery();
    if(rs.next()) {
    	return rs.getDate(1);
    }
    } catch(Exception e) {
    	e.printStackTrace();
    }
    return null;
    }
    
    public ArrayList<String> findcity(){
    	String sql = "SELECT district from District";
    	ArrayList<String> list = new ArrayList<String>();
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		rs = pstmt.executeQuery();
			while(rs.next()) {
				String dt = null;
				dt = rs.getString(1);
				list.add(dt);
			}
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	return list;
    
    }
    public int login(String userID, String userPassword) {
        String SQL = "SELECT password FROM Users WHERE email = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString(1).equals(userPassword))
                    return 1;    // 로그인 성공
                else
                    return 0; // 비밀번호 불일치
            }
           
            return -1; // ID가 없음
            
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return -2; // DB 오류
        
    }
    
    public int join(User user) {
    	String sql = "insert into Users values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    	try {
    	    pstmt = conn.prepareStatement(sql);
    	    pstmt.setString(1, user.getEmail());
    	    pstmt.setString(2, user.getNickname());
    	    pstmt.setString(3, user.getFirst_name());
    	    pstmt.setString(4, user.getLast_name());
    	    pstmt.setString(5, user.getPassword());
    	    pstmt.setString(6, user.getDistrict());
    	    pstmt.setInt(7, user.getCell_num());
    	    pstmt.setInt(8, user.getBalance());
    	    pstmt.setString(9, user.getGender());
    	    pstmt.setDate(10, getDate());
    	    return pstmt.executeUpdate();
    	  }catch (Exception e) {
    	 	e.printStackTrace();
    	  }
    	  return -1;
    	}

    
    public void modify(User user) {
    	StringBuffer br = new StringBuffer();
		br.append("UPDATE Users ");
		br.append("SET nickname = ?, first_name = ?,  last_name = ?, district = ?, cell_num = ?,balance = ?, gender=?");
		br.append("WHERE email = ? ");
		try {
			 String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, user.getNickname());
	    pstmt.setString(2, user.getFirst_name());
	    pstmt.setString(3, user.getLast_name());
	    pstmt.setString(4, user.getDistrict());
	    pstmt.setInt(5, user.getCell_num());
	    pstmt.setInt(6, user.getBalance());
	    pstmt.setString(7, user.getGender());
  		pstmt.setString(8, user.getEmail());
	    pstmt.executeUpdate();
    }catch (Exception e) {
        e.printStackTrace();
    } 
    
 
}
    
    public User getUserinfo(String email) {
    	User info = null;
    	StringBuffer br = new StringBuffer();
		br.append("SELECT nickname, first_name, last_name, password, district, cell_num, balance, gender, joindate");
		br.append(" FROM Users");
		br.append(" WHERE email = ?");
		try {
			String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, email);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 info = new User();
				 info.setEmail(email);
				 info.setNickname(rs.getString(1));		
				 info.setFirst_name(rs.getString(2));
				 info.setLast_name(rs.getString(3));
				 info.setPassword(rs.getString(4));
				 info.setDistrict(rs.getString(5));
				 info.setCell_num(rs.getInt(6));
				 info.setBalance(rs.getInt(7));
				 info.setGender(rs.getString(8));
				 info.setJoindate(rs.getDate(9));
				 
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
		return info;
    }

}
