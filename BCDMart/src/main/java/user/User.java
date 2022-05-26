package user;

import java.sql.Date;

public class User {

	private String email;
	private String nickname;
	private String first_name;
	private String last_name;
	private Integer cell_num;
	private String district;
	private int balance;
	private String password;
	private String gender;
	private Date joindate;
	

	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	
	public String getDistrict() {
		return district;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public Integer getCell_num() {
		return cell_num;
	}
	public void setCell_num(Integer cell_num) {
		this.cell_num = cell_num;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public Date getJoindate() {
		return joindate;
	}
	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}


	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
}
