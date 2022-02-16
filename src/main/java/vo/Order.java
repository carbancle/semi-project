package vo;


import java.util.Date;


public class Order {

	private int no;
	private int memberNo;
	private String status; //주문상태
	private Date orderDate;
	private int totalPrice;
	private String cancelReason;
	private String cancelStatus;
	private Date canceledDate;
	
	
	public Order() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getMemberNo() {
		return memberNo;
	}
	
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public String getCancelStatus() {
		return cancelStatus;
	}

	public void setCancelStatus(String cancelStatus) {
		this.cancelStatus = cancelStatus;
	}

	public Date getCanceledDate() {
		return canceledDate;
	}

	public void setCanceledDate(Date canceledDate) {
		this.canceledDate = canceledDate;
	}


	@Override
	public String toString() {
		return "Order [no=" + no + ", memberNo=" + memberNo + ", status=" + status + ", orderDate=" + orderDate
				+ ", totalPrice=" + totalPrice + ", cancelReason=" + cancelReason + ", cancelStatus=" + cancelStatus
				+ ", canceledDate=" + canceledDate + "]";
	}

}
