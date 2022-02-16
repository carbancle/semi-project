<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// login.jsp 에서 입력한 폼입력값을 조회한다.
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	// 입력값 id이 없거나 비어있으면 게시글을 등록할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (id != null && id.isBlank()) {
		response.sendRedirect("loginform.jsp?error=empty");
		return;
	}
	// 입력값 content가 없거나 비어있으면 게시글을 등록할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (pwd != null && pwd.isBlank()) {
		response.sendRedirect("loginform.jsp?error=emptyt");
		return;
	}
	
	// 사용자 인증에 필요한 사용자정보를 조회하기 위해서 memberDao객체를 획득한다.
	MemberDao memberDao = MemberDao.getInstance();
	// 아이디로 사용자 정보를 조회한다.
	Member member = memberDao.selectMemberById(id);
	
	// 아이디에 해당하는 사용자 정보가 존재하지 않으면, 사용자 인증이 실패한다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (member == null) {	
		response.sendRedirect("loginform.jsp?error=notfound-member");
		return;
	}
	// 비빌번호 비교를 위해서 로그인폼에서 제출한 비밀번호를 암호화한다.
	String secretPwd = DigestUtils.sha256Hex(pwd);
	
	// 테이블에서 조회한 사용자의 비밀번호와 로그인폼에서 입력한 비밀번호가 일치하지 않으면, 사용자 인증이 실패한다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (!member.getPwd().equals(secretPwd)) {	
		response.sendRedirect("loginform.jsp?error=mismatch-pwd");
		return;
	}
	
	// 회원탈퇴를 진행한 경우 사용자 인증이 실패한다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if ("Y".equals(member.getDeleted())) {
		response.sendRedirect("loginform.jsp?error=deleted-user");
		return;
	}

	// 사용자 정보가 존재하고, 비밀번호가 일치하면 사용자 인증이 완료되었다.
	// 사용자 인증이 완료되면, 사용자정보를 로그인을 요청한 클라이언트의 전용 HttpSession객체에 속성으로 저장한다.
	// 로그인을 요청한 클라이언트 전용의 HttpSession객체에 사용자정보를 속성으로 저장하면, JSP를 요청할 때마다 HttpSession에서 사용자정보를 조회할 수 있다.
	// 즉, 사용자 인증이 완료된 클라이언트는 더이상 자신이 누군지 서버에 전달할 필요가 없어진다.
	// 모든 JSP 페이지에서 JSP 페이지를 요청한 클라이언트에 대한 정보를 클라이언트 전용 HttpSession객체에서 조회할 수 있기 때문이다.
	// 이 프로젝트에서는 사용자 인증이 완료되면 "LOGIN_USER_INFO"라는 이름으로 사용자정보를 HttpSession객체에 저장했다.
	session.setAttribute("LOGIN_USER_INFO", member);

	// 클라이언트에 index.jsp를 재요청하는 URL을 응답으로 보낸다.
	// 클라이언트가 index.jsp를 요청하면 그 클라이언트 전용의 HttpSession객체에 인증된 사용자 정보가 존재하기 때문에 
	// 내비게이션에 인증된 사용자명과 로그아웃 링크가 표시된다.
	response.sendRedirect("main.jsp");
%>