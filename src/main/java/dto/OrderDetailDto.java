package dto;

import java.util.Date;

import vo.Member;
import vo.Stock;

public class OrderDetailDto {
//주문/주문아이템/프로덕트/ 조인
	
	private int orderNo; //주문번호
    private String status; //주문상태
    private Date orderDate; //주문날짜
    private int totalPrice; //총액
    private String reviewStatus; //리뷰상태
    private String cancelReason;
	private String cancelStatus;
	private Date canceledDate;
   
    private int memberNo;   //회원번호
    private String memberId;  //회원아이디
    private String memberName;  //회원이름
   
    private int productDetailNo; //상품상세번호 //orderitemjoin
    private int size; //상품 사이즈
    private int amount; //주문갯수
   
    private int productNo; //상품번호 //product.no = stock테이블에 있는 product.no
    private String productName; //상품이름
    private String category; //상품 카테고리
    private int price; //가격
    private int disPrice; //할인가격
    private String photo;
    private String brand;
    private String gender;
   
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
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
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
	public String getReviewStatus() {
		return reviewStatus;
	}
	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getProductDetailNo() {
		return productDetailNo;
	}
	public void setProductDetailNo(int productDetailNo) {
		this.productDetailNo = productDetailNo;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDisPrice() {
		return disPrice;
	}
	public void setDisPrice(int disPrice) {
		this.disPrice = disPrice;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	@Override
	public String toString() {
		return "OrderDetailDto [orderNo=" + orderNo + ", status=" + status + ", orderDate=" + orderDate
				+ ", totalPrice=" + totalPrice + ", reviewStatus=" + reviewStatus + ", memberNo=" + memberNo
				+ ", memberId=" + memberId + ", memberName=" + memberName + ", productDetailNo=" + productDetailNo
				+ ", size=" + size + ", amount=" + amount + ", productNo=" + productNo + ", productName=" + productName
				+ ", category=" + category + ", price=" + price + ", disPrice=" + disPrice + ", photo=" + photo
				+ ", brand=" + brand + ", gender=" + gender + "]";
	}
}
