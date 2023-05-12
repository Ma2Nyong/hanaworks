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
	function listAsks() {
	    $('#asks').empty();
	
	    $.ajax({
	        url: '/admin/ask/asklist/get',
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
	                    `);
	                });
	
	                $('#asks').append(askArr.join(''));
	            } else {
	                $('#asks').append('<tr><td colspan=5 class=text-center>문의사항이 없습니다.</td></tr>');
	            }
	        }
	    });
	}
	
	let session = ${sessionScope.empNo}

    $(() => {
    	input_user_header()
        btn_click()
        listAsks()
        
        mp_check()
    })
    
    function mp_check() {
		if(session > 0) {
			show_logout()
		} else {
			show_login()
		}
	}
</script>
<style>
    table {
        font-size: .8rem;
    }
    table a {
        color: black;
    }

    hr {
        width: 80%;
        margin-top: 2rem;
        margin-left : auto;
        margin-right : auto;
        opacity: 1;
    }

    tr th:first-child {
        width: 13%;
        text-align: center;
    }

    tbody tr td:first-child, tbody tr td:last-child, tr th:last-child, tr th:nth-child(4) {
        text-align: center;
    }

    .askMent {
        font-size: .8rem;
    }

    @media (max-width: 699px) {
        thead tr th:nth-child(4) {
            display: none;
        }

        tbody tr td:nth-child(4) {
            display: none;
        }
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
        <div class='col text-center askMent'>
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
    <div class='navigation'></div>
</div>
</body>
</html>