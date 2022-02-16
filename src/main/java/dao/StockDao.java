package dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Product;
import vo.Stock;

public class StockDao {

	private static StockDao self = new StockDao();
	private StockDao() {}
	public static StockDao getInstance() {
		return self;
	}
	
	
	public int selectTotalstocksCount() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from tb_product_stocks";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	
	public List<Stock> selectStocksbyProductNo(int no) throws SQLException{
		 List<Stock> stockList = new ArrayList<>();
			
		 String sql = "select product_no, product_detail_no, "
		 			+ "product_size, product_stock "
				   + "from tb_product_stocks "
				   + "where product_no = ? ";
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Stock stock = new Stock();
				stock.setNo(rs.getInt("product_detail_no"));
				stock.setProductNo(rs.getInt("product_no"));
				stock.setSize(rs.getInt("product_size"));
				stock.setStock(rs.getInt("product_stock"));
				
				stockList.add(stock);
			}
			
			rs.close();
			pstmt.close();
			connection.close();
			
			return stockList;
		}
	public Stock selectStockByProductDetailNo(int productDetailNo) throws SQLException {
		String sql = "select product_no, product_detail_no, "
	 			+ "product_size, product_stock "
			   + "from tb_product_stocks "
			   + "where product_detail_no = ? ";
		Stock stock = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productDetailNo);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			stock = new Stock();
			stock.setNo(rs.getInt("product_detail_no"));
			stock.setProductNo(rs.getInt("product_no"));
			stock.setSize(rs.getInt("product_size"));
			stock.setStock(rs.getInt("product_stock"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return stock;
	}
	
	
	/**
	 * productNo와 size로 product_detail_no를 반환한다
	 * @param no
	 * @param size
	 * @return
	 * @throws SQLException
	 */
	public int selectStockNoByProductNoAndSize(int no, int size) throws SQLException {
		int stockNo = 0;
		
		String sql = "select product_detail_no "
				   + "from tb_product_stocks "
				   + "where product_no = ? and product_size = ? ";
		
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.setInt(2, size);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) { 
				stockNo = rs.getInt("product_detail_no");
			}
			
			rs.close();
			pstmt.close();
			connection.close();
		
		return stockNo;
	}
	
	public void updateStock(Stock stock) throws SQLException {
		String sql = "update tb_product_stocks "
				   + "set "
				   + "	product_stock = ? "
				   + "where product_detail_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, stock.getStock());
		pstmt.setInt(2, stock.getNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
			
	public int selectStockbyProductNoAndSize(int no, int size) throws SQLException{
		 int amount = 0;
			
		 String sql = "select product_stock "
				   + "from tb_product_stocks "
				   + "where product_no = ? and product_size = ? ";
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.setInt(2, size);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) { amount = rs.getInt("product_stock");}
			
			rs.close();
			pstmt.close();
			connection.close();
			
			return amount;
		}
	
	public void insertstock(int no, int size, int amount) throws SQLException {
		String sql = "insert into tb_product_stocks "
				+ "(product_detail_no, product_no, product_size, product_stock ) "
				+ "values(PRODUCT_DETAIL_NO.nextval, ?, ?, ?) ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.setInt(2, size);
		pstmt.setInt(3, amount);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	
			
	}
	
	

