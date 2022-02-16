<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");

	String pwd = request.getParameter("pwd");
	
	if(pwd == null && pwd.isBlank()) {
		response.sendRedirect("change-pwd.jsp?error=empty-pwd");
		return;
	}
	
	String confirmPwd = request.getParameter("pwd-confirm");

	String secretPwd = DigestUtils.sha256Hex(pwd);
	String secretConfirmPwd = DigestUtils.sha256Hex(confirmPwd);
	
	
	
	if(!secretPwd.equals(secretConfirmPwd)) {
		response.sendRedirect("change-pwd.jsp?error=notmatch-pwd");
		return;
	}
	
	// 세션정보를 통해 회원 번호를 반환
	int no = loginUserInfo.getNo();
	MemberDao memberDao = MemberDao.getInstance();
	// 변경된 비밀번호와 회원번호를 전달하여 업데이트 반영
	memberDao.updateMemberByPassword(secretPwd, no);
	
	
	response.sendRedirect("../main.jsp?completed=change-pwd");

%>