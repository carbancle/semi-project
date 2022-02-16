
package dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.CartDetailDto;
import vo.Cart;

public class CartDao {
	
	private static CartDao self = new CartDao();
	private CartDao() {}
	public static CartDao getInstance() {
		return self;
	}
	

	/**
	 * 회원 번호로 장바구니 수량을 조회한다.
	 * @param memberNo 회원 번호
	 * @return 장바구니 수량
	 * @throws SQLException
	 */
	public int selectCartCountbymemberNo(int memberNo) throws SQLException {
	      String sql = "select count(*) cnt "
	            + "from tb_carts "
	            + "where member_no = ? ";
	            
	      int totalRecords = 0;
	      
	      Connection connection = getConnection();
	      PreparedStatement pstmt = connection.prepareStatement(sql);
	      pstmt.setInt(1, memberNo);
	      ResultSet rs = pstmt.executeQuery();
	      rs.next();
	      totalRecords = rs.getInt("cnt");

	      return totalRecords;
	      
	   }
	
	/**
	 * 장바구니 번호를 조회하여 해당 장바구니 정보를 삭제한다.
	 * @param no 장바구니 번호
	 * @throws SQLException
	 */
	public void deletedCartByNo(int no) throws SQLException{
		
		String sql = "delete tb_carts "
				   + "where cart_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 장바구니 번호로 장바구니 갯수를 조회하여 장바구니 갯수를 변경한다.
	 * @param cart
	 * @throws SQLException
	 */
	public void updateCartAmountByNo(Cart cart) throws SQLException {
		
		String sql = "update tb_carts "
				   + "set "
				   + "	product_amount = ? "
				   + "where "
				   + "	cart_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, cart.getAmount());
		pstmt.setInt(2, cart.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 제품상세정보로 장바구니 갯수을 조회하여, 장바구니 갯수를 변경한다. 
	 * @param cart
	 * @throws SQLException
	 */
	public void updateCartAmountByDetailNo(Cart cart) throws SQLException {
		
		String sql = "update tb_carts "
				   + "set "
				   + "	product_amount = ? "
				   + "where "
				   + "	product_detail_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, cart.getAmount());
		pstmt.setInt(2, cart.getStockNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 장바구니 버튼을 클릭시 장바구니 정보를 DB에 저장한다.
	 * @param cart 장바구니 정보
	 * @throws SQLException
	 */
	public void insertCartInfo(Cart cart) throws SQLException {
		
		String sql = "insert into tb_carts(cart_no, member_no, product_detail_no, product_amount) "
				   + "values(cart_no_seq.nextval, ?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, cart.getMemberNo());
		pstmt.setInt(2, cart.getStockNo());
		pstmt.setInt(3, cart.getAmount());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	
	/**
	 * 장바구니 목록을 불러온다.
	 * @return 해당 장바구니 정보
	 * @throws SQLException
	 */
	public List<Cart> selectAllCartListByMemberNo(int no) throws SQLException {
		
		String sql = "select cart_no, member_no, product_detail_no, product_amount "
				   + "from tb_carts "
				   + "where member_no = ? ";
		
		List<Cart> carts = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Cart cartDetail = new Cart();
			
			cartDetail.setNo(rs.getInt("cart_no"));
			cartDetail.setStockNo(rs.getInt("product_detail_no"));;
			cartDetail.setAmount(rs.getInt("product_amount"));
			cartDetail.setMemberNo(rs.getInt("member_no"));
			
			carts.add(cartDetail);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return carts;
	}
	
	/**
	 * 장바구니 번호를 통해 장바구니 상세정보를 반환한다.
	 * @param no 장바구니 번호
	 * @return 해당 장바구니 정보
	 * @throws SQLException
	 */
	public CartDetailDto selectCartByNo(int no) throws SQLException {
		
		String sql = "select C.cart_no, C.product_amount, C.member_no, "
				   + "P.product_name, P.product_img, P.product_brand, P.product_price, P.product_disprice, "
				   + "S.product_detail_no, S.product_size, S.product_stock "
				   + "from tb_carts C, tb_products P, tb_product_stocks S, tb_members M "
				   + "where C.product_detail_no = S.product_detail_no and P.product_no = S.product_no and C.member_no = M.member_no "
				   + "and C.cart_no = ? ";
		
		CartDetailDto cartDetail = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			cartDetail = new CartDetailDto();
			
			cartDetail.setNo(rs.getInt("cart_no"));
			cartDetail.setAmount(rs.getInt("product_amount"));
			cartDetail.setMemberNo(rs.getInt("member_no"));
			cartDetail.setStockNo(rs.getInt("product_detail_no"));
			cartDetail.setProductName(rs.getString("product_name"));
			cartDetail.setProductImg(rs.getString("product_img"));
			cartDetail.setProductBrand(rs.getString("product_brand"));
			cartDetail.setProductPrice(rs.getInt("product_price"));
			cartDetail.setProductDisprice(rs.getInt("product_disprice"));
			cartDetail.setProductSize(rs.getInt("product_size"));
			cartDetail.setProductStock(rs.getInt("product_stock"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return cartDetail;
	}
	
	/**
	 * 회원 번호를 통해 장바구니 정보를 반환한다.
	 * @param no 회원 번호
	 * @return 해당 장바구니 정보
	 * @throws SQLException
	 */
	public List<CartDetailDto> selectCartList(int memberNo) throws SQLException {
		
		String sql = "select C.cart_no, C.product_amount, C.member_no, "
				   + "P.product_name, P.product_img, P.product_brand, P.product_price, P.product_disprice, "
				   + "S.product_detail_no, S.product_size, S.product_stock "
				   + "from tb_carts C, tb_products P, tb_product_stocks S, tb_members M "
				   + "where C.product_detail_no = S.product_detail_no and P.product_no = S.product_no and C.member_no = M.member_no "
				   + "and C.member_no = ? ";
		
		List<CartDetailDto> carts = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, memberNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			CartDetailDto cartDetail = new CartDetailDto();
			
			cartDetail.setNo(rs.getInt("cart_no"));
			cartDetail.setAmount(rs.getInt("product_amount"));
			cartDetail.setMemberNo(rs.getInt("member_no"));
			cartDetail.setStockNo(rs.getInt("product_detail_no"));
			cartDetail.setProductName(rs.getString("product_name"));
			cartDetail.setProductImg(rs.getString("product_img"));
			cartDetail.setProductBrand(rs.getString("product_brand"));
			cartDetail.setProductPrice(rs.getInt("product_price"));
			cartDetail.setProductDisprice(rs.getInt("product_disprice"));
			cartDetail.setProductSize(rs.getInt("product_size"));
			cartDetail.setProductStock(rs.getInt("product_stock"));
			
			carts.add(cartDetail);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return carts;
	}
	
}

