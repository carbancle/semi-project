package dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Criteria2;
import vo.Member;


public class MemberDao {

	
	private static MemberDao self = new MemberDao();
	private MemberDao() {}
	public static MemberDao getInstance() {
		return self;
	}
	
	
	/**
	 * 
	 * @return 오늘 탈퇴한 회원수
	 * @throws SQLException
	 */
	public int selectTodayLeftCount() throws SQLException {
		int count = 0;
		
		String sql = "select count(*) cnt "
				+ "from tb_members "
				+ "where member_deleted_date >= TRUNC(SYSDATE) "
				+ "AND member_deleted_date < TRUNC(SYSDATE) + 1";
		
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
	 * @return 오늘 가입한 회원수
	 * @throws SQLException
	 */
	public int selectTodayJoinCount() throws SQLException {
		int count = 0;
		
		String sql = "select count(*) cnt "
				+ "from tb_members "
				+ "where member_registered_DATE >= TRUNC(SYSDATE) "
				+ "AND member_registered_DATE < TRUNC(SYSDATE) + 1";
		
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
	
	
	
	
	
	public List<Member> selectTodayLeftMember() throws SQLException {
		String sql = "select * from tb_members "
				+ "WHERE member_deleted_date >= TRUNC(SYSDATE) "
				+ "AND member_deleted_date < TRUNC(SYSDATE) + 1";
		List<Member> memberList = new ArrayList<>();
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Member member = new Member();
			member.setNo(rs.getInt("member_no"));
			member.setId(rs.getString("member_id"));
			member.setPwd(rs.getString("member_pwd"));
			member.setName(rs.getString("member_name"));
			member.setTel(rs.getString("member_tel"));
			member.setEmail(rs.getString("member_email"));
			member.setAddress(rs.getString("member_address"));
			member.setPct(rs.getInt("member_pct"));
			member.setRegisteredDate(rs.getDate("member_registered_date"));
			member.setDeleted(rs.getString("member_deleted"));
			member.setDeletedDate(rs.getDate("member_deleted_date"));
			
			memberList.add(member);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return memberList;
		}
	
	
	public List<Member> selectTodayJoinMember() throws SQLException {
		String sql = "select * from tb_members "
				+ "WHERE member_registered_DATE >= TRUNC(SYSDATE) "
				+ "AND member_registered_DATE < TRUNC(SYSDATE) + 1";
		List<Member> memberList = new ArrayList<>();
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Member member = new Member();
			member.setNo(rs.getInt("member_no"));
			member.setId(rs.getString("member_id"));
			member.setPwd(rs.getString("member_pwd"));
			member.setName(rs.getString("member_name"));
			member.setTel(rs.getString("member_tel"));
			member.setEmail(rs.getString("member_email"));
			member.setAddress(rs.getString("member_address"));
			member.setPct(rs.getInt("member_pct"));
			member.setRegisteredDate(rs.getDate("member_registered_date"));
			member.setDeleted(rs.getString("member_deleted"));
			member.setDeletedDate(rs.getDate("member_deleted_date"));
			
			memberList.add(member);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return memberList;
		}
	
	
	/**
	 * 탈퇴한 회원들만 조회
	 * @param begin
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<Member> selectAllLeftMembers(Criteria2 criteria) throws SQLException  {
		
		String sql = "select * "
				   + "from (select row_number() over (order by member_registered_date desc) rn, "
				   + "             member_no, member_id, member_pwd, member_name, member_tel, member_email,  "
				   + "             member_address, member_pct, member_registered_date, "
				   + "			   member_deleted, member_deleted_date "
				   + "      from tb_members "
				   + "		where member_deleted = 'Y' ";
				   if ("id".equals(criteria.getOption())) {	
						sql += "        and member_id like '%' || ? || '%' ";
					} else if ("name".equals(criteria.getOption())) {
						sql += "        and member_name like '%' || ? || '%' ";
					} else if ("email".equals(criteria.getOption())) {
						sql += "        and member_email like '%' || ? || '%' ";
					} else if ("tel".equals(criteria.getOption())) {
						sql += "        and member_tel like '%' || ? || '%' ";
					}	sql += "    ) where rn >= ? and rn <= ? order by member_registered_date desc ";
				  
		List<Member> memberList = new ArrayList<>();
		
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
			Member member = new Member();
			member.setNo(rs.getInt("member_no"));
			member.setId(rs.getString("member_id"));
			member.setPwd(rs.getString("member_pwd"));
			member.setName(rs.getString("member_name"));
			member.setTel(rs.getString("member_tel"));
			member.setEmail(rs.getString("member_email"));
			member.setAddress(rs.getString("member_address"));
			member.setPct(rs.getInt("member_pct"));
			member.setRegisteredDate(rs.getDate("member_registered_date"));
			member.setDeleted(rs.getString("member_deleted"));
			member.setDeletedDate(rs.getDate("member_deleted_date"));
			
			memberList.add(member);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return memberList;
	}
	
	public int selectTotalLeftMembersCountByCriteria(Criteria2 criteria) throws SQLException {
		String sql = "select count(*) cnt "
				 + "from (select * from tb_members "
				   + "		where member_deleted = 'Y' ";
				   if ("id".equals(criteria.getOption())) {	
						sql += "        and member_id like '%' || ? || '%' ";
					} else if ("name".equals(criteria.getOption())) {
						sql += "        and member_name like '%' || ? || '%' ";
					} else if ("email".equals(criteria.getOption())) {
						sql += "        and member_email like '%' || ? || '%' ";
					} else if ("tel".equals(criteria.getOption())) {
						sql += "        and member_tel like '%' || ? || '%' ";
					}	sql += "    ) order by member_registered_date desc ";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if (criteria.getOption() != null) {
			pstmt.setString(1, criteria.getKeyword());
		} 
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");

    return totalRecords;
	}
	
	public int selectTotalMembersCountByCriteria(Criteria2 criteria) throws SQLException {
		String sql = "select count(*) cnt "
				 + "from (select * from tb_members "
				   + "		where member_deleted = 'N' ";
				   if ("id".equals(criteria.getOption())) {	
						sql += "        and member_id like '%' || ? || '%' ";
					} else if ("name".equals(criteria.getOption())) {
						sql += "        and member_name like '%' || ? || '%' ";
					} else if ("email".equals(criteria.getOption())) {
						sql += "        and member_email like '%' || ? || '%' ";
					} else if ("tel".equals(criteria.getOption())) {
						sql += "        and member_tel like '%' || ? || '%' ";
					}	sql += "    ) order by member_registered_date desc ";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if (criteria.getOption() != null) {
			pstmt.setString(1, criteria.getKeyword());
		} 
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");

    return totalRecords;
	}
	
	
	/**
	 * 탈퇴한 회원들을 제외하고 조회
	 * @param begin
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<Member> selectAllMembers(Criteria2 criteria) throws SQLException  {
	
	String sql = "select * "
			   + "from (select row_number() over (order by member_no desc) rn, "
			   + "             member_no, member_id, member_pwd, member_name, member_tel, member_email,  "
			   + "             member_address, member_pct, member_registered_date, "
			   + "			   member_deleted, member_deleted_date "
			   + "      from tb_members "
			   + "		where member_deleted = 'N' ";
			   if ("id".equals(criteria.getOption())) {	
					sql += "        and member_id like '%' || ? || '%' ";
				} else if ("name".equals(criteria.getOption())) {
					sql += "        and member_name like '%' || ? || '%' ";
				} else if ("email".equals(criteria.getOption())) {
					sql += "        and member_email like '%' || ? || '%' ";
				} else if ("tel".equals(criteria.getOption())) {
					sql += "        and member_tel like '%' || ? || '%' ";
				}	sql += "    ) where rn >= ? and rn <= ? order by member_no desc ";
			  
	List<Member> memberList = new ArrayList<>();
	
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
		Member member = new Member();
		member.setNo(rs.getInt("member_no"));
		member.setId(rs.getString("member_id"));
		member.setPwd(rs.getString("member_pwd"));
		member.setName(rs.getString("member_name"));
		member.setTel(rs.getString("member_tel"));
		member.setEmail(rs.getString("member_email"));
		member.setAddress(rs.getString("member_address"));
		member.setPct(rs.getInt("member_pct"));
		member.setRegisteredDate(rs.getDate("member_registered_date"));
		member.setDeleted(rs.getString("member_deleted"));
		member.setDeletedDate(rs.getDate("member_deleted_date"));
		
		memberList.add(member);
	}
	rs.close();
	pstmt.close();
	connection.close();
	
	return memberList;
}
	
	/**
	 * 지정된 회원 번호에 해당하는 회원정보를 반환한다.
	 * @param no 회원번호
	 * @return 회원정보
	 * @throws SQLException
	 */
	public Member selectMemberByNo(int no) throws SQLException {
		String sql = "select * from tb_members where member_no = ?";
		Member member = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			member = new Member();
			member.setNo(rs.getInt("member_no"));
			member.setId(rs.getString("member_id"));
			member.setPwd(rs.getString("member_pwd"));
			member.setName(rs.getString("member_name"));
			member.setTel(rs.getString("member_tel"));
			member.setEmail(rs.getString("member_email"));
			member.setAddress(rs.getString("member_address"));
			member.setPct(rs.getInt("member_pct"));
			member.setRegisteredDate(rs.getDate("member_registered_date"));
			member.setDeleted(rs.getString("member_deleted"));
			member.setDeletedDate(rs.getDate("member_deleted_date"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return member;
	}
	
	/**
	 * 지정된 회원 아이디에 해당하는 회원 정보를 반환한다.
	 * @param id 회원 아이디
	 * @return 회원정보
	 * @throws SQLException
	 */
	public Member selectMemberById(String id) throws SQLException {
		String sql = "select * from tb_members where member_id = ?";
		Member member = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			member = new Member();
			member.setNo(rs.getInt("member_no"));
			member.setId(rs.getString("member_id"));
			member.setPwd(rs.getString("member_pwd"));
			member.setName(rs.getString("member_name"));
			member.setTel(rs.getString("member_tel"));
			member.setEmail(rs.getString("member_email"));
			member.setAddress(rs.getString("member_address"));
			member.setPct(rs.getInt("member_pct"));
			member.setRegisteredDate(rs.getDate("member_registered_date"));
			member.setDeleted(rs.getString("member_deleted"));
			member.setDeletedDate(rs.getDate("member_deleted_date"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return member;
	}
	
	/**
	 * 지정된 회원 이메일에 해당하는 회원 정보를 반환한다.
	 * @param email 회원 이메일
	 * @return 회원정보
	 * @throws SQLException
	 */
	public Member selectMemberByEmail(String email) throws SQLException {
		String sql = "select * from tb_members where member_email = ?";
		Member member = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			member = new Member();
			member.setNo(rs.getInt("member_no"));
			member.setId(rs.getString("member_id"));
			member.setPwd(rs.getString("member_pwd"));
			member.setName(rs.getString("member_name"));
			member.setTel(rs.getString("member_tel"));
			member.setEmail(rs.getString("member_email"));
			member.setAddress(rs.getString("member_address"));
			member.setPct(rs.getInt("member_pct"));
			member.setRegisteredDate(rs.getDate("member_registered_date"));
			member.setDeleted(rs.getString("member_deleted"));
			member.setDeletedDate(rs.getDate("member_deleted_date"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return member;
	}
	
	/**
	 * 회원 번호가 일치하는 회원의 비밀번호를 변경한다.
	 * @param no
	 * @throws SQLException
	 */
	public void updateMemberByPassword(String pwd, int no) throws SQLException {
		String sql = "update tb_members "
				   + "set	"
				   + "	member_pwd = ? "
				   + "where member_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, pwd);
		pstmt.setInt(2, no);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 수정된 정보가 포함된 회원정보를 테이블에 반영한다.
	 * @param member 회원정보
	 * @throws SQLException
	 */
	public void updateMember(Member member) throws SQLException {
		String sql = "update tb_members "
				   + "set "
				   + " member_tel = ?, "
				   + " member_email = ?, "
				   + " member_address = ?, "
				   + " member_pct = ? "
				   + "where member_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, member.getTel());
		pstmt.setString(2, member.getEmail());
		pstmt.setString(3, member.getAddress());
		pstmt.setInt(4, member.getPct());
		pstmt.setInt(5, member.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 지정한 회원번호의 회원정보를 삭제처리(탈퇴)한다.
	 * @param no 회원번호
	 * @throws SQLException
	 */
	public void deleteMember(int no) throws SQLException {
		String sql = "update tb_members "
				   + "set "
				   + "	member_deleted = 'Y', "
				   + "	member_deleted_date = sysdate "
				   + "where member_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 지정된 회원정보를 테이블에 저장한다.
	 * @param member
	 * @throws SQLException
	 */
	public void insertMember(Member member) throws SQLException {
		String sql = "insert into tb_members(member_no, member_name, member_id, member_pwd, member_email, member_tel, member_address) "
				   + "values(members_seq.nextval, ?,?,?,?,?,?)";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, member.getName());
		pstmt.setString(2, member.getId());
		pstmt.setString(3, member.getPwd());
		pstmt.setString(4, member.getEmail());
		pstmt.setString(5, member.getTel());
		pstmt.setString(6, member.getAddress());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
}
