<%@page import="vo.Pagination2"%>
<%@page import="vo.Criteria2"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
<%@page import="dto.QnADetailDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="../resources/css/style.css" />
    <title>ABC마트 관리자페이지</title>
<style>
#answer {color: white;  padding: 4px 8px; border:none; background-color : black; }
 #qna-container .style{padding:2px 0 !important; text-align:center;}
 #qna-container .style-1{padding:2px 4px !important;}
 #qna-container th.style{padding:6px 0 !important;}
 #qna-container .select-box{margin-left:auto; width:120px;}
 #qna-container .select-box select{padding:0 10px;}
 .accordion .btn {
  white-space: normal;
}
</style>

</head>
<body>
<%@ include file="admin-common.jsp" %>

<% 
QnaDao qnaDao = QnaDao.getInstance();
//요청파라미터에 pageNo값이 존재하지 않으면 Pagination객체에서 1페이지로 설정한다.
	int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
	String option = StringUtils.defaultString(request.getParameter("option"), "");
	String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");
	
	Criteria2 criteria = new Criteria2();

	// 검색옵션과 검색키워드가 모두 있는 경우에만 Criteria객체에 검색옵션과 검색 키워드를 저장한다.
  if (!StringUtils.isEmpty(option) && !StringUtils.isEmpty(keyword)) {
    	criteria.setOption(option);
    	criteria.setKeyword(keyword);
  }
    	
    	// 검색조건에 맞는 게시글의 총 갯수를 조회한다.
        int totalRows = qnaDao.selectTotalQnADetailRows(criteria);
        // 페이징처리에 필요한 정보를 제공하는 Pagination객체를 생성한다.
        Pagination2 pagination = new Pagination2(pageNo, totalRows);
        
        // 게시글 리스틀 조회할 때 필요한 조회범위를 Criteria객체에 저장한다.
        criteria.setBeginIndex(pagination.getBeginIndex());
        criteria.setEndIndex(pagination.getEndIndex());
    	
List<QnADetailDto> qnaDetailList = qnaDao.selectAllQnADetail(criteria);


%>
<div class="container" id="qna-container">    
	<div class="row">
		<div class="col p-0 page-title">
			<h1>관리자페이지</h1>
		</div>
	</div>
	<div class="row mypage">
		<!-- aside 시작 -->
			<div class="col-2 p-0 aside">
			<span class="aside-title">관리자 페이지</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="main.jsp" class="nav-link p-0">관리자페이지 메인</a></li>
			</ul>
			<span class="aside-title d-block mt-4">회원 관리</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="member-list.jsp" class="nav-link p-0">회원목록 조회</a></li>
				<li class=""><a href="member-left-list.jsp" class="nav-link p-0">탈퇴회원 목록 조회</a></li>
			</ul>
			<span class="aside-title d-block mt-4">상품 관리</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="product-list.jsp" class="nav-link p-0">전체 상품 조회</a></li>
				<li class=""><a href="registerform.jsp" class="nav-link p-0">신규 상품 등록</a></li>
				<li class=""><a href="stock-management.jsp" class="nav-link p-0">재고 관리</a></li>
			</ul>
			<span class="aside-title d-block mt-4">CS</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="order-list.jsp" class="nav-link p-0">주문 관리</a></li>
				<li class=""><a href="qna-list.jsp" class="nav-link p-0">QnA 목록</a></li>
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>
			</ul>
		</div>	
		<div class="col-9">
			<div class="row mb-3">
				<div class="col">
					<div><h4>QnA 목록</h4></div>
					<div>
						<form id="form-search" class="row" method="get" action="qna-list.jsp">
							<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">
							<div class="col-4" style="height: 31px; line-height: 31px;">
								총 <strong><%=totalRows %></strong> 개의 QnA가 있습니다.
							</div>			
							<div class="col-4">
								<div class="input-group select-box">
									<select class="form-select" id="search-option" name="option"
										style="height: 31px; font-size: 14px;">
										<option value="productName" <%="productName".equals(option) ? "selected" : ""%>>상품이름</option>
										<option value="id" <%="id".equals(option) ? "selected" : ""%>>회원아이디</option>
									</select>
								</div>
							</div>
							<div class="col-3">
								<div class="input-group">
									<input type="text" class="form-control" id="search-keyword" name="keyword" value="<%=StringUtils.isBlank(keyword) ? "" : keyword%>"	placeholder="검색어를 입력하세요"
									style="height: 31px; font-size: 14px;">
								</div>
							</div>
							<div class="col-1">
								<div class="input-group justify-content-end">
									<button class="btn btn-sm btn-outline-dark" type="button" id="btn-search" onclick="searchBoards(1)">검색</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			
				
					
<% 
	for (QnADetailDto qnaDetail : qnaDetailList) {
%>						
				<table class="table table-hover mb-0 align-middle" style="border-top: 2px solid #000">
					<colgroup>
						<col width="70px">
						<col width="20%">
						<col width="10%">
						<col width="">
					</colgroup>
					<tbody>
						<tr>
							<td class="style">
								<img src = "/semi-project/resources/images/products/<%=qnaDetail.getPhoto() %> " width="50" height="50">
							</td>
							<td class="style">
								<a href="product-detail.jsp?no=<%=qnaDetail.getProductNo()%>"><%=qnaDetail.getProductName() %></a><br>
						    	<small class="text-muted"><%=qnaDetail.getProductBrand() %></small>
						    </td>
							<td class="style"><%=qnaDetail.getMemberName() %>(<%=qnaDetail.getMemberId() %>)</td>
							<td class="table-active style-1">
								<strong>Q.</strong><%=" "+qnaDetail.getTitle() %> <%=" - "+ qnaDetail.getQuestionContent()+"  "%>
								<small>(<%=qnaDetail.getQuestionDate() %>)</small>
							</td>						
						</tr>
<% if (qnaDetail.getQuestionAnswered().equals("Y")) { %>	
						<tr>
							<td colspan="4"><strong>A.</strong><%=" "+qnaDetail.getAnswerContent()+"  " %><small>(<%=qnaDetail.getAnswerDate() %>)</small></td>
						</tr>
					</tbody>				
				</table>							
<% 
	} else {  
%>			            
					</tbody>				
			</table>   		
					<div class="row">
						<div class="col mt-1 accordion accordion-flush" id="faqlist">
	                    	<div class="accordion-item">
								<h2 class="accordion-header" id="faq-heading-<%=qnaDetail.getQnANo()%>">
		                    		<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-content-<%=qnaDetail.getQnANo()%>">
		                        		<small id="answer">답변하기</small>
		                    		</button>
	                     		</h2>
							</div>
	                       	<div id="faq-content-<%=qnaDetail.getQnANo()%>" class="accordion-collapse collapse" data-bs-parent="#faqlist">
								<div class="accordion-body">       
			                		<form class="well row g-3" method="post" action="qna-answer.jsp">
			                			<input type="hidden" name="qnANo" value="<%=qnaDetail.getQnANo()%>"/>
			                			<input type="hidden" name="page" value="<%=pageNo%>"/>
			                			<input type="hidden" name="option" value="<%=option%>"/>
			                			<input type="hidden" name="keyword" value="<%=keyword%>"/>
	   			 						<div class="col-11">
	   			 							<textarea class="form-control" aria-label="With textarea" name="content"></textarea> 
	   			 						</div>
	   			 						<div class="text-right col-1" >
	   			 						    <button class="btn btn-dark btn-sm" type="submit">등록</button>
										</div>
	  			 					</form>
	     			 			</div>
	     			 			</div>
				      	</div>
			       	</div>	
<% 
	}
%>	        	       			 						

<% 
}
%>	       
				</div>
			
		</div>
		<div class="row mt-3 mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getPrev()%>)" >이전</a>
					</li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBegin(); num <= pagination.getEnd(); num++) {
%>					
						<li class="page-item <%=num == pagination.getPage() ? "active" : ""%>">
						<a href="" class="page-link" onclick="moveToPage(event, <%=num%>)"><%=num%></a>
					</li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getNext()%>)">다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
		
</div>	

<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

//페이지번호를 클릭했을 때 실행되는 함수
function moveToPage(event, page) {
	event.preventDefault();	// a태그에서 onclick이벤트가 발생하면 href에 정의된 주소로 이동하는 기본동작이 일어나지 않게 함.
	searchBoards(page);
}

//검색버튼을 클릭했을 때 실행되는 함수
function searchBoards(page) {
	document.getElementById("page-field").value = page;
	var form = document.getElementById("form-search");
	form.submit();
}  </script>
</body>
</html>