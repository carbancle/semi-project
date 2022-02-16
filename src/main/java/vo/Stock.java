package vo;

public class Stock {
	
	private int no;
	private int productNo;
	private int size;
	private int stock;

	public Stock() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}


	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	@Override
	public String toString() {
		return "Stock [no=" + no + ", productNo=" + productNo + ", size=" + size + ", stock=" + stock + "]";
	}
	
	
}
