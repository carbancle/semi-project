<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
<%@page import="service.QnAService"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String content = request.getParameter("content");
int qnANo = Integer.parseInt(request.getParameter("qnANo"));
int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
String option = StringUtils.defaultString(request.getParameter("option"), "");
String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");

QnAService qnAService = new QnAService();
qnAService.answerQuestion(qnANo, content);



//전체 글목록을 제공하는 list.jsp를 재요청하게 하는 응답을 보낸다.
response.sendRedirect("qna-list.jsp?page=" + pageNo + 
"&option=" + option + "&keyword=" + URLEncoder.encode(keyword, "UTF-8"));

%>