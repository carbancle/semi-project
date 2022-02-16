package dto;

import java.util.Date;

public class ProductDetailDto {

	private int productStockNo;
	private int productNo;
	private String category;
	private String name;
	private int price;
	private int disPrice;
	private String photo;
	private String brand;
	private String gender;
	private Date createdDate;
	private int size;
	private int stock;
	
	public ProductDetailDto() {}

	public int getProductStockNo() {
		return productStockNo;
	}

	public void setProductStockNo(int productDetailNo) {
		this.productStockNo = productDetailNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
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
	
	
	
	
}
