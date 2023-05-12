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
        
        $('#login').click(e => {
        	e.preventDefault()
        	if(isVal($('#comId')) && isVal($('#comPw'))) {
        		checkCom($('#comId').val(), $('#comPw').val())
        	}
        })
    })
    
    function checkCom(id, pw) {
    	$.ajax({
    		url: 'loginCom',
    		data: ({
    			companyId: id,
    			companyPw: pw
    		}),
    		success: company => {
    			if(company.length > 0) {
    				move()
    			} else {
    				error()
    			}
    		}
    	})
    }
    
    function move() {
    	window.location.href = '/company'
    }
    
    function error() {
    	$('#msg').css('color', 'red')
    	$('#msg').text('ID 혹은 비밀번호가 잘못되었습니다.')
    	$('.msgBox').addClass('show')
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
    <div class='row mt-5'>
        <div class='col'>
            <div class='row'>
                <div class='col'></div>
                <div class='col-5'>
                    <form class='form_box'>
                        <input type='text' id='comId' class='form-control' placeholder='아이디'/><br>
                        <input type='password' id='comPw' class='form-control' placeholder='비밀번호'/><br>
                        <div class='msgBox collapse'>
			                <span id='msg'></span><br><br>
		                </div>
                        <input type='submit' id='login' class='form-control btn btn-blue' value='로그인'/><br>
                    </form>
                </div>
                <div class='col'></div>
            </div>
        </div>
        <div class='row mt-5'>
            <div class='col'></div>
            <div class='col-5 text-center'>
                <div class='row'>
                    <div class='col'>
                        <a href='findid'>아이디 찾기</a>
                    </div>
                    |
                    <div class='col'>
                        <a href='findpw'>비밀번호 찾기</a>
                    </div>
                    |
                    <div class='col'>
                        <a href='addcom'>회원가입</a>
                    </div>
                </div>
            </div>
            <div class='col'></div>
        </div>
    </div>
</div>
</body>
</html>