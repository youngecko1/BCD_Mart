package coupon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
 
public class CouponDAO {
    
    private Connection conn;            // DB에 접근하는 객체
    private PreparedStatement pstmt;    // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static CouponDAO instance;
    
    public CouponDAO(){
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
    
    public static CouponDAO getInstance() {
    	if(instance == null)
    		instance = new CouponDAO();
    	return instance;
    }
    
    public String getCouponid() {
    	String sql = "select COUNT(*) from Coupon";
    	try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int bc = rs.getInt(1)+100;
				String ne = "C" + bc;
				System.out.println(ne);
    	    	return ne;
			}
			return null; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null; //데이터베이스 오류
    }
    
    public int insertCoupon(int amount, String email) {
    	String sql = "insert into Coupon values(?, ?, ?)";
    	try {
    		pstmt = conn.prepareStatement(sql);
     	    pstmt.setString(1, email);
    		pstmt.setString(2, getCouponid());
    		pstmt.setInt(3, amount);
     	    return pstmt.executeUpdate();
    	}catch (Exception e) {
    	 	e.printStackTrace();
    	  }
    	return -1;
    
}

}
