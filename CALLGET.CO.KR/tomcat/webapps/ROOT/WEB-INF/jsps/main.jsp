<%@page import="model.ProductInfoModel"%>
<%@page import="model.TagInfoModel"%>
<%@page import="model.SlideInfoModel"%>
<%@page import="model.TypeInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<SlideInfoModel> listSI = (List<SlideInfoModel>) request.getAttribute("listSI");
	List<TypeInfoModel> listTI = (List<TypeInfoModel>) request.getAttribute("listTI");
	List<TagInfoModel> listTag = (List<TagInfoModel>) request.getAttribute("listTag");
	List<ProductInfoModel> listPI = (List<ProductInfoModel>) request.getAttribute("listPI");
	ProductInfoModel pi = (ProductInfoModel) request.getAttribute("pi");
	int type = (Integer) request.getAttribute("type");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CallGet</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/style.css">

</head>
<body>
<jsp:include page="./top_menu.jsp"></jsp:include>
<div class="section1">
	<div class="section1-container">
		<ul class="section1-slide-ul" id="section1-slide-ul">
			<%for(int i=0; i<listSI.size(); i++){
				SlideInfoModel list = listSI.get(i);
				%>
				<li class="section1-slide-li">
					<img src="upload/slide/<%=list.getIdx() %>/<%=list.getImage() %>" />
					<%if("".equals(list.getLink())==false && list.getLink() != null){ %>
						<a class="section1-slide-link-btn" href="<%=list.getLink()%>" target="_blank"><%=list.getLinkText() %></a>
					<%} %>
				</li>
			<%} %>
			
		</ul>
		<a href="javascript: slideLeft();" class="section1-slide-left-a"><img src="images/left_arrow.png" /></a>
		<a href="javascript: slideRight();" class="section1-slide-right-a"><img src="images/right_arrow.png" /></a>
		<ul class="section-dot-ul">
			<%for(int i=0; i<listSI.size(); i++){
				SlideInfoModel list = listSI.get(i);
				if(i == 0){
				%>
					<li class="section-dot-li dot-active" id="section1-dot-<%=i+1%>" onclick="javascript: goSlideMove(<%=i+1%>);"></li>
				<%}else{ %>
					<li class="section-dot-li" id="section1-dot-<%=i+1%>" onclick="javascript: goSlideMove(<%=i+1%>);"></li>
				<%}
			}%>
			
		</ul>
	</div>
</div>
<div class="section2" >
	<div class="type-container">
		<ul class="type-ul">
			<li class="type-li" onclick="javascript: location.href='main.cg?type=0'"><img class="type-img" src="images/type-all.png" /><span class="type-text">전체보기</span></li>
			<%for(int i=0; i<listTI.size(); i++){
				TypeInfoModel list = listTI.get(i);
				%>
				<li class="type-li" onclick="javascript: location.href='main.cg?type=<%=list.getIdx() %>'"><img class="type-img" src="upload/type/<%=list.getIdx() %>/<%=list.getImage() %>" /><span class="type-text"><%=list.getTitle() %></span></li>	
			<%} %>
			
		</ul>
	</div>
	<div class="tag-container">
		<ul class="tag-ul">
			<%for(int i=0; i<listTag.size(); i++){
				TagInfoModel list = listTag.get(i);
				%>
				<li class="tag-li"><a href="<%=list.getLink() %>" class="tag-a" target="_blank">#<%=list.getTitle() %></a></li>
			<%} %>
		</ul>
	</div>
	
	<div class="product-container" >
		<img src="images/callforyou.png" class="product-title" />
		<ul class="product-ul" id="product_ul">
			<%for(int i=0; i<listPI.size(); i++){
				ProductInfoModel list = listPI.get(i);
				String piSplit[] = list.getTag().split(",");
				String tag = "";
				for(int j=0; j<piSplit.length; j++){
					if(j == 0)	tag = "#"+piSplit[j];
					else		tag+= " #"+piSplit[j];
				}
				%>
				<li class="product-li" onclick="javascript: location.href='product.cg?menu=product_detail&idx=<%=list.getIdx()%>'">
					<div class="product-back" style="background-image: url('upload/product/<%=list.getIdx()%>/<%=list.getListThumb()%>')"></div>
					<div class="product-cover">
						<div class="tack-div"><span class="tack-count"><%=list.getCount() %></span><img class="tack-call" src="images/tack_call.png" /></div>
						<img class="product-one" src="upload/product/<%=list.getIdx() %>/<%=list.getOneThumb() %>" />
						<div class="product-content-div">
							<span class="product-company1"><%=list.getCompany1() %></span>
							<span class="product-x">X</span>
							<span class="product-company2"><%=list.getCompany2() %></span>
							<span class="product-name"><%=list.getName() %></span>
							<span class="product-line"></span>
							<span class="product-tag"><%=tag %></span>
							<span class="product-description"><%=list.getDescription().replaceAll("\n", "<br/>") %></span>
						</div>
					</div>
				</li>
			<%} %>
		</ul>
		<div style="width: 100%; clear: both; height: 0px;">
			
		
		</div>
		<a href="javascript: moreBtn();" class="more-btn"><img src="images/more.png" /></a>
	</div>
	
</div>

<jsp:include page="./footer.jsp"></jsp:include>
</body>

<script type="text/javascript">
var slideListSize = <%=listSI.size()%>;
var slideIdx = 1;

$(document).ready(function() {
	var slideSize = 1480*slideListSize;
	$("#section1-slide-ul").css("width", slideSize+"px");
	setInterval("autoSlideMove()", 5000);
});

function slideLeft(){
	//alert($("#section1-slide-ul").position().left);
	if(slideIdx>1){
		var pLeft = $("#section1-slide-ul").position().left;
		$("#section1-slide-ul").css("left", (pLeft+1480)+"px");
		slideIdx--;
	}
	
	for(var i=1; i<=slideListSize; i++){
		if(i == slideIdx)
			$("#section1-dot-"+i).addClass("dot-active");
		else
			$("#section1-dot-"+i).removeClass("dot-active");
	}
}

function slideRight(){
	//alert($("#section1-slide-ul").position().left);
	if(slideIdx<slideListSize){
		var pLeft = $("#section1-slide-ul").position().left;
		$("#section1-slide-ul").css("left", (pLeft-1480)+"px");
		slideIdx++;
	}
	else{
		$("#section1-slide-ul").css("left", "0px");
		slideIdx = 1;
	}
	for(var i=1; i<=slideListSize; i++){
		if(i == slideIdx)
			$("#section1-dot-"+i).addClass("dot-active");
		else
			$("#section1-dot-"+i).removeClass("dot-active");
	}
}

function goSlideMove(idx){
	var pLeft = (idx-1)*1480;
	$("#section1-slide-ul").css("left", "-"+pLeft+"px");
	slideIdx = idx;
	
}

function autoSlideMove(){
	
	if(slideIdx<slideListSize){
		var pLeft = (slideIdx)*1480;
		$("#section1-slide-ul").css("left", "-"+pLeft+"px");
		slideIdx++;
	}
	else{
		$("#section1-slide-ul").css("left", "0px");
		slideIdx=1;
	}
	
	for(var i=1; i<=slideListSize; i++){
		if(i == slideIdx)
			$("#section1-dot-"+i).addClass("dot-active");
		else
			$("#section1-dot-"+i).removeClass("dot-active");
	}
}

var pageNum = 1;
var type = <%=type%>;
var listCount = <%=pi.getListCount() %>;

function moreBtn(){
	pageNum++;
	
	var param = "mode=product_list&pageNum="+encodeURIComponent(pageNum)+"&type="+encodeURIComponent(type)+"&listCount="+encodeURIComponent(listCount);
	
	$.ajax({
		type: "POST",
		url: "main.cg",
		data: param,
		dataType: 'text',
		success: function(ret){
			var obj = JSON.parse(ret);	
			
			for(var i=0; i<obj.length; i++){
				$("#product_ul").append(
						"<li class=\"product-li\" onclick=\"javascript: location.href='product.cg?menu=product_detail&idx="+obj[i].idx+"'\">" +
							"<div class=\"product-back\" style=\"background-image: url('upload/product/"+obj[i].idx+"/"+obj[i].listThumb+"')\"></div>" +
							"<div class=\"product-cover\">" +
								"<div class=\"tack-div\"><span class=\"tack-count\">"+obj[i].count+"</span><img class=\"tack-call\" src=\"images/tack_call.png\" /></div>" +
								"<img class=\"product-one\" src=\"upload/product/"+obj[i].idx+"/"+obj[i].oneThumb+"\" />" +
								"<div class=\"product-content-div\">" +
									"<span class=\"product-company1\">"+obj[i].company1+"</span>" +
									"<span class=\"product-x\">X</span>" +
									"<span class=\"product-company2\">"+obj[i].company2+"</span>" +
									"<span class=\"product-name\">"+obj[i].name+"</span>" +
									"<span class=\"product-line\"></span>" +
									"<span class=\"product-tag\">"+obj[i].tag+"</span>" +
									"<span class=\"product-description\">"+obj[i].description+"</span>" +
								"</div>" +
							"</div>" +
						"</li>"	
				);
			}
			
		}
	});
}

</script>

</html>