package shoe;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import community.Community;
import user.User;

public class ShoeDAO {
	private Connection conn;            // DB에 접근하는 객체
    private PreparedStatement pstmt;    // 
    private ResultSet rs;                // DB data를 담을 수 있는 객체  (Ctrl + shift + 'o') -> auto import
    private static ShoeDAO instance;
    
    public ShoeDAO(){
        try {
            String dbURL = "jdbc:mariadb://localhost:3306/shoe_db";
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
		String dbURL = "jdbc:mariadb://localhost:3306/shoe_db";
        String dbID = "grader";
        String dbPassword = "allowme";
		try {
			//드라이버 로드
			Class.forName("com.mariadb.jdbc.Driver");
			//커넥션 가져오기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		} catch(SQLException se) {
			se.printStackTrace();
		}
		return conn;
	}
    
    public static ShoeDAO getInstance() {
    	if(instance == null)
    		instance = new ShoeDAO();
    	return instance;
    }
    
    public String getNext() {
    	String sql = "SELECT upload_id FROM Uploads ORDER BY upload_id DESC LIMIT 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String id = rs.getString(1);
				String[] part = id.split("(?<=\\D)(?=\\d)");
				int max = Integer.parseInt(part[1]);
				int ne = max+1;
				String next = "U" + ne; 
    	    	return next;
			}
			return "U1"; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null; //데이터베이스 오류
    }
    

    public String getLatestShoe() {
    	String SQL = "SELECT COUNT(*) FROM Shoe";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(SQL); 
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	int ne = rs.getInt(1)+1;
    	    	return "U" + ne;
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return "";
    	    }
    
    public String makeReceipt() {
    	String SQL = "SELECT receipt_num FROM Buys ORDER BY receipt_num DESC LIMIT 1";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(SQL); 
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String id = rs.getString(1);
				String[] part = id.split("(?<=\\D)(?=\\d)");
				int max = Integer.parseInt(part[1]);
				System.out.println(max);
    	    	return "B" + max+1;
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return "";
    	    }
    
    
    public Shoe getShoeinfo(String upload_id) {
    	Shoe info = null;
    	StringBuffer br = new StringBuffer();
		br.append("SELECT brand, shoe_name, color, quantity, sizes");
		br.append(" FROM Shoe");
		br.append(" WHERE upload_id = ?");
		try {
			String sql = br.toString();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, upload_id);
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 info = new Shoe();		
				 info.setBrand(rs.getString(1));
				 info.setShoe_name(rs.getString(2));
				 info.setColor(rs.getString(3));
				 info.setQuantity(rs.getInt(4));
				 info.setSizes(rs.getInt(5));
//				 info.setupload_id(rs.getString(7));
			 }
		}
		catch (Exception e) {
	        e.printStackTrace();
	    } 
		return info;
    }
    
    public int DeleteShoe(String upload_id) {
    	String sql = "DELETE Uploads, Shoe From Uploads INNER JOIN Shoe WHERE Uploads.upload_id = Shoe.upload_id and Uploads.upload_id = ?";
    		try {
    			PreparedStatement pstmt = conn.prepareStatement(sql);
    			pstmt.setString(1, upload_id);
    			return pstmt.executeUpdate();
    		}catch (Exception e) {
    			e.printStackTrace();
    		}
    		
    		return -1; //데이터베이스 오류
    }
    
    public ArrayList<Shoe> getUploadedShoeinfoByEmail(String email) {
    	String sql = " SELECT upload_id, brand, shoe_name, color, quantity, sizes FROM Shoe WHERE upload_id IN (SELECT upload_id from Uploads where email=?)";
    	ArrayList<Shoe> list = new ArrayList<Shoe>();
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, email);
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	Shoe s = new Shoe();
    	    	s.setBrand(rs.getString(2));
    	    	s.setShoe_name(rs.getString(3));
    	    	s.setColor(rs.getString(4));
    	    	s.setQuantity(rs.getInt(5));
    	    	s.setSizes(rs.getInt(6));
    	    	s.setUpload_id(rs.getString(1));
    	    	list.add(s);
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return list;
    	    }
    
    public ArrayList<Shoe> getShoeinfoByEmail(String email) {
    	String sql = " SELECT upload_id, brand, shoe_name, color, quantity, sizes FROM Shoe WHERE upload_id IN (SELECT upload_id from Buys where email=?)";
    	ArrayList<Shoe> list = new ArrayList<Shoe>();
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, email);
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	Shoe s = new Shoe();
    	    	s.setBrand(rs.getString(2));
    	    	s.setShoe_name(rs.getString(3));
    	    	s.setColor(rs.getString(4));
    	    	s.setQuantity(rs.getInt(5));
    	    	s.setSizes(rs.getInt(6));
    	    	s.setUpload_id(rs.getString(1));
    	    	list.add(s);
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return list;
    	    }
    
    public int insertbrand(String brand, String type) {
    	String sql = "insert INTO Brand values(?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			pstmt.setString(2, type);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
    
    public String findthetype(String type) {
    	String sql = "Select brand from Brand where type= ?";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, type);
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	String ne = null;
    	    	ne = rs.getString(1);
    	    	return ne;
    	    }
    	    
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return null;
    }
    
    public ArrayList<String> findthename(String brand) {
    	ArrayList<String> list = new ArrayList<String>();
    	String sql = "Select name from Brand_To_Name where brand= ?";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, brand);
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	String name= rs.getString(1);
    	    	list.add(name);
    	    }
    	    
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
    
    public ArrayList<String> findname() {
    	ArrayList<String> list = new ArrayList<String>();
    	String sql = "Select name from Brand_To_Name";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	String name= rs.getString(1);
    	    	list.add(name);
    	    }
    	    
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
    
    public ArrayList<String> findtype() {
    	ArrayList<String> list = new ArrayList<String>();
    	String sql = "Select type from Brand";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	String name= rs.getString(1);
    	    	list.add(name);
    	    }
    	    
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
    
    public ArrayList<String> findSize() {
    	ArrayList<String> list = new ArrayList<String>();
    	String sql = "Select sizes from Sizes";
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	String name= rs.getString(1);
    	    	list.add(name);
    	    }
    	    
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
    
    
    
    public ArrayList<String> findbrand(){
    	ArrayList<String> list = new ArrayList<String>();
    	String sql = "SELECT brand from Brand";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    rs = pstmt.executeQuery();
    	    while(rs.next()) {
    	    	String brand= rs.getString(1);
    	    	list.add(brand);
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return list;
    	    }
    
    public int sell(String brand, String name, String color, int quantity, int size, String address) {
    	String sql = "insert INTO Shoe values(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, getLatestShoe());
			pstmt.setString(2, brand);
			pstmt.setString(3, name);
			pstmt.setString(4, color);
			pstmt.setInt(5, quantity);
			pstmt.setInt(6, size);
			pstmt.setString(7, address);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
    
    public int sellPrice(String brand, String name, int price) {
    	String sql = "insert INTO Brand_To_Name values(?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			pstmt.setString(2, name);
			pstmt.setInt(3, price);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
    
    public int buy(String email, String uploadid) {
    	String sql = "insert INTO Buys values(?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, makeReceipt());
			pstmt.setDate(2, getDate());
			pstmt.setString(3, email);
			pstmt.setString(4, uploadid);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
    
    
    public ArrayList<Shoe> getList(){
    	String sql = "Select * from Shoe order by upload_id asc";
    	ArrayList<Shoe> list = new ArrayList<Shoe>();
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql);
    		rs = pstmt.executeQuery();
			while(rs.next()) {
				Shoe s = new Shoe();
				s.setUpload_id(rs.getString(1));
				s.setBrand(rs.getString(2));
				s.setShoe_name(rs.getString(3));
				s.setColor(rs.getString(4));
				s.setQuantity(rs.getInt(5));
				s.setSizes(rs.getInt(6));
				s.setpimg(rs.getString(7));
				list.add(s);
			}
    	}catch (Exception e) {
			e.printStackTrace();
		}
    	return list;
    }
    
    public String getPic(String brand, String name) {
    	String sql = "Select address from Shoe WHERE brand = ? and shoe_name = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, brand);
    	    pstmt.setString(2, name);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String shoeadd = rs.getString(1);
    	    	return shoeadd;
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return "";
    	    }
    public int add(String brand, String name, int price, String path) {
    	String sql = "INSERT INTO Brand_To_Name VALUES (?, ?, ?, ?)";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, brand);
    	    pstmt.setString(2, name);
    	    pstmt.setInt(3, price);
    	    pstmt.setString(4, path);
    	    rs = pstmt.executeQuery();
    	    return pstmt.executeUpdate();
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return -1;
    	    }
    
    public int getPrice(String brand, String name) {
    	String sql = "Select price from Brand_To_Name WHERE brand = ? and name = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, brand);
    	    pstmt.setString(2, name);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	return rs.getInt(1);
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	return -1;
    }
    


    
    public String getType(String brand) {
    	String sql = "Select type from Brand WHERE brand = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, brand);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String type = rs.getString(1);
    	    	return type;
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return "";
    	    }
    
    
    public String getGender(int sizes) {
    	String sql = "Select gender from Sizes WHERE sizes = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setInt(1, sizes);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String gender = rs.getString(1);
    	    	return gender;
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return "";
    	    }
    
    public String getUploader(String upload_id) {
    	String sql = "Select email from Uploads WHERE upload_id = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	
    	    	return rs.getString(1);
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return "";
    	    }
    
    public int getWishes(String upload_id) {
    	String sql = "SELECT COUNT( * ) from Wishes where upload_id = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	int wishes = rs.getInt(1);
    	    	return wishes;
    	    }

    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return -1;
    	    }
    
    public int getRatingNum(String upload_id) {
    	String sql = "SELECT COUNT( * ) from Rates where upload_id = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	int wishes = rs.getInt(1);
    	    	return wishes;
    	    }

    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return -1;
    	    }
    
    public int getUserWishes(String upload_id, String email) {
    	String sql = "SELECT COUNT( * ) AS COUNT from Wishes where upload_id = ? and email = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    pstmt.setString(2, email);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	int wishes = rs.getInt("COUNT");
    	    	return wishes;
    	    }

    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return -1;
    	    }
   
    public float getRating(String upload_id) {
    	String sql = "SELECT AVG(rating) from Rates where upload_id = ?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	float rating = rs.getFloat(1);
    	    	return rating;
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return -1;
    	    }
    
    public int getUserRating(String upload_id, String email) {
    	String sql = "SELECT rating from Rates where upload_id = ? and email=?";
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    pstmt.setString(2, email);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	int rating = rs.getInt(1);
    	    	return rating;
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return 0;
    	    }
    
    public ArrayList<String> getComment(String upload_id) {
    	String sql = "SELECT comment from Comments where upload_id = ?";
	    ArrayList<String> list = new ArrayList<String>();
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String comment = rs.getString(1);
    	    	list.add(comment);
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return list;
    	    }
    
    public ArrayList<String> getCommentDate(String upload_id) {
    	String sql = "SELECT date from Comments where upload_id = ?";
    	ArrayList<String> list = new ArrayList<String>();
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	Date dt = rs.getDate(1);
    	    	list.add(dt.toString());
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return list;
    	    }
    
    public ArrayList<String> getMyComment(String upload_id, String email) {
    	String sql = "SELECT comment from Comments where upload_id = ? and email=?";
	    ArrayList<String> list = new ArrayList<String>();
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    pstmt.setString(2, email);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String comment = rs.getString(1);
    	    	list.add(comment);
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return list;
    	    }
    
    public ArrayList<String> getMyCommentDate(String upload_id, String email) {
    	String sql = "SELECT date from Comments where upload_id = ? and email=?";
    	ArrayList<String> list = new ArrayList<String>();
    	try {
    	    PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    pstmt.setString(2, email);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	Date dt = rs.getDate(1);
    	    	list.add(dt.toString());
    	    }
    	    } catch(Exception e) {
    	    	e.printStackTrace();
    	    }
    	    return list;
    	    }
    
    

public Date getBuyDate(String shoeid, String email) {
	String sql = "select dates from Buys where upload_id = ? and email = ?";
	Date dt = null;
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, shoeid);
		pstmt.setString(2, email);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			dt = rs.getDate(1);
		}
		return dt;
	}catch (Exception e) {
		e.printStackTrace();
	}
	return null;
	
}
	
	public Date getSellDate(String shoeid, String email) {
		String sql = "select dates from Uploads where upload_id = ? and email = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, shoeid);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getDate(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
}

	public ArrayList<String> getUploadid(String email) {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "SELECT upload_id from Uploads where email = ?";
		try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, email);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String upload = rs.getString(1);
    	    	list.add(upload);
    	    	
    	    }
	  } catch(Exception e) {
	    	e.printStackTrace();
	    }
		return list;
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
	
	public void setWishes(String upload_id, String email) {
		String sql = "INSERT INTO Wishes VALUES (?, ?, ?)";
  		try {
  			 PreparedStatement pstm = conn.prepareStatement(sql);
  			 pstm.setString(1, upload_id);
  			pstm.setString(2, email);
  			pstm.setDate(3, getDate());
  			 pstm.executeUpdate();
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
    }
	
	public void unsetWishes(String email, String upload_id) {
		StringBuffer br = new StringBuffer();
		br.append("DELETE FROM Wishes WHERE email = ? and upload_id = ?");
  		try {
  			 String sql = br.toString();
  			 PreparedStatement pstm = conn.prepareStatement(sql);
  			 pstm.setString(1, email);
  			 pstm.setString(2, upload_id);
  			 pstm.executeUpdate();
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
    }
	
	public int deleteComment(String email, String upload_id) {
		StringBuffer br = new StringBuffer();
		br.append("DELETE FROM Comments WHERE email = ? and upload_id = ?");
  		try {
  			 String sql = br.toString();
  			 PreparedStatement pstm = conn.prepareStatement(sql);
  			 pstm.setString(1, email);
  			 pstm.setString(2, upload_id);
  			 return pstm.executeUpdate();
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
  		return -1;
    }
	
	public void updateRating(String email, String upload_id, int rating) {
		StringBuffer br = new StringBuffer();
		br.append("Update Rates set rating=? WHERE email = ? and upload_id = ?");
  		try {
  			 String sql = br.toString();
  			 PreparedStatement pstm = conn.prepareStatement(sql);
  			 pstm.setInt(1, rating);
  			 pstm.setString(2, email);
  			 pstm.setString(3, upload_id);
  			 pstm.executeUpdate();
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
  		
	}
	
	public void setRating(String email, String upload_id, int rating) {
		StringBuffer br = new StringBuffer();
		br.append("INSERT INTO Rates VALUES (?,?,?)");
  		try {
  			 String sql = br.toString();
  			 PreparedStatement pstm = conn.prepareStatement(sql);
  			 pstm.setString(1, email);
  			 pstm.setString(2, upload_id);
  			pstm.setInt(3, rating);
  			 pstm.executeUpdate();
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
	}
	
	public ArrayList<String> getComments(String upload_id){
		String sql =  " SELECT comment, dates FROM Comments WHERE upload_id =? ";
    	ArrayList<String> list = new ArrayList<String>();
    	try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	ArrayList<String> nlist = new ArrayList<String>();
    	    	String com = null;
    	    	String date = null;
    	    	com = rs.getString(1);
    	    	date = rs.getDate(2).toString();
    	    	nlist.add(com);
    	    	nlist.add(date);
    	    	list.addAll(nlist);
    	    	System.out.println(list);
    	    }
	  } catch(Exception e) {
	    	e.printStackTrace();
	    }
    	return list;
	}
	
	public int InsertIntoComment(String upload_id, String email, String comment) {
		String sql = "insert into Comments values(?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
    	    pstmt.setString(1, email);
    	    pstmt.setString(2, upload_id);
    	    pstmt.setDate(3, getDate());
    	    pstmt.setString(4, comment);
    	    return pstmt.executeUpdate();
		}catch (Exception e) {
    	 	e.printStackTrace();
    	  }
    	  return -1;

	}
	
	public String getEmail(String upload_id) {
		String sql = "select email from Uploads where upload_id = ?";
		try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, upload_id);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String email = rs.getString(1);
    	    	return email;
    	    }
	  } catch(Exception e) {
	    	e.printStackTrace();
	    }
    	return "";
	}
	
	public ArrayList<String> FindShoeColor(String name, String brand) {
		ArrayList<String> list = new ArrayList<String>();
		String sql = "SELECT color from shoe where shoe_name = ? and brand = ?";
		try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, name);
    	    pstmt.setString(2, brand);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	String color = rs.getString(1);
    	    	list.add(color);
    	    	
    	    }
	  } catch(Exception e) {
	    	e.printStackTrace();
	    }
		return list;
	}
	
	public ArrayList<Integer> FindShoeSizes(String name, String brand) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		String sql = "SELECT sizes from shoe where name = ? and brand = ?";
		try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, name);
    	    pstmt.setString(2, brand);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	int color = rs.getInt(1);
    	    	list.add(color);
    	    	
    	    }
	  } catch(Exception e) {
	    	e.printStackTrace();
	    }
		return list;
	}
	
	public int FindShoePrice(String name, String brand) {
		String sql = "SELECT price from Brand_To_Name where name = ? and brand = ?";
		try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, name);
    	    pstmt.setString(2, brand);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	return rs.getInt(1);
    	    	
    	    }
	  } catch(Exception e) {
	    	e.printStackTrace();
	    }
		return 0;
	}

	public Shoe findPerfectMatch(String brand, String name, String color, int sizes, int price) {
		String sql = "SELECT * from Shoe where brand = ?, shoe_name = ?, color = ?, sizes = ? and price = ?";
		Shoe s = new Shoe();
		try {
    		PreparedStatement pstmt = conn.prepareStatement(sql); 
    	    pstmt.setString(1, brand);
    	    pstmt.setString(2, name);
    	    pstmt.setString(3, color);
    	    pstmt.setInt(4, sizes);
    	    pstmt.setInt(5, price);
    	    rs = pstmt.executeQuery();
    	    if(rs.next()) {
    	    	s.setBrand(rs.getString(1));
    	    	s.setShoe_name(rs.getString(2));
    	    	s.setColor(rs.getString(3));
    	    	s.setSizes(rs.getInt(4));
    	    	s.setPrice(rs.getInt(5));
    	    }
	  } catch(Exception e) {
	    	e.printStackTrace();
	    }
		return s;
	}
	
	public int upload(String id) {
		String sql = "insert INTO Uploads VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, getNext());
			pstmt.setString(2, id);
			pstmt.setDate(3, getDate());
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
}
	
	
	
}

    

