<%@page import="dao.MemberDao"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");
	MemberDao memberDao = MemberDao.getInstance();
	
	memberDao.deleteMember(loginUserInfo.getNo());
	session.invalidate();
	response.sendRedirect("../../main.jsp?user=deleted");
%>