
<%@page import="model.FAQInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<FAQInfoModel> listFI = (List<FAQInfoModel>) request.getAttribute("listFI");
String type = request.getParameter("type");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CallGet</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/style.css">

</head>
<body style="padding-top: 100px;">
<jsp:include page="./top_menu.jsp"></jsp:include>
<div class="about-top-section">
	<img class="about-title" src="images/about_title.png" />
</div>
<div class="about-content-div">
	<img src="images/about_content.jpg" />
</div>
<div class="use-container" id="use">
	<span class="use-title">이용방법</span>
	<span class="use-text">콜겟은 전화 한번에 요즘 뜨는 잇템을 가질 수 있는 리워드 플렛폼입니다.</span>
	<img class="use-img" src="images/use_process.png" />
</div>
<div class="faq-container">
	<span class="faq-title">FAQ</span>
	<span class="faq-text">고객님께서 자주 문의주시는 내용입니다.</span>
	<ul class="faq-ul">
		<%for(int i=0; i<listFI.size(); i++){
			FAQInfoModel list = listFI.get(i);
			%>
			<li class="faq-li">
				<span class="faq-li-title"><%=list.getTitle() %></span>
				<span class="faq-li-content"><%=list.getContent().replaceAll("\n", "<br/>") %></span>
			</li>
		<%} %>
		
	</ul>
	<div style="width: 100%; clear: both;"></div>
	<a href="main.cg" class="it_link">it템 보러가기</a>
</div>
<jsp:include page="./footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
$(document).ready(function() {
	var type = "<%=type%>";
	if(type == "2"){
		$("html, body").stop().animate({scrollTop:$('#use').offset().top-80}, 500, 'swing', function(){});
	}
});

</script>

</html>