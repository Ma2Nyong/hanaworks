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
<title>company 사내 공지사항 작성</title>
<script>	
	let companyId = "${sessionScope.comId}"
	
	$(() => {
	    input_company_header()
	    input_company_sidebar()
	    input_footer()
	    btn_click()
	    show_logout()
	    
	    if(companyId != "${sessionScope.comId}") {
        	location.href='/company'
        }
	    
	    $('#addCompanyNoticeBtn').click(() => {
	    	if(isVal($('#companyNoticeTitle')) && isVal($('#companyNoticeContent'))){
	    		$.ajax({
	    			url: 'addcomntc/add',
	    			method: 'post',
	    			data: {
	    				companyNoticeTitle: \$('#companyNoticeTitle').val(),
	    				companyNoticeContent: \$('#companyNoticeContent').val(),
	    				companyId: companyId
	    			},
	    			success: move
	    		});
	    	}
	    })
	  	  
	    $('#addNoBtn').click(() => {
	    	if($('#companyNoticeTitle').val() || $('#companyNoticeContent').val()) {
	    		$('#modalMsg').empty()
	    		$('#modalMsg').append(`<p>이 페이지를 벗어나면 기존 작성된 글이 삭제됩니다.</p>`)
	    		$('#modal').modal('show')
	    		$('#modalBtn').show()
	    		$('#modalCancelBtn').show()
	    		$('#modalOkBtn').click(() => move())
	    	} else move()
	    	
		})	    
	})
	
	function isVal(field) {
		let isGood = false
		let errMsg
		
		if(!field.val()) {
			errMsg = '제목 또는 내용을 입력하세요.'
		} else {
			isGood = true;
		}
		
		if(!isGood) {
			$('#modalMsg').text(errMsg);
			$('#closeBtn').show();
			$('#modalCancelBtn').hide();
			$('#modalOkBtn').attr('onclick', '').attr('data-bs-dismiss', 'modal');
			$('#modal').modal('show');
		}
		return isGood;
	}
	
	function move() {
		window.location.href="../notice/comntclist"
	}

</script>
<style>
    #companyNoticeTitle {
        width: 100%;
        padding: 5px;
        border: .1rem solid;
        border-radius: .2rem;
    }

    #companyNoticeContent {
        width: 100%;
        height: 15rem;
        padding: 10px;
        border: .1rem solid;
        border-radius: .2rem;
    }   

</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-5'>
        <div class='col-2 snb'></div>
        <div class='col'>
            <div class='row mt-2'>
                <h3><b>사내 공지사항</b></h3>
                <p class='mb-2'> - 공지사항 작성</p>
            </div>
            <div class='row pt-2'>
                <div class='col'>
                    <h4>제목</h4>
                    <input type='text' id='companyNoticeTitle' placeholder='제목을 입력하세요.'>
                    <h4 class='pt-3'>내용</h4>
                    <textarea id='companyNoticeContent' placeholder='내용을 입력하세요.'></textarea>
                </div>
            </div>
            <div class='row'>
                <div class='col d-flex justify-content-end mt-3'>
                    <button type='button' class='btn me-3 btn-blue' id='addCompanyNoticeBtn'>작성</button>
                    <button type='button' class='btn btn-secondary' id='addNoBtn'>취소</button>
                </div>
            </div>
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
                <button type='button' class='btn btn-lightgray' id='modalCancelBtn' data-bs-dismiss='modal'>취소</button>
                <button type='button' class='btn m-2 btn-blue' id='modalOkBtn' onclick="window.location.href='comntclist'">확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>