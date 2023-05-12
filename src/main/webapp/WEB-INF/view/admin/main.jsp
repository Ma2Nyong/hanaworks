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
	let session = '${sessionScope.comId}'
	
    $(() => {
        input_company_header()
        input_footer()
        btn_click()
		
        if(session != '') {
            show_logout()
        }
    })
    
    function no_introduce() {
		$('.introduce').addClass('show')
		$('.intro_img').removeClass('show')
	}
</script>
<style>
    .introduce {
        padding: 9rem;
        border: .1rem solid;
    }
</style>
</head>
<body>
<div class='container'>
    <div class='row header'>
        
    </div>
    <div class='row'>
        <div class='text-center mt-5 introduce collapse'>
                회사소개이미지
        </div>
        <img src="/attach/intro_img.png" class="intro_img collapse show" onerror="no_introduce()" />
    </div>
    <div class='footer'>
       
    </div>
</div>
</body>
</html>