<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
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
	let session = ${sessionScope.empNo}
	
	$(() => {
		input_user_header()
		btn_click()
		
		mp_check()
	})
	
	function mp_check() {
		if(session > 0) {
			show_logout()
		} else {
			show_login()
		}
	}
	
	function no_introduce() {
		$('.introduce').addClass('show')
		$('.intro_img').removeClass('show')
	}
</script>
<style>
	.introduce {
        height: 12rem;
        border: .1rem solid;
        line-height: 12rem;
    }
    .intro_img {
    	width: 100%;
    	height: auto;
    	margin-bottom: 3rem;
    }
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-4'>
        <div class='col'>
            <div class='text-center mt-5 introduce collapse'>
                회사소개이미지
            </div>
            <img src="/attach/intro_img_m.png" class="intro_img collapse show" onerror="no_introduce()" />
        </div>
    </div>
    <div class='navigation'></div>
</div>
</body>
</html>