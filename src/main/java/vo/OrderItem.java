package vo;

public class OrderItem {

	private int orderNo;
	private int stockNo;
	private int amount;
	private String reviewStatus;
	
	public OrderItem() {}

	
	public String getReviewStatus() {
		return reviewStatus;
	}


	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}


	public int getOrderNo() {
		return orderNo;
	}


	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}


	public int getStockNo() {
		return stockNo;
	}


	public void setStockNo(int stockNo) {
		this.stockNo = stockNo;
	}


	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
}
