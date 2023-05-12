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
<title>user 전체 공지사항 상세조회</title>
<script>
	const urlParams = new URLSearchParams(window.location.search);
	const publicNoticeNo = urlParams.get('publicNoticeNo');
	let session = ${sessionScope.empNo}
	
    $(() => {
        input_user_header()
        btn_click()
        show_logout()        
        publicNoticeDetail()

		mp_check()
	})
	
	function mp_check() {
		if(session > 0) {
			show_logout()
		} else {
			show_login()
		}
	}
	
	function publicNoticeDetail() {
		$.ajax({
			url: '../admin/notice/getntc/get',
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
        font-size: .8rem;
        border: .1rem solid;
    }
    table a {
        color: black;
    }
    #decimal {
        list-style-type: decimal;
    }
    #decimal li {
        margin-bottom: 1rem;
        margin-top: 1rem;
    }

    .liNone {
        list-style-type: none;
    }
    
    hr {
        width: 80%;
        margin-left : auto;
        margin-right : auto;
    }

    th {
        font-size: 1rem;
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
            <h1><b>공지사항</b></h1>
        </div>
    </div>
    <div class='row pt-3'>
        <div class='col text-center'>
            <p>하나웍스 서비스 안내와 공지에 대한 소식을 전해드립니다.</p>
            <hr>
        </div>
    </div>
    <div class='row pt-4 mb-5'>
        <div class='col'>
            <table class='table mt-2' id='publicNoticeDetail'>
               	
                <caption class="text-end"><button type='button' class='btn btn-secondary' 
                     onclick="window.location.href='ntclist'">목록</button></caption>
            </table>
        </div>
    </div>
    <div class='navigation'></div>
</div>
</body>
</html>