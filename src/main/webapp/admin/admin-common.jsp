<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");

   if (loginUserInfo == null || !("admin".equals(loginUserInfo.getId()))){
%>
      <script>
         alert("올바른 접근 방식이 아닙니다.");
         location.replace('/semi-project/main.jsp');
      </script>
<%
   }
%>
<style>
	.container .col-2{width:12%;}
	.container .col-10{width:88%;}
</style>
<nav class="navbar navbar-expand-lg navbar-light bg-top">
	<div class="container p-0">
		<div class="collapse navbar-collapse" id="navbar-1">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					 <a class="navbar-brand" href="/semi-project/main.jsp">
				      <img src="/semi-project/resources/images/logo-sm.png" alt="" class="d-inline-block align-text-top">
				    </a>
				</li>
			</ul>
			<ul class="navbar-nav">
				<li class="nav-item"><a href="/semi-project/admin/main.jsp" class="nav-link ">관리자페이지</a></li>
				<li class="nav-item"><a href="/semi-project/logout.jsp" class="nav-link ">로그아웃</a></li>
	
			</ul>
		</div>
	</div>
</nav>
<nav class="navbar navbar-expand-lg navbar-ligth bg-bottom">
	<div class="container">
	</div>
</nav>