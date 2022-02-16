<%@page import="vo.Member"%>
<%@page import="dao.QnaDao"%>
<%@page import="vo.QnA"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member member = (Member)session.getAttribute("LOGIN_USER_INFO");
	if(member == null){
		response.sendRedirect("loginform.jsp");
		return;
	}
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// title를 입력하지 않으면 제출되지 않는다.
	if(title == null){
		response.sendRedirect("detail.jsp?error=titleEmpty");	
		return;
	}
	
	// content를 입력하지 않으면 제출되지 않는다.
	if(content == null){
		response.sendRedirect("detail.jsp?error=ContentEmpty");	
		return;
	}
	
	// 모두 입력시 qna객체를 생성해 저장한다.
	QnA qna = new QnA();
	qna.setProductNo(productNo);
	qna.setMemberNo(member.getNo());
	qna.setTitle(title);
	qna.setQuestionContent(content);
	
	// qna를 테이블에 저장한다.
	QnaDao qnaDao = QnaDao.getInstance();
	
	qnaDao.insertQnA(qna);
	
	response.sendRedirect("detail.jsp?no="+ productNo);
	
%>