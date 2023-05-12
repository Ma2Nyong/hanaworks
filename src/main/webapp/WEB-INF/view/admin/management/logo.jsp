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
<title>로고</title>
<script>
    $(() => {
    	input_admin_header()
        input_admin_sidebar()
        btn_click()
    })
</script>
<style>
	form {
		width: 60%;
		margin: 0 auto;
		margin-top: 2rem;
	}
	input[type=submit] {
		margin-top: .2rem;
	}
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-5'>
    	<div class='col-2 snb'></div>
    	<div class='col'>
	    	<form action="logo" method="post" enctype="multipart/form-data">
	    		<label>회사 로고 등록</label>
			  	<input type="file" class="form-control" name="file">
				<input type="submit" class="form-control" value='로고등록'>
			</form>
			<form action="logo_m" method="post" enctype="multipart/form-data">
				<label>이용자 로고 등록</label>
			  	<input type="file" class="form-control" name="file">
				<input type="submit" class="form-control" value='모바일 로고등록'>
			</form>
			<form action="intro" method="post" enctype="multipart/form-data">
				<label>회사 소개 등록</label>
			  	<input type="file" class="form-control" name="file">
				<input type="submit" class="form-control" value='소개 등록'>
			</form>
			<form action="intro_m" method="post" enctype="multipart/form-data">
				<label>이용자용 회사 소개 등록</label>
			  	<input type="file" class="form-control" name="file">
				<input type="submit" class="form-control" value='모바일 소개 등록'>
			</form>
			<form action="emp_img" method="post" enctype="multipart/form-data">
				<label>사원 기본 이미지</label>
			  	<input type="file" class="form-control" name="file">
				<input type="submit" class="form-control" value='사원 기본 이미지 등록'>
			</form>
    	</div>
    </div>
    <div class='footer'>
       
    </div>
</div>
</body>
</html>