<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
<%@page import="service.StockService"%>
<%@page import="dao.StockDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int stockAmount = Integer.parseInt(request.getParameter("amount"));
int productDetailNo = Integer.parseInt(request.getParameter("no"));
int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
String option = StringUtils.defaultString(request.getParameter("option"), "");
String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");

StockDao stockDao = StockDao.getInstance();
StockService stockService = new StockService();

stockService.UpdateStockAmount(productDetailNo, stockAmount);

//전체 글목록을 제공하는 list.jsp를 재요청하게 하는 응답을 보낸다.
response.sendRedirect("stock-management.jsp?page=" + pageNo + "&option=" + option + "&keyword=" + URLEncoder.encode(keyword, "UTF-8"));

%>