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
        input_form_header()
        
        $('.center_logo_txt').removeAttr('onclick')
        $('.center_logo').removeAttr('onclick')
        
        $('#login').click(e => {
        	e.preventDefault()
        	if(isVal($('#adminId')) && isVal($('#adminPw'))) {
        		checkAdmin($('#adminId').val(), $('#adminPw').val())
        	}
        })
    })
    
    function checkAdmin(id, pw) {
    	$.ajax({
    		url: 'loginAdmin',
    		data: ({
    			adminId: id,
    			adminPw: pw
    		}),
    		success: admin => {
    			if(admin.length > 0) {
    				move()
    			} else error()
    		}
    	})
    }
    
    function move() {
    	window.location.href = '/admin/notice/admntclist'
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
<title></title>
<style>
    .btn {
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
    <div class='row mt-5'>
        <div class='col'>
            <div class='row'>
                <div class='col'></div>
                <div class='col-5'>
                    <form class='form_box'>
                        <input type='text' id='adminId' class='form-control' placeholder='아이디'/><br>
                        <input type='password' id='adminPw' class='form-control' placeholder='비밀번호'/><br>
                        <div class='msgBox collapse'>
			                <span id='msg'></span><br><br>
		                </div>
                        <input type='submit' id='login' class='form-control btn btn-blue' value='로그인'/><br>
                    </form>
                </div>
                <div class='col'></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>