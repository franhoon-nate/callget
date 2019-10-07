<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">
function requestOpen(){
	var requestH = document.getElementById('request-div').style.height;
	if(requestH == "0px")
		document.getElementById('request-div').style.height = "170px";
	else{
		document.getElementById('request-div').style.height = "0px";
		document.getElementById('agree-div').style.height = "0px";
	}
}

function openAgree(){
	document.getElementById('agree-div').style.height = "120px";
}

function closeAgree(){
	document.getElementById('agree-div').style.height = "0px";
}

function checkChange(){
	if(document.getElementById('agree-checkbox').checked == true)
		document.getElementById('agree1').checked = true;
	else
		document.getElementById('agree2').checked = true;
}
function agreeChange(){
	if(document.getElementById('agree1').checked == true)
		document.getElementById('agree-checkbox').checked = true;
	else
		document.getElementById('agree-checkbox').checked = false;
}

function requestSubmit(){
	var name = document.getElementById('name').value;
	var email = document.getElementById('email').value;
	var phone1 = document.getElementById('phone1').value;
	var phone2 = document.getElementById('phone2').value;
	var phone3 = document.getElementById('phone3').value;
	var content = document.getElementById('content').value;
	var agreecheck = document.getElementById('agree-checkbox').checked;
	
	if(name == ""){
		alert("성명을 입력하세요.");
		return;
	}
	
	if(email == ""){
		alert("이메일을 입력하세요.");
		return;
	}
	
	if(phone2 == ""){
		alert("휴대폰 중간번호를 입력하세요.");
		return;
	}
	
	if(phone3 == ""){
		alert("휴대폰 뒷 번호를 입력하세요.");
		return;
	}
	
	if(content == ""){
		alert("문의 내용을 입력하세요.");
		return;
	}
	
	if(agreecheck == false){
		alert("개인정보 취급방침에 동의해주세요.");
		return;
	}
	
	if(confirm("문의사항을 제출하시겠습니까?")==false)
		return;
	
	var phone = phone1+"-"+phone2+"-"+phone3;
	
	var param = "mode=request_submit&name="+encodeURIComponent(name)+"&email="+encodeURIComponent(email)+"&phone="+encodeURIComponent(phone)
				+"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'main.cg',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			alert("문의 등록이 완료되었습니다.");
			location.reload();

		}
	}); 
}


function ajaxFailed(xmlRequest){
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}

</script>
</head>
<body>
<div style="width: 100%; clear: both; height: 100px;"></div>
<div id="agree-div" style="width: 100%; height: 0px; background-color: rgba(25, 25, 25, 0.7); position: absolute; bottom: 270px; overflow: hidden; transition: 0.3s;">
	<div style="width: 836px; height: 120px; position:absolute; top: 0; left: 50%; transform: translateX(-50%); ">
			<div style="position: absolute; top: 14px; left: 0; background-image: url('images/agree_title.png'); width: 106px; height: 36px;">
				
			</div>
			<a href="javascript: closeAgree();" style="position: absolute; top: 14px; right: 71px; width: 33px; height: 33px; display: block;">
				<img src="images/agree_close.png" style="display: block; width: 33px; height: 33px;" />
			</a>
			<div style="width: 600px; height: 120px; margin: 0 auto; position: relative;">
				<div style="width: 100%; height: 88px; position: absolute; top: 14px;">
					<div style="width: 100%; height: 68px; background-color: #ffffff; overflow-x: hidden; position: relative;">
						<p style="font-family: 'NotoR', sans-serif; font-size: 12px; line-height: 16px; padding: 15px;">
						개인정보 동의 입력내용.	
					</p>
				</div>
				<div style="width: 100%; height: 20px; background-color: #000000; position: relative;">
					<p style="padding-left: 12px; font-family: 'NotoR', sans-serif; color: #ffffff; position: relative; line-height: 20px; font-size: 12px;">
						동의를 거부할 수 있으며, 동의 거부시에는 해당서비스 이용이 제한됩니다.
					</p>
					
					<span style="display: block;height: 20px; line-height: 20px; position: absolute; right: 100px; top:0px; font-size: 12px; font-family: 'NotoR', sans-serif; color: white; cursor: pointer;">
						<input type="radio" name="agree_radio" id="agree1" style="margin-bottom: 3px; float: left;" checked="checked" onchange="javascript: agreeChange();"/>
						<label for="agree1" style="display: block; cursor: pointer; float: left;">동의함</label>
					</span>
					
					<span style="display: block;height: 20px; line-height: 20px; position: absolute; right: 20px; top:0px; font-size: 12px; font-family: 'NotoR', sans-serif; color: white; cursor: pointer;">
						<input type="radio" name="agree_radio" id="agree2" style="margin-bottom: 3px;" onchange="javascript: agreeChange();"/>
						<label for="agree2" style="cursor: pointer;">동의안함</label>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="request-div" id="request-div" style="height: 0px;">
	<div class="request-container">
		<img class="request-title" src="images/request_title.png" />
		<div class="request-input-div">
			<div class="left-input-container">
				<div class="left-top">
					<span class="left-text" style="width: 64px; float: left;">성명</span>
					<input type="text" style="width: 250px; float: right; height: 28px;" id="name" name="name" />
				</div>
				<div class="left-bottom">
					<span class="left-text" style="width: 64px; float: left;">핸드폰</span>
					<select style="width: 70px; height: 28px; float: left;" id="phone1" name="phone1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="019">019</option>
					</select>
					<span style="width: 20px; float: left; text-align: center;">-</span>
					<input type="text" style="width: 70px; float: left; height: 28px;" id="phone2" name="phone2" maxlength="4" />
					<span style="width: 20px; float: left; text-align: center;">-</span>
					<input type="text" style="width: 70px; float: left; height: 28px;"  id="phone3" name="phone3" maxlength="4" />
				</div>
				<div class="left-agree" style="padding-left: 64px; margin-top: 16px;">
					<div class="checkbox-container">
						<input type="checkbox" id="agree-checkbox" onchange="javascript: checkChange()" >
						<label for="agree-checkbox" style="color: #ffffff; font-size: 10px; cursor: pointer;" onclick="javascript: openAgree();">개인정보 취급 방침에 동의합니다. [자세히 보기]</label>
					</div>
				</div>
			</div>
			<div class="right-input-container">
				<div class="right-top">
					<span class="right-text" style="width: 84px; float: left;">이메일</span>
					<input type="text" style="width: 250px; float: right; height: 28px;"  id="email" name="email" />
				</div>
				<div class="right-bottom">
					<span class="right-text" style="width: 84px; float: left;">문의내용</span>
					<textarea style="width: 250px; height: 76px; float: right;" id="content" name="content"></textarea>
				</div>
			</div>
		</div>
		<a class="request-btn" href="javascript: requestSubmit();">문의하기</a>
	</div>
</div>
<div class="footer" id="footer">
	<div class="footer-container">
		<img class="footer-info" src="images/footer.png" />
		<a href="javascript: requestOpen();" class="footer-btn">제휴 문의</a>
	</div>
</div>
</body>
</html>