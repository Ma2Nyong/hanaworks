<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css' rel='stylesheet'>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'/>
<title></title>
<script>
    $(() => {
        input_form_comheader()

        $('#showPW').click(e => {
        	e.preventDefault()
            $('#modalMsg').empty()
            if(isVal($('#comId')) && isVal($('#comEmail'))) {
            	findPw($('#comId').val(), $('#comEmail').val())
	            $('#modal').modal('show')
        	}
        })
    })
    
    function findPw(comId, email) {
    	$.ajax({
    		url: 'findPwCom',
    		data: ({
    			companyId: comId,
    			companyEmail: email
    		}),
    		success: pw => {
    			if(pw != '') {
	    			$('#modalMsg').text('비밀번호는 ' + pw + ' 입니다.')
	    			$('#modalLoginBtn').text('로그인').removeAttr('data-bs-dismiss').attr('onclick', 'location.href="/admin/user/login"')
    			} else error()
    		}
    	}).done(() => $('.msgBox').removeClass('show'))
    }

    function error() {
    	$('#modalMsg').empty()
    	$('#modalLoginBtn').text('확인').removeAttr('onclick').attr('data-bs-dismiss', 'modal')
    	$('#modalMsg').text('아이디 혹은 메일주소가 잘못 입력되었습니다.')
    	$('#modal').modal('show')
    }
    
    function isVal(field) {
        let isGood = false
        let errMsg

        if(!field.val()) errMsg = field.attr('placeholder') + ' 입력하세요.'
           else isGood = true

        if(!isGood) {
        	$('.msgBox').addClass('show')
            $('#msg').text(errMsg).css('color', 'red')
        }
        
        return isGood
    }
</script>
<style>
    #showPW {
        margin-top: 3rem;
    }
    
    input[type='submit'] {
        position: relative;
        width: 60%;
        left: 20%;
    }
</style>
</head>
<body>
<div class='container'>
    <div class='row title'></div>
    <div class='text text-center'><h3><b>비밀번호 찾기</b></h3></div>
    <div class='row mt-5'>
        <div class='col'>
            <div class='row'>
                <div class='col'></div>
                <div class='col-5'>
                    <form class='form_box'>
                        <input type='text' id='comId' class='form-control' placeholder='아 이 디'/><br>
                        <input type='text' id='comEmail' class='form-control' placeholder="대 표 메 일"/><br>
                        <div class='msgBox collapse'>
			             	<span id='msg'></span><br><br>
			            </div>
                        <input type='submit' id='showPW' class='btn btn-blue text-center' value='비밀번호 찾기'/><br>
                    </form>
                </div>
                <div class='col'></div>
            </div>
        </div>
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
                <button type='button' class='btn btn-blue' id='modalLoginBtn' onclick='location.href="/admin/user/login"'>로그인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>