<%@page import="dao.MemberDao"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");
	String pwd = request.getParameter("pwd");
	
	if (pwd == null && pwd.isBlank()) {
		response.sendRedirect("pwd-confirm.jsp?error=empty-pwd");
		return;
	}

	String secretPwd = DigestUtils.sha256Hex(pwd);
	
	if (!loginUserInfo.getPwd().equals(secretPwd)) {
		response.sendRedirect("pwd-confirm.jsp?error=mismatch-pwd");
		return;
	}
	
	response.sendRedirect("change-pwd.jsp");
%>