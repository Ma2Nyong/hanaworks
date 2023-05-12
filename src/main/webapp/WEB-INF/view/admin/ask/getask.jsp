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
<title>문의사항 작성</title>
<script>
	const urlParams = new URLSearchParams(window.location.search)
	const askNo = urlParams.get('askNo')
	let session = '${sessionScope.comId}'

    $(() => {
        input_company_header()
        btn_click()
        input_footer()
        listAsk()
        mp_check()
    })
	
	function listAsk() {
	    $.ajax({
	        url: 'asklist/getAsk',
	        dataType: 'json',
	        data: {
	        	askNo: askNo
	        },
	        success: asks => {
	            if (asks.length) {
	                const askArr = []
	                
	                $.each(asks, (i, ask) => {
	                    askArr.unshift(`
                    		<thead>
	                            <tr>
	                                <th>\${ask.askTitle}</th>
	                                <th>\${ask.askName}</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        	<tr>
	                        		<td>\${ask.askContent.replace(/\n/g, '<br>')}</td>
	                        	</tr>
	                        </tbody>
	                    `)
	                    $('#answerContent').append(`\${ask.answerContent ? `\${ask.answerContent}` : ''}`)
	                })
	
	                $('#asks').append(askArr.join(''))
	                
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
    input {
        width: 100%;
        padding: .3rem;
        border: .1rem solid;
        border-radius: .2rem;
    }

    textarea {
        width: 100%;
        height: 7rem;
        border: .1rem solid;
        padding-top: 1rem;
        color: gray;
    }   

    .table {
        border: .1rem solid;
    }

    tr th:last-child {
        width: 20%;
        border-left: .1rem solid;
        text-align: center;
    }

    tr td {
        height: 10rem;
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
            <p>문의를 남겨주시면 하나웍스 전문가가 빠른 해결을 도와드리겠습니다.</p><hr>
        </div>
    </div>
    <div class='row pt-1'>
        <div class='col'>
            <table class='table' id='asks'>
                
            </table>
        </div>
    </div>
    <div class='row'>
        <div class='col'>
            <h5>답변</h5>
            <textarea id='answerContent' readOnly>
</textarea>
        </div>
    </div>
    <div class='row pt-2'>
        <div class='col d-flex justify-content-end'>
            <button type='button' class='btn btn-secondary' id='listBtn' onclick="window.location.href='asklist'">목록</button>
        </div>
    </div>
    <div class='row mt-5'>
        <div class='col footer'></div>
    </div>
</div>
</body>
</html>

