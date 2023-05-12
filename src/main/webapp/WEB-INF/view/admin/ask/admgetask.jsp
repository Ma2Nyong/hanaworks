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
<title>전체 문의사항 조회</title>
<script>
	const urlParams = new URLSearchParams(window.location.search);
	const askNo = urlParams.get('askNo');
	
	function move() {
		window.location.href = 'admasklist'
	}
	
	function listAsk() {
	    $.ajax({
	        url: '/admin/ask/asklist/getAsk',
	        dataType: 'json',
	        data: {
	        	askNo: askNo
	        },
	        success: asks => {
	            if (asks.length) {
	                const askArr = [];
	                
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
	                    `);
	                    $('#answerContent').append(`\${ask.answerContent ? `\${ask.answerContent}` : ''}`)
	                });
	
	                $('#asks').append(askArr.join(''));
	            }
	        }
	    });
	}
	
    $(() => {
        input_admin_header()
        input_admin_sidebar()
        btn_click()
        input_footer()
        listAsk()
        
        // 답변 저장
        $('#addAnswer').on('click', function() {
       	 	if($('#answerContent').val()) {
       	 		const answerContent = $('#answerContent').val()
       	 		
		        let answer = {
		            askNo: askNo,
		            answerContent: answerContent
		        }
				
	       	 	$.ajax({
		            url: 'admgetask/add',
		            type: 'put',
		            contentType: 'application/json',
		            data: JSON.stringify(answer),
		            success: move()
		        })
	       	 	
       	 	} else {
	       	 	$('#modalMsg').empty()
	            $('#modalMsg').text('답변내용이 없습니다.')
	            $('#modalBtn').hide()
	            $('#modal').modal('show')
       	 	}
	    });
        
        // 문의사항 삭제
        $('#delAskBtn').on('click', function() {
        	$('#modalMsg').empty()
            $('#modalMsg').text('해당 게시글을 삭제하시겠습니까?')
            $('#modalBtn').show()
            $('#modal').modal('show')
            
        	$('#modalOKBtn').off('click').on('click', function() {
	            $.ajax({
	                url: 'admgetask/del/' + askNo,
	                method: 'delete',
	                success: move()
	            });
        	})
        });
    })
</script>
<style>
    .askMent {
        font-size: .8rem;
    }

    input {
        width: 100%;
        padding: .2rem;
        border: .1rem solid;
        border-radius: .5rem;
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

    .ask {
        padding-top: 4rem !important;
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
                <div class='col mt-4'>
                    <h2><b>문의사항</b></h2>
                </div>
            </div>
            <div class='row pt-3'>
                <div class='col'>
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
                    <textarea id='answerContent'>
</textarea>
                </div>
            </div>
            <div class='row pt-2'>
                <div class='col d-flex justify-content-end'>
                    <button type='button' class='btn me-3 btn-blue' id='addAnswer'>답변저장</button>
                    <button type='button' class='btn me-3 btn-secondary' onclick="window.location.href='admasklist'">목록</button>
                    <button type='button' class='btn btn-red' id='delAskBtn'>삭제</button>
                </div>
            </div>
        </div>
    </div>
    <div class='row mt-5'>
        <div class='col footer'></div>
    </div>
</div>
<div class='modal fade' id='modal'>
    <div class='modal-dialog'>
        <div class='modal-content'>
            <div class='modal-header'>
                <button type='button' class='btn-close' data-bs-dismiss='modal'></button>
            </div>
            <div class='modal-body'>
                <p id='modalMsg'></p>
            </div>
            <div class='modal-footer' id='modalBtn'>
                <button type='button' class='btn m-2 btn-lightgray' id='modalCancelBtn' data-bs-dismiss='modal'>취소</button>
                <button type='button' class='btn btn-blue' id='modalOKBtn' onclick="window.location.href='04.html'">확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>