<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그아웃은 인증된 사용자정보가 저장된 HttpSession객체를 폐기하는 것이다.
	// HttpSession객체의 invalidate() 메소드는 HttpSession객체를 폐기한다.
	// session.invalidate()를 실행하면 사용자정보(User객체)가 저장된 HttSession 객체가 폐기된다.
	// 즉, 서버에 로그아웃을 요청한 클라이언트 전용의 HttpSession객체가 사라진 것이다.
	session.invalidate();

	// 클라이언트에 index.jsp를 재요청하게 하는 응답을 보낸다.
	// 이 응답을 받은 클라이언트가 index.jsp를 재요청하면 웹서버는 HttpSession객체를 새로 생성한다.
	// 새로 생성한 HttpSession객체에는 인증된 사용자 정보가 존재하지 않는다.
	response.sendRedirect("main.jsp");
%>