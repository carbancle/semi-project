<%@page import="dao.MemberDao"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html> 
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");
	String pwd = request.getParameter("pwd");
	
	MemberDao memberDao = MemberDao.getInstance();

	String secretPwd = DigestUtils.sha256Hex(pwd);
	
	if (!loginUserInfo.getPwd().equals(secretPwd)) {
		response.sendRedirect("leaveform.jsp?error=mismatch-pwd");
		return;
	}
	
	response.sendRedirect("confirmleaveform.jsp");
%>	