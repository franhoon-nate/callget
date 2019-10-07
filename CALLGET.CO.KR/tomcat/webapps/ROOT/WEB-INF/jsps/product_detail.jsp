
<%@page import="model.ProductReviewModel"%>
<%@page import="model.ProductInfoModel"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProductInfoModel pi = (ProductInfoModel) request.getAttribute("pi");
	List<ProductReviewModel> listPR = (List<ProductReviewModel>) request.getAttribute("listPR");
	int reviewTotalCount = (Integer) request.getAttribute("reviewTotalCount");
	
	String adminCheck = (String) request.getAttribute("adminCheck");
	

String piSplit[] = pi.getTag().split(",");
String tag = "";
for(int j=0; j<piSplit.length; j++){
	if(j == 0)	tag = "#"+piSplit[j];
	else		tag+= " #"+piSplit[j];
}
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

<script type="text/javascript">

function productSub(idx){
	for (var i=1; i<=4; i++) {
		if (i==idx) {
			$("#product_sub_btn_"+i).addClass("sub-active");
			$("#product_sub_"+i).css("display", "");
		} else {
			$("#product_sub_btn_"+i).removeClass("sub-active");
			$("#product_sub_"+i).css("display", "none");
		}
	}
	
	if (idx == 1) {
		$(".product-youtube").css("display", "")
	} else {
		$(".product-youtube").css("display", "none")
	}
	
    if (idx == 4) {
        $('.review_writer_box').css('display', 'block');
        $('.review_list_box').css('display', 'block');
    } else {
        $('.review_writer_box').css('display', 'none');
        $('.review_list_box').css('display', 'none');
    }
    
}
</script>

</head>
<body style="padding-top: 100px;">
<jsp:include page="./top_menu.jsp"></jsp:include>

<div class="product-detail-container">
	<div class="product-detail-left">
		<div class="in-thumb">
			<img class="img" src="upload/product/<%=pi.getIdx() %>/<%=pi.getInThumb() %>" />
			<img class="call-tag" src="images/product_call_tag.png" />
		</div>
		
		<div class="product-sub-tab">
			<ul class="product-sub-ul">
				<li class="product-sub-li"><a href="javascript: productSub(1);" id="product_sub_btn_1" class="product-sub-a sub-active">제품 상세설명</a></li>
				<li class="product-sub-li"><a href="javascript: productSub(2);" id="product_sub_btn_2" class="product-sub-a">이용방법</a></li>
				<li class="product-sub-li"><a href="javascript: productSub(3);" id="product_sub_btn_3" class="product-sub-a">Q&A</a></li>
				<li class="product-sub-li"><a href="javascript: productSub(4);" id="product_sub_btn_4" class="product-sub-a">이용후기</a></li>
			</ul>
			<%if("".equals(pi.getYoutube())==false){ %>
			<div class="product-youtube">
				<span class="youtube-title">사은품 소개 영상</span>
				<span class="youtube-sub">*콜겟에서 제작한 영상입니다.</span>
				<div class="youtube-div"><iframe id="youtube_main" src="https://www.youtube.com/embed/<%=pi.getYoutube() %>" width="100%" height="100%" frameborder="0" allow="encrypted-media" allowfullscreen style="position: absolute; top:0; left:0;"></iframe></div>
			</div>
		<%} %>
		<div class="product-detail-line"></div>
			<div class="product-sub-div">
				<!--  
				<img id="product_sub_1" class="product-sub-img" src="upload/product/<%=pi.getIdx() %>/<%=pi.getFeatureThumb() %>" />
				<img id="product_sub_2" class="product-sub-img" style="display: none;" src="upload/product/<%=pi.getIdx() %>/<%=pi.getUseThumb() %>" />
				<img id="product_sub_3" class="product-sub-img" style="display: none;" src="upload/product/<%=pi.getIdx() %>/<%=pi.getQaThumb() %>" />
				<img id="product_sub_4" class="product-sub-img" style="display: none;" src="upload/product/<%=pi.getIdx() %>/<%=pi.getGuaranThumb() %>" />
				-->
				<img id="product_sub_1" class="product-sub-img" src="upload/product/<%=pi.getIdx() %>/<%=pi.getConThumb() %>" />
				<img id="product_sub_2" class="product-sub-img" style="display: none;" src="upload/product/<%=pi.getIdx() %>/<%=pi.getUseThumb() %>" />
				<img id="product_sub_3" class="product-sub-img" style="display: none;" src="upload/product/<%=pi.getIdx() %>/<%=pi.getQaThumb() %>" />
				<!--<img id="product_sub_4" class="product-sub-img" style="display: none;" src="upload/product/<%=pi.getIdx() %>/<%=pi.getGuaranThumb() %>" />-->
				
				<!-- 추가 -->
				
				<div class="review_writer_box" style="display:none;">
					<p>작성하기</p>
					<textarea placeholder="리뷰를 남겨주세요"></textarea>
					<div class="review_writer_user_info_box">
						<input type="text" placeholder="+닉네임" />
						<input type="password" placeholder="+비밀번호" />
						<button idx=<%=pi.getIdx() %>><p>리뷰 등록하기</p></button>
					</div>
				</div>
				
				<div class="review_list_box" style="display:none;">
					<p>REVIEW <span>(<%=reviewTotalCount %>)</span></p>
					
					
					<%for(int i=0; i<listPR.size(); i++){
						ProductReviewModel list = listPR.get(i);
					%>
					
					
					
					<div>
						<div class="review_content"><%=list.getContent() %></div>
						<div class="review_info"><p>작성자</p><span><%=list.getId() %></span></div>
						<div class="review_btns">
							<button att="edit" idx=<%=list.getIdx() %>>수정</button>
							<button att="delete" idx=<%=list.getIdx() %>>삭제</button>
						</div>
					</div>
						
					<%} %>
				</div>
				
				
				<!-- 추가 -->
				
				
				
			</div>
		</div>
		
		<!--<%if("".equals(pi.getYoutube())==false){ %>
			<div class="product-youtube">
				<span class="youtube-title">사은품 소개 영상</span>
				<span class="youtube-sub">*콜겟에서 제작한 영상입니다.</span>
				<div class="youtube-div"><iframe id="youtube_main" src="https://www.youtube.com/embed/<%=pi.getYoutube() %>" width="100%" height="100%" frameborder="0" allow="encrypted-media" allowfullscreen style="position: absolute; top:0; left:0;"></iframe></div>
			</div>
		<%} %>
		<div class="product-detail-line"></div-->
		
		<div class="product-detail-con">
			<!-- <img class="con-img" src="upload/product/<%=pi.getIdx() %>/<%=pi.getConThumb() %>" /> -->
		</div>
	</div>
	<div class="product-detail-right">
		<span class="name"><%=pi.getCompany1() %> X <%=pi.getCompany2() %></span>
		<span class="product-detail-line"></span>
		<span class="tag"><%=tag %></span>
		<span class="description"><%=pi.getDescription().replaceAll("\n", "<br/>") %></span>
		<div class="desc1">
			<span class="desc-text1">본 상품은 <%=pi.getCompany2() %>에서 준비한 상품입니다.</span>
			<span class="desc-text2">현재까지 <span class="desc-text3"><%=pi.getCount() %></span> 이 콜겟 하셨습니다.</span>
		</div>
		<a class="get-btn" href="product.cg?menu=product_insure&idx=<%=pi.getIdx()%>"><img src="images/get.png" /></a>
		<div class="sub-btn-div">
			<a href="about.cg" class="about-btn">콜겟이란?</a>
			<a href="javascript: copyAddress();" class="share-btn" id="copy_btn" data-clipboard-target="#url_copy">공유하기</a>
		</div>
		<input type="text" id="url_copy" style="opacity: 0;" value="http://www.callget.co.kr/product.cg?menu=product_detail&idx=<%=pi.getIdx() %>" />
	</div>
	<div style="width: 100%; clear: both;"></div>
</div>

<jsp:include page="./footer.jsp"></jsp:include>
</body>

<script type="text/javascript">

$(function(){ 
	var $win = $(window); 
	var top = $(window).scrollTop(); 
	
	var speed = 500; 
	var easing = 'swing'; 
	var $layer = $('.product-detail-right'); // 레이어 셀렉팅 
	var layerTopOffset = 0; // 레이어 높이 상한선, 단위:px 
	$layer.css('position', 'relative').css('z-index', '1'); 
	/*사용자 설정 값 끝*/ 
	// 스크롤 바를 내린 상태에서 리프레시 했을 경우를 위해 
	if (top > 0 ) 
		$win.scrollTop(layerTopOffset+top); 
	else 
		$win.scrollTop(0); 
	//스크롤이벤트가 발생하면 
	$(window).scroll(function(){ 
		
		var yPosition = $win.scrollTop() + 100; //이부분을 조정해서 화면에 보이도록 맞추세요
		console.log(yPosition);
		if (yPosition < 0) {
			yPosition = 0; 
		} 
		$layer.animate({"top":yPosition }, {duration:speed, easing:easing, queue:false}); 
	}); 
		
	
	$('.review_writer_user_info_box button').click(function() {
		var rc = $(".review_writer_box textarea").val().trim().replace("\r", "<br>").replace("\n", "<br>");
		var id = $(".review_writer_user_info_box input[type='text']").val().trim();
		var pw = $(".review_writer_user_info_box input[type='password']").val().trim();
		var idx =$ ('.review_writer_user_info_box button').attr('idx').trim(); 
		
		if (rc.length < 1) {
			alert('리뷰가 입력되지 않았습니다.')
		} else if (1000 < rc.length) {
			alert('리뷰는 1000자 이하로 입력해 주세요.')
		} else if (id.length < 1) {
			alert('닉네임이 입력되지 않았습니다.')
		} else if (15 < id.length) {
			alert('아이디는 15자 이하로 입력해 주세요.')
		} else if (pw.length < 4) {
			alert('비밀번호는 4자리 이상으로 입력해 주세요.')
		} else {

			rc = encodeURIComponent(rc);
			id = encodeURIComponent(id);
			pw = encodeURIComponent(pw);
			idx = encodeURIComponent(idx);
			
			var param = "content=" + rc + "&product_idx=" + idx + "&password=" + pw + "&id=" + id;
			
			$.ajax({
				type: "POST",
				url: 'productreviewupload.cg',
				data: param,
				error: ajaxFailed,
				success: function(ret) {
					
					if(ret == 1){
						alert("리뷰가 작성되었습니다.");
						location.reload();
					}
					else{
						alert("리뷰 작성에 실패하였습니다.")
					}	
				}
			}); 
		}
		
	});
		
		
	$('.review_btns button').click(function() {
		var type = $(this).attr('att');
		var idx = $(this).attr('idx');
		
		if (type == "edit") {
			//window.open('/callget/product_review_edit.cg?idx=' + idx,"","width=565,height=300,left=0");
			window.open('product_review_edit.cg?idx=' + idx,"","width=565,height=300,left=0");
		} else if(type == "delete") {
			
			// 관리자의 경우
			if ('<%=adminCheck%>' == '1') {
				if (confirm("관리자 권한으로 삭제하시겠습니까?") == true) {
					
					var param = "idx=" + encodeURIComponent(idx);
					
					$.ajax({
						type: "POST",
						url: 'product_review_delete.cg',
						data: param,
						error: ajaxFailed,
						success: function(ret) {
							if(ret == 1){
								location.reload();
							}
							else{
								alert("리뷰 삭제에 실패하였습니다.")
							}	
						}
					}); 
					
				 } else {
					return false;
				 }
			} else {
				window.open('product_review_delete.cg?idx=' + idx,"","width=565,height=150,left=0");
				//window.open('/callget/product_review_delete.cg?idx=' + idx,"","width=565,height=150,left=0");
			}
		}
	});
	
}); 



function copyAddress(){
	var urlbox = "";
	
    var currentOS;

	// 유저에이전트를 불러와서 OS를 구분합니다.
	var userAgent = navigator.userAgent.toLowerCase();
	if (userAgent.search("android") > -1)
		currentOS = "android";
	else if ((userAgent.search("iphone") > -1) || (userAgent.search("ipod") > -1)|| (userAgent.search("ipad") > -1))
		currentOS = "ios";
	else
		currentOS = "else";

  if(currentOS == "ios"){
	  new ClipboardJS('#copy_btn');
	  alert("주소가 복사 되었습니다.");
  }
  else{
	  $('#url_copy').select();
	  
	  try{
		  var successfull = document.execCommand('copy');
		  alert("주소가 이 복사 되었습니다.");
		  
	  }catch(err){
		  alert('이 브라우저는 지원하지 않습니다.');
	  }
  }
}

function ajaxFailed(xmlRequest){
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}




</script>

</html>