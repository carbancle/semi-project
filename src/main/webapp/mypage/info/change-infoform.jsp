<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인한 회원 정보 조회
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");

	// 이전 페이지에서 전달된 정보(주소,이메일,전화) 획득
	String address = request.getParameter("address");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	
	// db 정보를 불러온다.
	MemberDao memberDao = MemberDao.getInstance();
	
	// 전달된 값을 신규 Member 객체를 생성하여 저장한다.
	Member member = new Member();
	member.setAddress(address);
	member.setEmail(email);
	member.setTel(tel);
	member.setNo(loginUserInfo.getNo());
	
	// 저장된 값을 db에 업데이트한다.
	memberDao.updateMember(member);
	
	// 성공적으로 정보가 변경되면 마이페이지로 전달하고 결과값을 전달한다.
	response.sendRedirect("../main.jsp?completed=change-info");
%>