<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css' rel='stylesheet'>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css'>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css'/>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title>회사 회원가입</title>
<script>
	function errMsgClear() {
	    $('#idErrMsg, #pwErrMsg, #pwCheckErrMsg, #nameCheckErrMsg, #regnoErrMsg, #addrErrMsg, #presidentErrMsg, #emailErrMsg, #phErrMsg').empty()
	}
	const regex = {
			 comName: /^[가-힣a-zA-Z0-9]+$/,
			 companyId: /^[a-zA-Z0-9]{1,15}$/,
			 comPw: /^[가-힣a-zA-Z0-9!@#$%^&*()?_~]{6,15}$/,
			 comRegno: /^[0-9]{10}$/,
			 inputEmail: /^[a-zA-Z0-9._%+-]+$/,
			 subEmail: /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
			 comPh: /^[0-9]{7,12}$/,			 
			 president:/^[가-힣a-zA-Z]+$/
	}
	 
	 function isVal(field, errorElement, errMsg, pattern) {
		  let isVal = false;

		  if (!field.val()) {
		    errorElement.empty().text(errMsg).css('color', 'red');
		  } else if (pattern && !pattern.test(field.val())) {
		    errorElement.empty().text('올바른 형식으로 입력해주세요.').css('color', 'red');
		  } else {
		    isVal = true;
		  }

		  return isVal;
		}
	
	let checkId = 0;
	let checkIdVal
	
    $(() => {
        input_form_comheader()
        $('.form_box').off('click').on('click', '#addCompanyBtn', function() {
      		errMsgClear()
        
	        const companyId = $('#companyId')
	        const comPw = $('#comPw')
	        const comPwCheck = $('#comPwCheck')
	        const comName = $('#comName')
	        const comRegno = $('#comRegno')
	        const comPostcode = $('#comPostcode')
	        const comAddr = $('#comAddr')
	        const comDetailAddr = $('#comDetailAddr')
	        const president = $('#president')
	        const inputEmail = $('#inputEmail')
	        const subEmail = $('#subEmail')
	        const comEmail = inputEmail.val() + '@' + subEmail.val()
	        const comPh = $('#comPh')
	
	        const isCompanyId = isVal(companyId, $('#idErrMsg'), '회사 ID를 입력하세요.',regex.companyId)
	        const isComPw = isVal(comPw, $('#pwErrMsg'), '비밀번호를 입력하세요.',regex.comPw)
	        const isComPwCheck = isVal(comPwCheck, $('#pwCheckErrMsg'), '비밀번호 확인을 입력하세요.')
	        const isComName = isVal(comName, $('#nameCheckErrMsg'), '회사명을 입력하세요.',regex.comName)
	        const isComRegno = isVal(comRegno, $('#regnoErrMsg'), '사업자등록번호를 입력하세요.',regex.comRegno)
	        const isComAddr = isVal(comAddr, $('#addrErrMsg'), '회사 주소를 입력하세요.')
	        const isPresident = isVal(president, $('#presidentErrMsg'), '대표자명을 입력하세요.',regex.president)
	        const isInputEmail = isVal(inputEmail, $('#emailErrMsg'), '이메일을 입력하세요.', regex.inputEmail)
	        const isSubEmail = isVal(subEmail, $('#emailErrMsg'), '이메일을 입력하세요.', regex.subEmail)
	        const isComPh = isVal(comPh, $('#phErrMsg'), '전화번호를 입력하세요.',regex.comPh)
			
	        if (isCompanyId && isComPw && isComPwCheck && isComName && isComRegno && isComAddr && isPresident && isInputEmail && isSubEmail && isComPh) {
	            let company = {
	                companyId: companyId.val(),
	                comPw: comPw.val(),
	                comName: comName.val(),
	                comRegno: comRegno.val(),
	                comPostcode: comPostcode.val(),
	                comAddr: comAddr.val(),
	                comDetailAddr: comDetailAddr.val(),
	                president: president.val(),
	                comEmail: comEmail,
	                comPh: comPh.val()
	            }
	            
	            if(checkId != 0 && checkIdVal == $('#companyId').val()) {	            	
		            if(comPw.val() == comPwCheck.val()) {
		            if (6 <=  comPw.val().length && comPw.val().length <= 15){
		            	if(comRegno.val().length == 10){		           
			        	$.ajax({
			                url: 'addcom/add',
			                type: 'post',
			                contentType: 'application/json',
			                data: JSON.stringify(company),
			                success: window.location.href = '/admin/user/login'
			            });
		            	}else{
		            		$('#regnoErrMsg').text('사업자번호는 10자리로 입력하세요.').css('color', 'red')
		            	}
		            }else{
		            	$('#pwErrMsg').text('비밀번호는 6자 이상, 15자 이하로 입력해주세요.').css('color', 'red')
		            }
		            } else {
		        		$('#pwCheckErrMsg').text('비밀번호가 일치하지 않습니다.').css('color', 'red')
		            }
	            } else {
	            	$('#modalMsg').empty()
	            	$('#modalMsg').text('아이디를 중복확인하세요.')
                    $('#modalBtn').hide()
                    $('#modal').modal('show')
	            }
	            
	        }
        })
        
        $('.form_box').on('click', '#companyIdCheck', function() {
            const companyId = $('#companyId').val();
            const isCompanyId = isVal($('#companyId'), $('#idErrMsg'), 'ID를 입력하세요.',regex.companyId)
           
 			if(isCompanyId){           
            if(companyId) {
            	
	            $.ajax({
	                url: '/admin/user/addcom/check',
	                type: 'get',
	                data: {companyId: companyId},
	                success: function(result) {
	                    if (result == '1') {
	                    	checkId = 0;
	                    	
	                    	$('#idErrMsg').text('이미 사용중인 회사 ID입니다.').css('color', 'red');
	                    } else {
	                    	checkId = 1;
	                    	checkIdVal = $('#companyId').val()
	                    	$('#idErrMsg').text('사용 가능한 회사 ID입니다.').css('color', 'green');
	                    }
	                }
	            })
            } else {
            	$('#idErrMsg').text('회사 ID를 입력하세요.').css('color', 'red')
            }
 		}
        })
    })
    
    function selfChoice() {
    	$('#subEmail').val('')
    }
    
    function naverChoice() {
    	$('#subEmail').val('naver.com')
    	
    }
    
    function daumChoice() {
    	$('#subEmail').val('daum.net')
    }
    
    function gmailChoice() {
    	$('#subEmail').val('gmail.com')
    }
    function DaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                var extraAddr = '';
                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }
                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById('comAddr').value = extraAddr;
                
                } else {
                    document.getElementById('comAddr').value = '';
                }
                document.getElementById('comPostcode').value = data.zonecode;
                document.getElementById('comAddr').value = addr;
                document.getElementById('comDetailAddr').focus();
            }
        }).open();
    }
</script>
<style>
    form {
      margin-bottom: 7rem;
    }
    label {
      line-height: 1.6rem;
    }
    
    #companyIdCheck{
      color: black;
      border-radius: 0.5rem;
      width: 7rem;
      background-color: lightgray;
      margin-left: 0.5rem;
    }
    
    #searchpost{
      background-color: lightgray;
      color: black;
      margin-left: 1rem;    
    }
    
    #comAddr{
      margin-top: 0.5rem;
    }
    
    #comDetailAddr {
      margin-left: .5rem;
      margin-top: .5rem;
    }
    
    #dropdown{
      margin-left: 0.5rem;
    }
    
    input[type=number]::-webkit-outer-spin-button,
	input[type=number]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	
</style>
</head>
<body>
<div class='container'>
    <div class='row title'></div>
    <div class='row p-5'>
        <div class='col'>
              <form class='form_box'>
                <label for='input-id'>아이디</label>
                <div class='input-group'>
                  <input type='text' class='form-control' id='companyId' name='id' placeholder='숫자, 문자 포함 12자이하로 입력하세요'>
                  <button class='btn' type='button' id='companyIdCheck'>중복확인</button>
                </div>
                <span id='idErrMsg'></span><br>
                <label for='password'>비밀번호</label>
                <input type='password' class='form-control' id='comPw' placeholder='숫자, 문자 포함 6자이상 15자이하로 입력하세요'>
                <span id='pwErrMsg'></span><br>
                <label for='password_confirm'>비밀번호 확인</label>
                <input type='password' class='form-control' id='comPwCheck' placeholder='비밀번호를 다시 입력하세요'>
                <span id='pwCheckErrMsg'></span><br>
                <label for='company_name'>회사명</label>
                <input type='text' class='form-control' id='comName' placeholder='-제외'>
                <span id='nameCheckErrMsg'></span><br>
                <label for='company_number'>사업자번호</label>
                <input type='number' class='form-control' id='comRegno' placeholder='-제외'>
                <span id='regnoErrMsg'></span><br>
                <div class='form-group'>
                    <label for='input-postcode'>주소</label>
                    <div class='input-group '>
                      <input type='number' class='form-control' id='comPostcode' name='postcode' placeholder='우편번호'>
                      <div class='input-group-append'>
                        <button class='btn' type='button' onclick='DaumPostcode()' id='searchpost'>우편번호찾기</button>
                      </div>
                    </div>
                    <div class='input-group'>
                      <input type='text' id='comAddr' class='form-control' name='extraAddress'>
                      <input type='text' id='comDetailAddr' class='form-control' name='detailAddress' placeholder='상세주소'>         
                    </div>                 
                </div>
                <span id='addrErrMsg'></span><br>
                <label for='president'>대표자명</label>
                <input type='text' class='form-control' id='president' >
                <span id='presidentErrMsg'></span><br>
                <div class='form-group'>
                    <label for='input-email'>대표 메일</label>
                    <div class='input-group'>
                        <input type='text' class='form-control' id='inputEmail'>
                        <h4>&nbsp; @ &nbsp;</h4>
                        <input type='text' class='form-control' id='subEmail'>
                        <div class='dropdown'>
                          <button type='button' class='btn dropdown-toggle' data-bs-toggle='dropdown'></button>
                          <div class='dropdown-menu'>
                              <a class='dropdown-item' onclick='selfChoice()'>직접입력</a>
                              <a class='dropdown-item' onclick='naverChoice()'>naver.com</a>
                              <a class='dropdown-item' onclick='daumChoice()'>daum.net</a>
                              <a class='dropdown-item' onclick='gmailChoice()'>gmail.com</a>
                          </div>
                        </div>
                    </div>
                </div>
                <span id='emailErrMsg'></span><br>
                <label>대표 전화번호</label>
                <input type='number' class='form-control' id='comPh' placeholder='-제외'>
                <span id='phErrMsg'></span><br>
                <br>
                <button type='button' id='addCompanyBtn' class='btn btn-blue text-center'>회 원 가 입</button><br>
            </form>
        </div>
        <div class='navigation'></div>
    </div>
</div>
<div class='modal fade' id='modal'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='btn-close' data-bs-dismiss='modal'></button>
            </div>
            <div class='modal-body'>
                <p id='modalMsg'></p>
            </div>
            <div class='modal-footer' id='modalBtn'>
                <button type='button' class='btn btn-lightgray' id='modalCancelBtn' data-bs-dismiss='modal'>취소</button>
                <button type='button' class='btn btn-blue' id='modalOKBtn'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>