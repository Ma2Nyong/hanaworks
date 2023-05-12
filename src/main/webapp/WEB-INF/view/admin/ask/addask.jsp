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
	let session = '${sessionScope.comId}'
	
	$(() => {
	    input_company_header()
	    btn_click()
	    input_footer()
	    mp_check()
	    
	    $('#askAddBtn').click(() => {
	    	if(isVal($('#askTitle')) && isVal($('#askName')) && isVal($('#askContent'))) {
	    		$.ajax({
	                url: 'addask/add',
	                type: 'post',
	                data: {
	                    askTitle: $('#askTitle').val(),
	                    askName: $('#askName').val(),
	                    askContent: $('#askContent').val()
	                },
	                success: move()
	            });
	    	}
	    })
	
	    $('#askListBtn').click(() => {
	    	if($('#askTitle').val() || $('#askName').val() || $('#askContent').val()) {
	            $('#modalMsg').empty()
	            $('#modalMsg').append(`<p>작성중인 문서가 있습니다.<br>
	                            화면을 나가시겠습니까?</p>`)
	            $('#modal').modal('show')
	            $('#modalBtn').show()
	            $('#modalOKBtn').click(() => {
	            	move()
	            })
	    	} else {
	    		move()
	    	}
	    })
	})
	
	function move() {
		window.location.href = 'asklist'
	}
	
	function isVal(field) {        
	    let isGood = false
	    let errMsg
	
	    if(!field.val()) errMsg = field.attr('data-err') + ' 입력하세요.'
	    else isGood = true
	
	    if(!isGood) {            
	        $('#modalMsg').text(errMsg)
	        $('#modalBtn').hide()
	        $('#modal').modal('show')           
	    }
	
	    return isGood
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
    .askMent {
        font-size: .8rem;
    }

    input {
        width: 100%;
        padding: .3rem;
        border: .1rem solid;
        border-radius: .5rem;
    }

    textarea {
        width: 100%;
        height: 10rem;
        padding: .3rem;
        border: .1rem solid;
        border-radius: .5rem;
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
    <div class='row pt-2'>
        <div class='col'>
            <h4>제목</h4>
            <input type='text' placeholder='제목을 입력하세요.' id='askTitle' data-err='제목을'>
            <h4 class='pt-3'>작성자</h4>
            <input type='text' id='askName' data-err='작성자를'>
            <h4 class='pt-3'>내용</h4>
            <textarea id='askContent' placeholder='내용을 입력하세요.' data-err='내용을'></textarea>
        </div>
    </div>
    <div class='row pt-2'>
        <div class='col d-flex justify-content-end'>
            <button type='button' class='btn me-2 btn-blue' id='askAddBtn'>등록</button>
            <button type='button' class='btn btn-secondary' id='askListBtn'>목록</button>
        </div>
    </div>
    <div class='footer'></div>
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
                <button type='button' class='btn m-2 btn-secondary' id='modalCancelBtn' data-bs-dismiss='modal'>취소</button>
                <button type='button' class='btn btn-blue' id='modalOKBtn'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>