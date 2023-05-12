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
<title>직원 추가</title>
<script>
 let companyId = "${sessionScope.comId}"

function errMsgClear() {
    $('#idErrMsg, #pwErrMsg, #pwCheckErrMsg, #nameCheckErrMsg, #addrErrMsg, #emailErrMsg, #empPhErrMsg,#hireDateErrMsg,#empPinoCheckErrMsg').empty()
}
 const regex = {
		 empName: /^[가-힣]+$/,
		 empId: /^[a-zA-Z0-9]{1,15}$/,
		 empPw: /^[a-zA-Z0-9!@#$%^&*()?_~]{6,15}$/,
		 empPino: /^[0-9]{13}$/,
		 inputEmail: /^[a-zA-Z0-9._%+-]+$/,
		 subEmail: /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
		 empPh: /^[0-9]{7,12}$/,
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


	let checkId 
	let checkIdVal
	
	$(() => {
	    input_form_header()
	     $('.form_box').off('click').on('click', '#addEmpBtn', function() {
	    	event.preventDefault()
      		errMsgClear()
      		
      		const empId = $('#empId')
	        const empPw = $('#empPw')
	        const empPwCheck = $('#empPwCheck')
	        const empName = $('#empName')	      
	        const empPostcode = $('#empPostcode')
	        const empAddr = $('#empAddr')
	        const empDetailAddr = $('#empDetailAddr')
	        const inputEmail = $('#inputEmail')
	        const subEmail = $('#subEmail')
	        const empEmail = inputEmail.val() + '@' + subEmail.val()
	        const empPh = $('#empPh')
			const empPino = $('#empPino')
			const empPosition = $('#empPosition')
			const hireDate = $('#hireDate')
			const profileName = $('#profileName')						
			
	        const isEmpId = isVal(empId, $('#idErrMsg'), 'ID를 입력하세요.',regex.empId)
	        const isEmpPw = isVal(empPw, $('#pwErrMsg'), '비밀번호를 입력하세요.',regex.empPw)
	        const isEmpPwCheck = isVal(empPwCheck, $('#pwCheckErrMsg'), '비밀번호 확인을 입력하세요.',regex.empPw)
	        const isEmpName = isVal(empName, $('#nameCheckErrMsg'), '이름을 입력하세요.', regex.empName)
	        const isEmpPino = isVal(empPino, $('#empPinoCheckErrMsg'), '주민번호를 입력하세요.',regex.empPino)
	        const isEmpAddr = isVal(empAddr, $('#addrErrMsg'), '주소를 입력하세요.')
	        const isInputEmail = isVal(inputEmail, $('#emailErrMsg'), '이메일을 입력하세요.', regex.inputEmail);
			const isSubEmail = isVal(subEmail, $('#emailErrMsg'), '이메일을 입력하세요.', regex.subEmail);
	        const isEmpPh = isVal(empPh, $('#empPhErrMsg'), '전화번호를 입력하세요.', regex.empPh)
	        const isHireDate = isVal(hireDate,$('#hireDateErrMsg'),'입사일을 입력하세요')
	        
	        if (isEmpId && isEmpPw && isHireDate && isEmpPwCheck && isEmpName && isEmpPino && isEmpAddr  && isInputEmail && isSubEmail && isEmpPh) {
	        	let profile = ""
		        	
	        	if(profileName.val().length > 1) {
					const strProfileName = profileName.val().split('fakepath\\')
	                profile = strProfileName[1]
				}
                
	            let employee = {
	                empId: empId.val(),
	                empPw: empPw.val(),
	                empName: empName.val(),
	                empAddr: empAddr.val(),
	                empDetailAddr: empDetailAddr.val(),
	                empPostcode: empPostcode.val(),
	                empPh: empPh.val(),
	                empEmail: empEmail,
	                hireDate:hireDate.val(),
	                empPosition: empPosition.val(),
	                empPino: empPino.val(),
	                profileName: profile,
	                companyId: companyId
	            }
	            
	            if(checkId != 0 && checkIdVal == $('#empId').val()) {
		            if(empPw.val() == empPwCheck.val()) {
		            	if (6 <=  empPw.val().length && empPw.val().length <= 15) {
		                    if(empPino.val().length == 13) {
			        	$.ajax({
			                url: '/admin/user/addemp/add',
			                type: 'post',
			                contentType: 'application/json',
			                data: JSON.stringify(employee),
			                success: $('form').submit()
			            });
		                   }else{
		                	   $('#empPinoCheckErrMsg').text('주민등록번호는 13자리로 입력하세요.').css('color', 'red')
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
        
        $('.form_box').on('click', '#empIdCheck', function() {
            const empId = $('#empId').val();
            const isEmpId = isVal($('#empId'), $('#idErrMsg'), 'ID를 입력하세요.',regex.empId)
			
            if(isEmpId) {
            	if(empId) {
                	
    	            $.ajax({
    	                url: '/admin/user/addemp/check',
    	                type: 'get',
    	                data: {empId: empId},
    	                success: function(result) {
    	                    if (result == '1') {
    	                    	checkId = 0;
    	                    	
    	                    	$('#idErrMsg').text('이미 사용중인 ID입니다.').css('color', 'red');
    	                    } else {
    	                    	checkId = 1;
    	                    	checkIdVal = $('#empId').val()
    	                    	$('#idErrMsg').text('사용 가능한 ID입니다.').css('color', 'green');
    	                    }
    	                }
    	            })
                } else {
                	$('#idErrMsg').text('ID를 입력하세요.').css('color', 'red')
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
                    document.getElementById('empAddr').value = extraAddr;
                
                } else {
                    document.getElementById('empAddr').value = '';
                }

                document.getElementById('empPostcode').value = data.zonecode;
                document.getElementById('empAddr').value = addr;
                document.getElementById('empDetailAddr').focus();
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
    #empIdCheck{
    	color:black;
    	border-radius:0.5rem;
    	width:7rem;
    	background-color:lightgray;
    	margin-left:0.5rem;
    }    
    #searchpost{
      background-color: lightgray;
        color: black;
        margin-left: 1rem;    
    }
     #empAddr{
      margin-top: 0.5rem;
    }
    
    #empDetailAddr {
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
              <form class='form_box' action='profil' method='post' enctype="multipart/form-data">
                <label for='userName'>이름</label>
                    <input type='text' class='form-control' id='empName'>
                <span id='nameCheckErrMsg'></span><br>
                <label for='empPino'>주민번호</label>
                <input type='number' class='form-control' maxlength='13' id='empPino' placeholder='-제외'>
                <span id ='empPinoCheckErrMsg'></span><br>
                <label for='input-id'>아이디</label>
                <div class='input-group'>
                  <input type='text' class='form-control' id='empId' maxlength='12' name='id' placeholder='숫자, 문자 포함 12자이하로 입력하세요'>
                  <button class='btn' type='button' id='empIdCheck'>중복확인</button>
                </div>
                <span id='idErrMsg'></span><br>              
                <label for='password'>비밀번호</label>
                <input type='password' class='form-control'  maxlength='15' id='empPw' placeholder='숫자, 문자 포함 6자이상 15자이하로 입력하세요'>
                <span id='pwErrMsg'></span><br>
                <label for='password_confirm'>비밀번호 확인</label>
                <input type='password' class='form-control' id='empPwCheck' placeholder='비밀번호를 다시 입력하세요'>
                <span id='pwCheckErrMsg'></span><br>
                <div class='form-group'>
                    <label for='input-email'>이메일주소</label>
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
                <label for='phoneNumber'>전화번호</label>
                <input type='tel' class='form-control' id='empPh' placeholder='-제외'>
                <span id='empPhErrMsg'></span><br>
                <div class='form-group'>
                    <label for='input-postcode'>주소</label>
                    <div class='input-group '>
                      <input type='number' class='form-control' id='empPostcode' name='postcode' placeholder='우편번호'>
                      <div class='input-group-append'>
                        <button class='btn' type='button' onclick='DaumPostcode()' id='searchpost'>우편번호찾기</button>
                      </div>
                    </div>
                    <div class='input-group'>
                      <input type='text' id='empAddr' class='form-control' name='extraAddress'>
                      <input type='text' id='empDetailAddr' class='form-control' name='detailAddress' placeholder='상세주소'>         
                    </div>                 
                </div>
                <span id='addrErrMsg'></span><br>
                <label for='date of employment'>입사일</label>
                <input type='date' class='form-control' id='hireDate'>
                <span id='hireDateErrMsg'></span><br>
                <div class='filebox'>
                <label for='profil'>프로필</label>
                <div class='input-group'>
                <input type='file' class='form-control' id='profileName' name='profil'>                                                          
                </div>
                </div>                             
                <label for='empPosition'>직급</label>
                  <input type='text' class='form-control' id='empPosition'>                
                <br>
                <button type='submit' id='addEmpBtn' class='btn btn-blue text-center'>직 원 등 록</button><br>
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