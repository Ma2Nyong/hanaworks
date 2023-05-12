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
	const urlParams = new URLSearchParams(window.location.search);
	const publicNoticeNo = urlParams.get('publicNoticeNo');
	let companyId = "${sessionScope.comId}"
	
    $(() => {
        input_company_header()
        input_footer()
        btn_click()        
        PublicNoticeDetail()
        
        if(companyId != '') {
            show_logout()
        } else {
        	show_login()
        }
    })
    
	function PublicNoticeDetail() {
		$.ajax({
			url: 'getntc/get',
			dataType: 'json',
			data : {
				publicNoticeNo: publicNoticeNo
			},
			success : publicNoticeDetail => {
				if(publicNoticeDetail.length) {
					const publicNoticeArr = [];
					
					$.each(publicNoticeDetail, (i, publicNotice) => {
						publicNoticeArr.unshift(
							`<thead>
								<tr>
									<th>\${publicNotice.pubntcTitle}</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>\${publicNotice.pubntcContent.replace(/\n/g, '<br>')}</td>
								</tr>
							</tbody>`
								
						)
					})
					$('#publicNoticeDetail').append(publicNoticeArr.join(''));
				}
			}
		})
	}
</script>
<style>
    .table {
        border: .1rem solid;
    }

    table a {
        color: black;
    }
    .lnb {
        list-style-type: none;
    }
    .liNone {
        list-style-type: none;
    }
    
    ul {
        padding: 1rem;
    }
    
    tbody tr {
    	width: 100%;
        height: 15rem;
        padding: 10px;
        border-color: black;
        border-radius: .2rem;
    }
    
	thead {
		background-color: #f0f0f1;
	}
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-5'>
        <div class='col text-center'>
            <h2><b>공지사항</b></h2>
        </div>
    </div>
    <div class='row pt-3'>
        <div class='col text-center'>
            <p>하나웍스 서비스 안내와 공지에 대한 소식을 전해드립니다.</p><hr>
        </div>
    </div>
    <div class='row pt-2'>
        <div class='col'>
            <table class='table' id='publicNoticeDetail'>
                
            </table>
        </div>
    </div>
    <div class='row'>
        <div class='col d-flex justify-content-end'>
            <button type='button' class='btn btn-secondary' id='listBtn' onclick="window.location.href='ntclist'">목록</button>
        </div>
    </div>
    <div class='footer'></div>
</div>
</body>
</html>