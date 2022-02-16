package dto;

public class CartDetailDto {

	private int no;					// 장바구니 번호
	private int amount;				// 장바구니 수량
	private int memberNo;			// 회원 번호
	private int stockNo;			// 상품 번호
	private String productName;		// 상품 이름
	private String productImg;		// 상품 이미지
	private String productBrand;	// 상품 제조회사
	private int productPrice;		// 상품 가격
	private int productDisprice;	// 상품 할인가격
	private int productStock;		// 상품 재고량
	private int productSize;		// 상품 사이즈
	
	public CartDetailDto() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getStockNo() {
		return stockNo;
	}

	public void setStockNo(int stockNo) {
		this.stockNo = stockNo;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductImg() {
		return productImg;
	}

	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}


	public String getProductBrand() {
		return productBrand;
	}

	public void setProductBrand(String productBrand) {
		this.productBrand = productBrand;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductDisprice() {
		return productDisprice;
	}

	public void setProductDisprice(int productDisprice) {
		this.productDisprice = productDisprice;
	}

	public int getProductStock() {
		return productStock;
	}

	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}

	public int getProductSize() {
		return productSize;
	}

	public void setProductSize(int productSize) {
		this.productSize = productSize;
	}

	
}
