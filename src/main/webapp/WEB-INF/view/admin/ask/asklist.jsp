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
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title>문의사항 목록</title>
<script>
	let session = '${sessionScope.comId}'
	
	$(() => {
	    input_company_header()
	    btn_click()
	    input_footer()
	    listAsks()
	    mp_check()
	})
	
	function listAsks() {
	    $('#asks').empty()
	
	    $.ajax({
	        url: 'asklist/get',
	        dataType: 'json',
	        success: asks => {
	            if (asks.length) {
	                const askArr = [];
	                
	                $.each(asks, (i, ask) => {
	                    askArr.unshift(`
                    		<tr onclick="window.location.href='getask?askNo=\${ask.askNo}'">
	                            <td>\${ask.askNo}</td>
	                            <td>\${ask.askTitle}</td>
	                            <td>\${ask.askName}</td>
	                            <td>\${ask.askDate}</td>
	                            <td>\${ask.answerDate ? `\${ask.answerDate}` : ''}</td>
	                        </tr>
	                    `)
	                })
	
	                $('#asks').append(askArr.join(''))
	            } else {
	                $('#asks').append('<tr><td colspan=5 class=text-center>문의사항이 없습니다.</td></tr>')
	            }
	        }
	    })
	}
	
	function mp_check() {
		if(session != '') {
			show_logout()
		} else {
			show_login()
		}
	}
</script>
<style>
    .table {
        border-top: .1rem solid;
    }
    
    table a {
        color: black;
    }

    hr {
        opacity: 1;
    }

    tr th:first-child {
        width: 10%;
        text-align: center;
    }

    tr th:nth-child(2) {
        padding-left: 4rem;
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
        <div class='col text-center'>
            <h2><b>문의사항</b></h2>
        </div>
    </div>
    <div class='row pt-3'>
        <div class='col text-center'>
            <p>문의를 남겨주시면 하나웍스 전문가가 빠른 해결을 도와드리겠습니다.</p>
            <hr>
        </div>
    </div>
    <div class='row pt-2'>
        <div class='col d-flex justify-content-end'>
            <button type='button' class='btn btn-blue' id='addAskBtn' onclick="location.href='addask'">글쓰기</button>
        </div>
    </div>
    <div class='row pt-4'>
        <div class='col'>
            <table class='table table-ellipsis'>
                <thead>
                    <tr>
                        <th>글 번호</th>
                        <th>제목</th>
                        <th>글쓴이</th>
                        <th>등록일</th>
                        <th>답변일</th>
                    </tr>
                </thead>
                <tbody id='asks'>
                    
                </tbody>
            </table>
        </div>
    </div>
    <div class='footer'></div>
</div>
</body>
</html>