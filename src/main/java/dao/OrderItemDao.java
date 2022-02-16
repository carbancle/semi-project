package dao;
import static utils.ConnectionUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.OrderItem;

public class OrderItemDao {

	private static OrderItemDao self = new OrderItemDao();
	private OrderItemDao() {};
	
	public static OrderItemDao getInstance() {
		return self;
	}
	
	/**
	 * 주문정보를 테이블에 저장한다.
	 * @param orderItem
	 * @throws SQLException
	 */
	public void insertOrderItem(OrderItem orderItem) throws SQLException{
		String sql = "insert into tb_order_item (order_no, product_detail_no, product_amount) "
				   + "values (?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, orderItem.getOrderNo());
		pstmt.setInt(2, orderItem.getStockNo());
		pstmt.setInt(3, orderItem.getAmount());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 주문정보를 받아 정보를 테이블에 반영한다.
	 * @param orderItem
	 * @throws SQLException
	 */
	public void updateOrderItem(OrderItem orderItem) throws SQLException {
		String sql = "update tb_order_item "
				   + "set "
				   + "	product_amount = ? "
				   + "  review_status = ? "
				   + "where order_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, orderItem.getAmount());
		pstmt.setString(2, orderItem.getReviewStatus());
		pstmt.setInt(3, orderItem.getOrderNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	/**
	 * 주문번호와 재고번호로 주문아이템을 찾아 리뷰등록시 등록으로 변경한다.
	 * @param orderNo
	 * @param stockNo
	 * @throws SQLException
	 */
	public void updateReviewStatusByOrderNoStockNo(OrderItem orderItem) throws SQLException {
		String sql = "update tb_order_item "
				+ "set "
				+ "  review_status = 'Y' "
				+ "where order_no = ? "
				+ "and product_detail_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, orderItem.getOrderNo());
		pstmt.setInt(2, orderItem.getStockNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	
}

