package community;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import java.sql.Statement;

import user.UserDAO;
import user.User;

public class CommunityDAO {
	private Connection conn;            // DB에 접근하는 객체   // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static CommunityDAO instance;
    
    public CommunityDAO(){
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
    
    public static CommunityDAO getInstance() {
    	if(instance == null)
    		instance = new CommunityDAO();
    	return instance;
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
  		return conn;
  	}
    
    public String getDate() {
    	String SQL = "SELECT NOW()";
    try {
    PreparedStatement pstmt = conn.prepareStatement(SQL); 
    rs = pstmt.executeQuery();
    if(rs.next()) {
    	return rs.getString(1);
    }
    } catch(Exception e) {
    	e.printStackTrace();
    }
    return "";
    }
    
    public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select article_id from Community order by article_id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
    
    public int getDateNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select article_id from Writes order by article_id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
    
    public int write(String title, String email, String content) {
		String sql = "insert INTO Community values(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, 0);
			pstmt.setInt(3, 0);
			pstmt.setString(4, title);
			pstmt.setString(5, content);
			pstmt.setString(6, email); 

			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
    
    public int delete(String email, int article_id) {
    	StringBuffer br = new StringBuffer();
		br.append("DELETE FROM Community ");
		br.append("WHERE email = ? and article_id = ?");
		try {
			 String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, email);
			 pstmt.setInt(2, article_id);
			 return pstmt.executeUpdate();
    }catch (Exception e) {
        e.printStackTrace();
    } 
		return -1;

}
    
    public ArrayList<Community> getList(String email){
		String sql = "select * from community where article_id IN (SELECT article_id from Writes where email=?)";
		ArrayList<Community> list = new ArrayList<Community>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Community bbs = new Community();
				bbs.setArticle_id(rs.getInt(1));
				bbs.setLikes(rs.getInt(2));
				bbs.setView_cnt(rs.getInt(3));
				bbs.setTitle(rs.getString(4));
				bbs.setContent(rs.getString(5));
				bbs.setEmail(email);
				list.add(bbs);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
    
    public ArrayList<Community> getListComp(){
		String sql = "select * from community";
		ArrayList<Community> list = new ArrayList<Community>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Community bbs = new Community();
				bbs.setArticle_id(rs.getInt(1));
				bbs.setLikes(rs.getInt(2));
				bbs.setView_cnt(rs.getInt(3));
				bbs.setTitle(rs.getString(4));
				bbs.setContent(rs.getString(5));
				bbs.setEmail(rs.getString(6));
				list.add(bbs);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
    
    public int modify(String title, String content, int article_id) {
    	StringBuffer br = new StringBuffer();
		br.append("UPDATE Community ");
		br.append("SET title = ?, content=?");
		br.append("WHERE article_id = ? ");
		try {
			 String sql = br.toString();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, title);
			 pstmt.setString(2, content);
			 pstmt.setInt(3, article_id);
			 return pstmt.executeUpdate();
    }catch (Exception e) {
        e.printStackTrace();
    } 
		return -1;
    
 
}

    public Community getCommunity(int article_id) {
		String sql = "select * from Community where article_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Community bbs = new Community();
				bbs.setArticle_id(rs.getInt(1));
				bbs.setLikes(rs.getInt(2));
				bbs.setView_cnt(rs.getInt(3));
				bbs.setTitle(rs.getString(4));
				bbs.setContent(rs.getString(5));
				bbs.setEmail(rs.getString(6));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
    
    public Date getDate(int article_id) {
    	String sql = "select dates from Writes where article_id = ? ";
    	Date dt = null;
    	try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getDate(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
    }
    
    public void setViewCnt(int article_id) {
  		StringBuffer br = new StringBuffer();
  		br.append("UPDATE Community ");
  		br.append(" SET views = views + 1");
  		br.append(" WHERE article_id = ? ");
  		try {
  			 String sql = br.toString();
  			 PreparedStatement pstm = conn.prepareStatement(sql);
  			 pstm.setInt(1, article_id); 
  			 pstm.executeUpdate();
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
    }
    
    public void setLikes(int article_id) {
  		StringBuffer br = new StringBuffer();
  		br.append("UPDATE Community ");
  		br.append(" SET likes = likes + 1");
  		br.append(" WHERE article_id = ? ");
  		try {
  			 String sql = br.toString();
  			 PreparedStatement pstm = conn.prepareStatement(sql);
  			 pstm.setInt(1, article_id); 
  			 pstm.executeUpdate();
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
    }
   
}

