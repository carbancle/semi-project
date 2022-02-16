<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 입력한 비밀번호 정보 조회
	String pwd = request.getParameter("pwd");
	// session객체에서 회원 정보 조회
	Member member = (Member)session.getAttribute("LOGIN_USER_INFO");
	
	String memberPwd = member.getPwd();
	
	// 입력값 content가 없거나 비어있으면 게시글을 등록할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (pwd != null && pwd.isBlank()) {
		response.sendRedirect("pwd-search.jsp?error=emptyt");
		return;
	}
	
	// 사용자 인증에 필요한 사용자정보를 조회하기 위해서 memberDao객체를 획득한다.
	MemberDao memberDao = MemberDao.getInstance();
	// 아이디로 사용자 정보를 조회한다.
	
	// 비빌번호 비교를 위해서 로그인폼에서 제출한 비밀번호를 암호화한다.
	String secretPwd = DigestUtils.sha256Hex(pwd);
	
	// 테이블에서 조회한 사용자의 비밀번호와 로그인폼에서 입력한 비밀번호가 일치하지 않으면, 사용자 인증이 실패한다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (!memberPwd.equals(secretPwd)) {	
		response.sendRedirect("pwd-search.jsp?error=mismatch-pwd");
		return;
	}
	
	// 클라이언트에 index.jsp를 재요청하는 URL을 응답으로 보낸다.
	// 클라이언트가 index.jsp를 요청하면 그 클라이언트 전용의 HttpSession객체에 인증된 사용자 정보가 존재하기 때문에 
	// 내비게이션에 인증된 사용자명과 로그아웃 링크가 표시된다.
	response.sendRedirect("pwd-change.jsp");
%>