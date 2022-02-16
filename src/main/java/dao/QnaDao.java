package dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dto.QnADetailDto;
import vo.Criteria2;
import vo.Member;
import vo.Order;
import vo.QnA;

public class QnaDao {

	
	private static QnaDao self = new QnaDao();
	private QnaDao() {}
	public static QnaDao getInstance() {
		return self;
	}
	
	
	
	/**
	 * 
	 * @return 전체 QnA 수
	 * @throws SQLException
	 */
	public int selectAnsweredQnACount() throws SQLException {
		int count = 0;
		
		String sql = "select count(*) cnt "
				+ "from tb_qna "
				+ "where question_answered = 'Y'  ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		count = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return count;
	}
	
	/**
	 * 
	 * @return 전체 QnA 수
	 * @throws SQLException
	 */
	public int selectAllQnACount() throws SQLException {
		int count = 0;
		
		String sql = "select count(*) cnt "
				+ "from tb_qna ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		count = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return count;
	}
	
	
	
	/**
	 * 
	 * @return 오늘 등록된 QnA 수
	 * @throws SQLException
	 */
	public int selectTodayQnACount() throws SQLException {
		int count = 0;
		
		String sql = "select count(*) cnt "
				+ "from tb_qna "
				+ "where question_date >= TRUNC(SYSDATE) "
				+ "AND question_date < TRUNC(SYSDATE) + 1";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		count = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return count;
	}
	
	
	
	public List<QnADetailDto> selectQnADetailNotAnswered()  throws SQLException {
		String sql = "select q.question_no, q.product_no, q.member_no, q.question_title, "
				+ "q.question_content, q.question_date, "
				+ "q.question_answered, q.answer_content, q.answer_date, "
				+ "m.member_name, m.member_id, "
				+ "p.product_name, p.product_img "
				+ "from tb_qna q, tb_members m, tb_products p "
				+ "where q.member_no = m.member_no "
				+ "and p.product_no = q.product_no "
				+ "and q.question_answered = 'N'  "
				+ "order by q.question_no desc ";
		
		List<QnADetailDto> qnADetailList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			QnADetailDto qnADetail = new QnADetailDto();

			qnADetail.setProductNo(rs.getInt("product_no"));
			qnADetail.setMemberNo(rs.getInt("member_no"));
			qnADetail.setMemberId(rs.getString("member_id"));
			qnADetail.setQnANo(rs.getInt("question_no"));
			qnADetail.setMemberName(rs.getString("member_name"));
			qnADetail.setTitle(rs.getString("question_title"));
			qnADetail.setQuestionContent(rs.getString("question_content"));
			qnADetail.setAnswerContent(rs.getString("answer_content"));
			qnADetail.setQuestionAnswered(rs.getString("question_answered"));
			qnADetail.setQuestionDate(rs.getDate("question_date"));
			qnADetail.setAnswerDate(rs.getDate("answer_date"));
			qnADetail.setPhoto(rs.getString("product_img"));
			qnADetail.setProductName(rs.getString("product_name"));
			
			qnADetailList.add(qnADetail);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return qnADetailList;
	}
	
	
	public int selectQnACountByMemberNo(int memberNo) throws SQLException {
		String sql = "select count(*) cnt from tb_qna where member_no = ? ";
		int count = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, memberNo);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		count = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return count;
	}
	
	public QnADetailDto selectQnADetailByQnANo(int QnANo)  throws SQLException {
		String sql = "q.question_no, q.product_no, q.member_no, q.question_title, "
				+ "q.question_content, q.question_date, "
				+ "q.question_answered, q.answer_content, q.answer_date, "
				+ "m.member_name, m.member_id, "
				+ "p.product_name, p.product_img "
				+ "from tb_qna q, tb_members m, tb_products p "
				+ "where q.member_no = m.member_no "
				+ "and p.product_no = q.product_no "
				+ "where question_no = ? ";
		
		QnADetailDto qnADetail = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, QnANo);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			qnADetail = new QnADetailDto();
			qnADetail.setProductNo(rs.getInt("product_no"));
			qnADetail.setMemberNo(rs.getInt("member_no"));
			qnADetail.setMemberId(rs.getString("member_id"));
			qnADetail.setQnANo(rs.getInt("question_no"));
			qnADetail.setMemberName(rs.getString("member_name"));
			qnADetail.setTitle(rs.getString("question_title"));
			qnADetail.setQuestionContent(rs.getString("question_content"));
			qnADetail.setAnswerContent(rs.getString("answer_content"));
			qnADetail.setQuestionAnswered(rs.getString("question_answered"));
			qnADetail.setQuestionDate(rs.getDate("question_date"));
			qnADetail.setAnswerDate(rs.getDate("answer_date"));
			qnADetail.setPhoto(rs.getString("product_img"));
			qnADetail.setProductName(rs.getString("product_name"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return qnADetail;
		}
	
	public List<QnADetailDto> selectQnAListByProductNo(int begin, int end, int productNo) throws SQLException{
		String sql = "select question_no, product_no, member_no, question_title, question_content, "
	            + "question_date, question_answered, answer_content, "
	            + "answer_date, member_name, member_id, product_name, product_img "
	            + "    from (select row_number() over (order by q.question_date desc) rn, q.question_no, "
	            + "    q.product_no, q.member_no, q.question_title, q.question_content, q.question_date, "
	            + "    q. question_answered, q.answer_content, q.answer_date, m.member_name, m.member_id, "
	            + "    p.product_name, p.product_img "
	            + "    from tb_qna q, tb_members m, tb_products p "
	            + "    where q.member_no = m.member_no "
	            + "    and p.product_no = q.product_no) "
	            + "where rn >= ? and rn <= ? "
	            + "and product_no = ? "
	            + "order by question_date desc ";
					
		
		List<QnADetailDto> qnADetailList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		pstmt.setInt(3, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			QnADetailDto qnADetail = new QnADetailDto();

			qnADetail.setProductNo(rs.getInt("product_no"));
			qnADetail.setMemberNo(rs.getInt("member_no"));
			qnADetail.setMemberId(rs.getString("member_id"));
			qnADetail.setQnANo(rs.getInt("question_no"));
			qnADetail.setMemberName(rs.getString("member_name"));
			qnADetail.setTitle(rs.getString("question_title"));
			qnADetail.setQuestionContent(rs.getString("question_content"));
			qnADetail.setAnswerContent(rs.getString("answer_content"));
			qnADetail.setQuestionAnswered(rs.getString("question_answered"));
			qnADetail.setQuestionDate(rs.getDate("question_date"));
			qnADetail.setAnswerDate(rs.getDate("answer_date"));
			qnADetail.setPhoto(rs.getString("product_img"));
			qnADetail.setProductName(rs.getString("product_name"));
			
			qnADetailList.add(qnADetail);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return qnADetailList;
	}
	
	
	public List<QnADetailDto> selectQnAListByMemberNo(int begin, int end, int memberNo) throws SQLException{
		String sql = "select * "
	            + "    from (select row_number() over (order by q.question_date desc) rn, q.question_no, "
	            + "    q.product_no, q.member_no, q.question_title, q.question_content, q.question_date, "
	            + "    q. question_answered, q.answer_content, q.answer_date, m.member_name, m.member_id, "
	            + "    p.product_name, p.product_img, p.product_brand "
	            + "    from tb_qna q, tb_members m, tb_products p "
	            + "    where q.member_no = m.member_no "
	            + "    and p.product_no = q.product_no"
	            + "	   and m.member_no = ?) "
	            + "where rn >= ? and rn <= ? "
	            + "order by question_no desc ";
		
		List<QnADetailDto> qnADetailList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, memberNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			QnADetailDto qnADetail = new QnADetailDto();

			qnADetail.setProductNo(rs.getInt("product_no"));
			qnADetail.setMemberNo(rs.getInt("member_no"));
			qnADetail.setMemberId(rs.getString("member_id"));
			qnADetail.setQnANo(rs.getInt("question_no"));
			qnADetail.setMemberName(rs.getString("member_name"));
			qnADetail.setTitle(rs.getString("question_title"));
			qnADetail.setQuestionContent(rs.getString("question_content"));
			qnADetail.setAnswerContent(rs.getString("answer_content"));
			qnADetail.setQuestionAnswered(rs.getString("question_answered"));
			qnADetail.setQuestionDate(rs.getDate("question_date"));
			qnADetail.setAnswerDate(rs.getDate("answer_date"));
			qnADetail.setPhoto(rs.getString("product_img"));
			qnADetail.setProductName(rs.getString("product_name"));
			qnADetail.setProductBrand(rs.getString("product_brand"));
			
			qnADetailList.add(qnADetail);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return qnADetailList;
	}
	
	public int selectTotalQnADetailRows(Criteria2 criteria) throws SQLException {
		String sql = "select count(*) cnt "
				+ "from (select q.product_no, q.member_no, q.question_title, q.question_content, q.question_date, "
				+ "q.question_answered, q.answer_content, q.answer_date, m.member_name, m.member_id, "
				+ "p.product_name, p.product_img, p.product_brand "
				+ "from tb_qna q, tb_members m, tb_products p "
				+ "where q.member_no = m.member_no "
				+ "and p.product_no = q.product_no ";
		if ("productName".equals(criteria.getOption())) {
			sql += "        and p.product_name like '%' || ? || '%' ";
		} else if ("id".equals(criteria.getOption())) {
			sql += "        and m.MEMBER_ID like '%' || ? || '%' ";
		} 
			sql += "            ) "	;
				
				  
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if (criteria.getOption() != null) {
			pstmt.setString(1, criteria.getKeyword());
		} 
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	/**
	 * 회원, 상품, 큐엔에이 테이블 조인하여 모든 큐엔에이 정보 조회
	 * @param begin
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<QnADetailDto> selectAllQnADetail(Criteria2 criteria) throws SQLException{
		String sql = "SELECT QUESTION_NO, PRODUCT_NO, MEMBER_NO, QUESTION_TITLE, QUESTION_CONTENT, "
				+ "QUESTION_DATE, QUESTION_ANSWERED, ANSWER_CONTENT, "
				+ "ANSWER_DATE, MEMBER_NAME, MEMBER_ID, PRODUCT_NAME, PRODUCT_IMG, product_brand "
				+ "FROM (SELECT ROW_NUMBER() OVER (ORDER BY Q.QUESTION_DATE DESC) RN, Q.QUESTION_NO, "
				+ "Q.PRODUCT_NO, Q.MEMBER_NO, Q.QUESTION_TITLE, Q.QUESTION_CONTENT, Q.QUESTION_DATE, "
				+ "Q.QUESTION_ANSWERED, Q.ANSWER_CONTENT, Q.ANSWER_DATE, M.MEMBER_NAME, M.MEMBER_ID, "
				+ "P.PRODUCT_NAME, P.PRODUCT_IMG, p.product_brand "
				+ "FROM TB_QNA Q, TB_MEMBERS M, TB_PRODUCTS P "
				+ "WHERE Q.MEMBER_NO = M.MEMBER_NO "
				+ "AND P.PRODUCT_NO = Q.PRODUCT_NO ";
		if ("productName".equals(criteria.getOption())) {
			sql += "        and p.product_name like '%' || ? || '%' ";
		} else if ("id".equals(criteria.getOption())) {
			sql += "        and m.MEMBER_ID like '%' || ? || '%' ";
		} 
			sql += "            ) "	
				+ "where rn >= ? and rn <= ? "
				+ "order by question_date desc ";
					
		
		List<QnADetailDto> qnADetailList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if (criteria.getOption() != null) {
			pstmt.setString(1, criteria.getKeyword());
			pstmt.setInt(2, criteria.getBeginIndex());
			pstmt.setInt(3, criteria.getEndIndex());
		} else {
			pstmt.setInt(1, criteria.getBeginIndex());
			pstmt.setInt(2, criteria.getEndIndex());
		}
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			QnADetailDto qnADetail = new QnADetailDto();

			qnADetail.setProductNo(rs.getInt("product_no"));
			qnADetail.setMemberNo(rs.getInt("member_no"));
			qnADetail.setMemberId(rs.getString("member_id"));
			qnADetail.setQnANo(rs.getInt("question_no"));
			qnADetail.setMemberName(rs.getString("member_name"));
			qnADetail.setTitle(rs.getString("question_title"));
			qnADetail.setQuestionContent(rs.getString("question_content"));
			qnADetail.setAnswerContent(rs.getString("answer_content"));
			qnADetail.setQuestionAnswered(rs.getString("question_answered"));
			qnADetail.setQuestionDate(rs.getDate("question_date"));
			qnADetail.setAnswerDate(rs.getDate("answer_date"));
			qnADetail.setPhoto(rs.getString("product_img"));
			qnADetail.setProductName(rs.getString("product_name"));
			qnADetail.setProductBrand(rs.getString("product_brand"));
			
			qnADetailList.add(qnADetail);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return qnADetailList;
	}

	/**
	 * qna 삽입
	 * @param qna
	 * @throws SQLException
	 */
	public void insertQnA(QnA qna) throws SQLException {
		String sql = "insert into tb_qna(question_no, product_no, member_no, "
				+ "question_title, question_content) "
				   + "values(q_no_seq.nextval, ?,?,?,? )";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, qna.getProductNo());
		pstmt.setInt(2, qna.getMemberNo());
		pstmt.setString(3, qna.getTitle());
		pstmt.setString(4, qna.getQuestionContent());
	
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	
	public QnA selectQnAByQnANo(int QnANo)  throws SQLException {
		String sql = "select question_no, product_no, member_no, question_title, "
				+ "question_content, question_date, "
				+ "question_answered, answer_content, answer_date "
				+ "from tb_qna "
				+ "where question_no = ? ";
		
		QnA qnA = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, QnANo);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			qnA = new QnA();
			qnA.setProductNo(rs.getInt("product_no"));
			qnA.setMemberNo(rs.getInt("member_no"));
			qnA.setNo(rs.getInt("question_no"));
			qnA.setTitle(rs.getString("question_title"));
			qnA.setQuestionContent(rs.getString("question_content"));
			qnA.setAnswerContent(rs.getString("answer_content"));
			qnA.setQuestionAnswered(rs.getString("question_answered"));
			qnA.setQuestionDate(rs.getDate("question_date"));
			qnA.setAnswerDate(rs.getDate("answer_date"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return qnA;
		}
	
	
	public void updateQnA(QnA qnA) throws SQLException {
		String sql = "update tb_qna "
				   + "set "
				   + "	question_title = ?, "
				   + "	question_content = ?,"
				   + "	answer_content = ?, "
				   + "	question_answered = ?, "
				   + "	answer_date = ? "
				   + "where question_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, qnA.getTitle());
		pstmt.setString(2, qnA.getQuestionContent());
		pstmt.setString(3, qnA.getAnswerContent());
		pstmt.setString(4, qnA.getQuestionAnswered());
		pstmt.setDate(5, new java.sql.Date(qnA.getAnswerDate().getTime()));
		pstmt.setInt(6, qnA.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
}
	