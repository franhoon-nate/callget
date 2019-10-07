<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">
function footerGo(){
	$("html, body").stop().animate({scrollTop:$('#footer').offset().top}, 500, 'swing', function(){});
	requestOpen();
}

</script>
</head>
<body>

<div class="top-menu">
	<div class="top-menu-container">
		<a href="main.cg" class="top-a"><img src="images/top_logo.png" /></a>
		
		<ul class="top-ul">
			<li class="top-li"><a href="javascript: footerGo();" class="top-menu-a">제휴문의</a></li>
			<li class="top-li"><a href="about.cg?type=2" class="top-menu-a">이용방법 설명</a></li>
			<li class="top-li"><a href="about.cg?type=1" class="top-menu-a">콜겟이란?</a></li>
		</ul>
		
	</div>
</div>
</body>
</html>