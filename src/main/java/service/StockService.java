package service;

import java.sql.SQLException;

import dao.StockDao;
import vo.Stock;

//재고량 변경 메소드
public class StockService {

	public void UpdateStockAmount(int productDetailNo, int stockAmount) throws SQLException {
		
		StockDao stockDao = StockDao.getInstance();
		Stock stock = stockDao.selectStockByProductDetailNo(productDetailNo);
		stock.setStock(stockAmount);		
		stockDao.updateStock(stock);
	
	}
	
}
