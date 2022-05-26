package coupon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
 
public class CouponDAO {
    
    private Connection conn;            // DB�� �����ϴ� ��ü
    private PreparedStatement pstmt;    // 
    private ResultSet rs;                // DB data�� ���� �� �ִ� ��ü  (Ctrl + shift + 'o') -> auto import
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
			//����̹� �ε�
			Class.forName("org.mariadb.jdbc.Driver");
			//Ŀ�ؼ� ��������
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
			return null; //ù ��° �Խù��� ���
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null; //�����ͺ��̽� ����
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
