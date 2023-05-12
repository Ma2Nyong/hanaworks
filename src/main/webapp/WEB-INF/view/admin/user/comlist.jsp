<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css' rel='stylesheet'>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title>기업회원목록</title>
<script>
	function listCompanys() {
		$('input').not(':button').val('')
		$('#companys').empty();
		
		$.ajax({
			url: 'comlist/get',
			dataType: 'json',
			success: companys => {
				if(companys.length) {
					const companyArr = [];
					
					$.each(companys, (i, company) => {
						companyArr.unshift(`
						   <tr>
							    <td><input type='button' value='상세보기' onclick="location.href='getcom?companyId=\${company.companyId}'"></td>
							    <td>\${company.comName}</td>
							    <td>\${company.comPh}</td>
								<td>\${company.president}</td>
								<td>\${company.comAddr + ' ' + company.comDetailAddr}</td>
								<td>\${company.comEmail}</td>
						   </tr>	
						`)
					})
					
					 $('#companys').append(companyArr.join(''));
				} else {
					 $('#companys').append('<tr><td colspan=7 class=text-center>회원이 없습니다.</td></tr>');
				}
			}
		})
	}
	
	 $(() => {
	        input_admin_header()
	        input_admin_sidebar()
	        input_footer()
	        listCompanys()
	    })
</script>
<style>
     input[type='button'] {
        width: 5rem;
        height: 1.5rem;
        border-radius: 1rem;
        line-height: 1.5rem;
        padding: 0;
        border: .01rem solid gray;
        box-sizing: content-box;
    }
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-5'>
        <div class='col-2 snb'></div>
        <div class='col'>
            <div class='row'>
                <div class='col'>
                    <h3><b>회원조회</b></h3>
                </div>
            </div>
            <div class='row pt-3'>
                <div class='col'>
                    <table class='table'>
                        <thead>
                            <tr><th>상세보기</th><th>회사명</th><th>전화번호</th><th>대표자</th><th>주소</th><th>이메일</th></tr>  
                        </thead>
                        <tbody id='companys'>
                           
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class='footer'></div>
</div>