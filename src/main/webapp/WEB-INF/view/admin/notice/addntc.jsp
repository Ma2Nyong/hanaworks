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
<title>admin 전체 공지사항 작성</title>
<script>
	let adminId = "${sessionScope.adminId}"

    $(() => {
    	input_admin_header()
        input_admin_sidebar()
        input_footer()
        
        if(adminId != 'admin') {
            location.href='/admin'
    	}
		
		$('#addPublicNoticeBtn').click(() => {
			if(isVal($('#publicNoticeTitle')) && isVal($('#publicNoticeContent'))) {
				$.ajax({
					url:'addntc/add',
					method:'post',
					data: {
						publicNoticeTitle: \$('#publicNoticeTitle').val(),
						publicNoticeContent: \$('#publicNoticeContent').val()
					},
					success : move
				});
			}
		})
		
		$('#addNoBtn').click(() => {
			if($('#publicNoticeTitle').val() || $('#publicNoticeContent').val()) {
				$('#modalMsg').empty()
				$('#modalMsg').append(`<p>이 페이지를 벗어나면 기존 작성된 글이 삭제됩니다.</p>`)
				$('#modal').modal('show')
				$('#modalBtn').show()
				$('#modalCancelBtn').show();
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
	    
	    if (!isGood) {
	        $('#modalMsg').text(errMsg);
	        $('#closeBtn').show();
	        $('#modalCancelBtn').hide();
	        $('#modalOKBtn').attr('onclick', '').attr('data-bs-dismiss', 'modal');
	        $('#modal').modal('show');
	    }
	    return isGood;
	}
	
	function move() {
		window.location.href="../notice/admntclist"
	}
</script>
<style>
    #publicNoticeTitle {
        width: 100%;
        padding: 5px;
        border: .1rem solid;
        border-radius: .2rem;
    }

    #publicNoticeContent {
        width: 100%;
        height: 15rem;
        padding: 10px;
        border-color: black;
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
            <div class='row mt-4'>
                <div class='col'>
                    <h2><b>공지사항</b></h2>
                </div>
            </div>
            <div class='row pt-3'>
                <div class='col'>
                    <p>하나웍스 서비스 안내와 공지에 대한 소식을 전해드립니다.</p>
                    <hr>
                    <b>공지작성</b>
                </div>
            </div>
            <div class='row pt-3'>
                <div class='col'>
                    <h4>제목</h4>
                    <input type='text' id='publicNoticeTitle' placeholder='제목을 입력하세요.'>
                    <h4 class='pt-3'>내용</h4>
                    <textarea id='publicNoticeContent' placeholder='내용을 입력하세요.'></textarea>
                </div>
            </div>
            <div class='row'>
                <div class='col d-flex justify-content-end mt-3'>
                    <button type='button' class='btn me-3 btn-blue' id='addPublicNoticeBtn'>작성</button>
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
                <button type='button' class='btn m-2 btn-lightgray' id='modalCancelBtn' data-bs-dismiss='modal'>취소</button>
                <button type='button' class='btn btn-blue' id='modalOKBtn' onclick="window.location.href='admntclist'">확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>