package service;

import java.sql.SQLException;

import dao.ProductDao;
import dao.StockDao;
import form.NewProductForm;
import vo.Product;

public class ProductRegisterService {

	public void registerNewProduct(NewProductForm newProductForm) throws SQLException {	
		ProductDao productDao = ProductDao.getInstance();	
		StockDao stockDao = StockDao.getInstance();	
	
		//1. jsp에서 NewProductForm으로 새로운 객체를 받는다.
	
		//2. 시퀀스 메소드로 productNo하나를 받는다.
		int productNo = productDao.getProductNo();
	
		//3. 프로덕트는 객체로 만들어서 저장하고, 스톡은 insertstock(int no, int size, int amount)로 바로 저장한다.
		Product product = new Product();
		product.setNo(productNo);
		product.setCategory(newProductForm.getCategory());
		product.setBrand(newProductForm.getBrand());
		product.setName(newProductForm.getName());
		product.setGender(newProductForm.getGender());
		product.setPhoto(newProductForm.getPhoto());
		product.setPrice(newProductForm.getPrice());
		product.setDisPrice(newProductForm.getDisPrice());
		productDao.insertProduct(product);
		
		stockDao.insertstock(productNo, 230, newProductForm.getStock230());
		stockDao.insertstock(productNo, 240, newProductForm.getStock240());
		stockDao.insertstock(productNo, 250, newProductForm.getStock250());
		stockDao.insertstock(productNo, 260, newProductForm.getStock260());
		stockDao.insertstock(productNo, 270, newProductForm.getStock270());
		stockDao.insertstock(productNo, 280, newProductForm.getStock280());
		stockDao.insertstock(productNo, 290, newProductForm.getStock290());
		
		
	}
}
