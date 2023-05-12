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
<title>user 전체 공지사항 목록</title>
<script>
	let session = ${sessionScope.empNo}
	
	$(() => {
	    input_user_header()
	    btn_click()
	    show_logout()       
	    listPublicNotices()
	    
		mp_check()
	})
	
	function mp_check() {
		if(session > 0) {
			show_logout()
		} else {
			show_login()
		}
	}

	function listPublicNotices() {
		$('#publicNoticeList').empty();
		
		$.ajax({
			url :'../admin/notice/ntclist/get',
			dataType: 'json',
			success :publicNoticeList => {
				if(publicNoticeList.length) {
					const publicNoticeArr = [];
					let noticeNumber = 1
					
					$.each(publicNoticeList, (i, publicNotice) => {
						publicNoticeArr.unshift(
							`<tr onclick="window.location.href='getntc?publicNoticeNo=\${publicNotice.publicNoticeNo}'">
								<td>\${noticeNumber++}</td>
								<td>\${publicNotice.pubntcTitle}</td>
								<td>\${publicNotice.pubntcDate}</td>
	    					</tr>`
						)				
					})
					$('#publicNoticeList').append(publicNoticeArr.join(''));
				} else {
					$('#publicNoticeList').append('<tr><td colspan=3 class=text-center>공지사항이 없습니다.</td></tr>')
				}
			}
		})
	}
</script>
<style>
    .table {
        font-size: .8rem;
        border-top: .1rem solid;
    }
    table a {
        color: black;
    }

    hr {
        width: 80%;
        margin-left : auto;
        margin-right : auto;
    }

    tr th:first-child {
        width: 13%;
        text-align: center;
    }

    tr th:nth-child(2) {
        padding-left: 1rem;
    }

    tr th:last-child {
        width: 20%;
        text-align: center;
    }
    
    tbody tr td:first-child, tbody tr td:last-child {
        text-align: center;
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
            <table class='table table-ellipsis'>
                <thead>
                    <tr>
                        <th>글 번호</th>
                        <th>제목</th>
                        <th>등록일</th>
                    </tr>
                </thead>
                <tbody id='publicNoticeList'>

                </tbody>
            </table>
        </div>
    </div>
    <div class='navigation'></div>
</div>
</body>
</html>