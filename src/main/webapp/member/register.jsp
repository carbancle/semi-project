<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//registerform.jsp에서 제출한 폼입력값을 조회한다.	
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String againPwd = request.getParameter("againPwd");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	
	// 입력한 비밀번호와 재입력한 비밀번호가 동일하지 않으면 member-join.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 회원가입 실패원인을 포함시킨다.
	if (!pwd.equals(againPwd)) {
		response.sendRedirect("member-join.jsp?error=notEqualPwd");
		return;
	}
	
	// 사용자 인증에 필요한 사용자정보를 조회하기 위해서 memberDao객체를 획득한다.
	MemberDao memberDao = MemberDao.getInstance();
	
	// 아이디로 사용자 정보를 조회한다.
	Member savedMember = memberDao.selectMemberById(id);
	// 아이디에 해당하는 사용자 정보가 존재하면, 회원가입이 실패한다.
	// 클라이언트에게 회원가입 정보를 입력하는 member-join.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 회원가입 실패원인을 포함시킨다.
	if (savedMember != null) {
		response.sendRedirect("member-join.jsp?error=id-exists");
		return;
	}
	
	// 이메일로 사용자 정보를 조회한다.
	Member savedEmail = memberDao.selectMemberByEmail(email);
	// 이메일에 해당하는 사용자 정보가 존재하면, 회원가입이 실패한다.
	// 클라이언트에게 회원가입 정보를 입력하는 member-join.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 회원가입 실패원인을 포함시킨다.
	if (savedEmail != null) {
		response.sendRedirect("member-join.jsp?error=email-exists");
		return;
	}
	
	
	
	// 동일한 아이디로 가입된 사용자가 없고, 동일한 이메일로 가입된 사용자 존재하지 않으면 회원가입을 진행한다.
	
	// 비밀번호를 암호화한다.
	String secretPassword = DigestUtils.sha256Hex(pwd);
	// User객체를 생성해서 사용자정보를저장한다.
	Member member = new Member();
	member.setName(name);
	member.setId(id);
	member.setPwd(secretPassword);
	member.setName(name);
	member.setAddress(address);
	member.setEmail(email);
	member.setTel(tel);
	
	
	// 회원정보를 테이블에 저장시킨다.
	memberDao.insertMember(member);
	
	// 클라이언트에게 main.jsp를 재요청하는 URL을 응답으로 보낸다.
	// 재요청 URL에 회원가입이 완료되었다는 정보를 포함시킨다.
	response.sendRedirect("../main.jsp?register=completed");
%>