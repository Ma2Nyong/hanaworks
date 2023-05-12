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
<title>기업회원조회</title>
<script>
	const urlParams = new URLSearchParams(window.location.search);
	const companyId = urlParams.get('companyId');
		
	function listCompanys() {
		$.ajax({
			url: 'getinfo/get',
			method: 'get',
			dataType: 'json',
			data: {
				companyId: companyId
			},
			success: companys => {
				if (companys.length) {
				const companyArr = [];
				
				$.each(companys, (i, company) => {
					const passwordLength = company.comPw.length
					  let password = ''
					  for (let i = 0; i < passwordLength; i++) {
					    password += '*'
					  }
				
					companyArr.unshift(`
						<tr>
					        <td>아이디</td>
					        <td>\${company.companyId}</td>
					    </tr>
					    <tr>
					        <td>비밀번호</td>
					        <td>\${password}</td>
					    </tr>
					    <tr>
					        <td>회사명</td>
					        <td>\${company.comName}</td>
					    </tr>
					    <tr>
					        <td>사업자번호</td>
					        <td>\${company.comRegno}</td>
					    </tr>
					    <tr>
							<td>주소</td>
					        <td>\${company.comPostcode}) \${company.comAddr} \${company.comDetailAddr}</td>
					    </tr>
					    <tr>
					        <td>대표자명</td>
					        <td>\${company.president}</td>
					    </tr>
					`)
				  });	
					$('#companys').append(companyArr.join(''));
			  }
			}
	    });
	}
	   
    $(() => {
    	input_admin_header()
        input_admin_sidebar()
        input_footer()
        btn_click()
        show_logout()
        listCompanys()
        
 		$('#companyDelBtn').on('click', function() {
 			$('#modalMsg').empty()
            $('#modalMsg').text('삭제하시겠습니까?')
            $('#modalBtn').show()
            $('#modal').modal('show')
            
            $('#modalOKBtn').off('click').on('click', function() {
	              $.ajax({
	                 url: '/admin/user/getinfo/del/' + companyId,
	                 method: 'delete',
	                 success: function() {
	                	 window.location.href = 'comlist'
	                 }
       		    })
 		   	})
   	    })
    }) 
</script>    
<style>
    tr th:last-child {
        padding-left: 25%;
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
                    <button type='button' class='btn btn-lightgray float-end' onclick='location.href="comlist"'>목록</button>
                </div>
            </div>
            <div class='row'>
                <div class='col'>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th></th>
                                <th><b>회사정보</b></th>
                            </tr>
                        </thead>
                        <tbody id='companys'>
             
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class='row mt-5'>
        <div class='col d-flex justify-content-center'>
            <button type='button' class='btn btn-red' id='companyDelBtn'>삭제하기</button>
        </div>
        <div class='footer'></div>
    </div>
</div>
<div class='modal fadel' id='modal'>
<div class='modal-dialog'>
	<div class='modal-content'>
	    <div class='modal-header'>
	        <button type='button' class='btn-close' data-bs-dismiss='modal'></button>
	    </div>
	    <div class='modal-body'>
	        <p id='modalMsg'></p>
	    </div>
	    <div class='modal-footer'>
	    <button type='button' class='btn btn-lightgray' data-bs-dismiss='modal'>취소</button>
	    <button type='button' class='btn btn-blue' id='modalOKBtn'>확인</button>
	    </div>
	</div>
</div>
</div>
</body>
</html>