package vo;

import java.util.Date;

public class Member {

	private int no;
	private String name;
	private String id;
	private String pwd;
	private String email;
	private String tel;
	private String address;
	private int pct;
	private Date registeredDate;
	private Date deletedDate;
	private String deleted;
	
	public Member() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getPct() {
		return pct;
	}

	public void setPct(int pct) {
		this.pct = pct;
	}

	public Date getRegisteredDate() {
		return registeredDate;
	}

	public void setRegisteredDate(Date registeredDate) {
		this.registeredDate = registeredDate;
	}

	public Date getDeletedDate() {
		return deletedDate;
	}

	public void setDeletedDate(Date deletedDate) {
		this.deletedDate = deletedDate;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	@Override
	public String toString() {
		return "Member [no=" + no + ", name=" + name + ", id=" + id + ", pwd=" + pwd + ", email=" + email + ", tel="
				+ tel + ", address=" + address + ", pct=" + pct + ", registeredDate=" + registeredDate
				+ ", deletedDate=" + deletedDate + ", deleted=" + deleted + "]";
	}
	
	
}
