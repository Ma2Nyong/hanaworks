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
<title>company 사내 공지사항 목록</title>
<script>
	let companyId = "${sessionScope.comId}"
	
    $(() => {
        input_company_header()
        input_company_sidebar()
        input_footer()
        btn_click()
        show_logout()        
        listCompanyNotices()
        
        if(companyId != "${sessionScope.comId}") {
        	location.href='/company'
        }
    })
	
	function listCompanyNotices() {
		$('#companyNoticeList').empty();
		
		$.ajax({
			url:'comntclist/get',
			dataType:'json',
			data: {
				companyId: companyId
			},
			success: companyNoticeList => {
				if(companyNoticeList.length) {
					const companyNoticeArr = [];
					let noticeNumber = 1
					
					$.each(companyNoticeList, (i,companyNotice) => {
						companyNoticeArr.unshift(
							`<tr onclick="window.location.href='../notice/getcomntc?companyNoticeNo=\${companyNotice.companyNoticeNo}'">
								<td>\${noticeNumber++}</td>
								<td>\${companyNotice.comntcTitle}</td>
								<td>\${companyNotice.comntcDate}</td>
							</tr>`
						)
					})
					$('#companyNoticeList').append(companyNoticeArr.join(''));
				} else {
					$('#companyNoticeList').append('<tr><td colspan=3 class=text-center>공지사항이 없습니다.</td></tr>')
				}
			}
		})
	}
</script>
<style>
    .table {
        border-top: .1rem solid;
    }
    
    table a {
        color: black;
    }

    tr th:first-child {
        width: 10%;
        text-align: center;
    }

    tr th:nth-child(2) {
        padding-left: 1rem;
    }

    tr th:last-child {
        width: 15%;
        text-align: center;
    }
    
    tbody tr td:first-child, tbody tr td:last-child {
        text-align: center;
    }
    
    .table tbody tr:hover {
		background-color: #EBF3FA;
		cursor: pointer;
	}
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-5'>
        <div class='col-2 snb'></div>
        <div class='col'>
            <div class='row mt-5'>
                <div class='col'>
                    <div class='row'>
                        <h3><b>사내 공지사항</b></h3>
                    </div>
                    <div class='row'>
                        <div class='col d-flex justify-content-end'>
                            <button type='button' class='btn btn-blue' id='addNoticeBtn' onclick="window.location.href='addcomntc'">글 쓰기</button>
                        </div>
                    </div>
                    <div class='row pt-3'>
                        <div class='col'>
                            <table class='table'>
                                <thead>
                                    <tr>
                                        <th>글 번호</th>
                                        <th>제목</th>
                                        <th>등록일</th>
                                    </tr>
                                </thead>
                                <tbody id='companyNoticeList'>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class='footer'></div>
</div>
</body>
</html>