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
<title>company 사내 공지사항 수정</title>
<script>
	let companyId = "${sessionScope.comId}"
	
	const urlParams = new URLSearchParams(window.location.search);
	const companyNoticeNo = urlParams.get('companyNoticeNo');

	$(() => {
	    input_company_header()
	    input_company_sidebar()
	    input_footer()
	    btn_click()
	    show_logout()
	    
	    fixCompanyNotice()
	    
	    if(companyId != "${sessionScope.comId}") {
        	location.href='/company'
        }
	    
	    $('#fixOkBtn').click(() => {
	    	if(isVal($('#companyNoticeTitle')) && isVal($('#companyNoticeContent'))) {
	    		let fixCompanyNotice = {
	    				companyNoticeNo :companyNoticeNo,
	    				comntcTitle: $('#companyNoticeTitle').val(),
	    				comntcContent: $('#companyNoticeContent').val()
	    		}
	    		$.ajax({
	    			url: 'fixcomntc/fix',
	    			method: 'put',
	    			contentType: 'application/json',
	    			data: JSON.stringify(fixCompanyNotice),
	    			success: move()
	    		})
	    	}
	    })
	    
	    $('#fixNoBtn').click(() =>{
	    	$('#modalMsg').empty()
	    	$('#modalMsg').append(`<p>이 페이지를 벗어나면 수정 중이던 글이 취소됩니다.<br>
	                    		저장을 하실 경우 취소 버튼을 누르고 저장을 해주세요.<br>
	            				이미 저장한 경우에는 확인 버튼을 눌러주세요.</p>`)
	        $('#modal').modal('show')
	    })
	})
	
	function fixCompanyNotice() {
		$('#fixCompanyNotice').empty()
		
		$.ajax({
			url: 'getcomntc/get',
			method: 'get',
			data: {
				companyNoticeNo: companyNoticeNo
			},
			success: fixCompanyNotice => {
				if(fixCompanyNotice.length) {
					const fixCompanyNoticeArr=[];
					
					$.each(fixCompanyNotice, (i, companyNotice)=> {
						fixCompanyNoticeArr.push(
							`<h4>제목<h4>
								<input type='text' id='companyNoticeTitle' placeholder='제목을 입력하세요.'
										style='font-size:1.2rem;' value='\${companyNotice.comntcTitle}'>
							<h4 class='pt-3'>내용</h4>
								<textarea id='companyNoticeContent' 
										placeholder='내용을 입력하세요.'>\${companyNotice.comntcContent}</textarea>`
						)
					})
					$('#fixCompanyNotice').append(fixCompanyNoticeArr.join(''));
				}
			}
		})
	}
	
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
			$('#modalOkBtn').attr('onclick','').attr('data-bs-dismiss','modal');
			$('#modal').modal('show');
		}
		return isGood;
	}
	
	function move() {
		window.location.href="../notice/getcomntc?companyNoticeNo=" + companyNoticeNo
	}
 
</script>
<style>
	#companyNoticeTitle{
		width: 100%;
        padding: 5px;
        border: .1rem solid;
        border-radius: .2rem;
	}

    textarea {
        width: 100%;
        height: 15rem;
        padding: 10px;
        border: .1rem solid;
        border-radius: .2rem;
    }
    
    input {
    	pont-size : 1rem;
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
                <h3><b>사내 공지사항</b></h3>
            </div>
            <div class='row mt-2'>
                <div class='col' id='fixCompanyNotice'>
    
                </div>
            </div>
            <div class='row'>
                <div class='col d-flex justify-content-end mt-3'>
                    <button type='button' class='btn me-3 btn-blue' id='fixOkBtn'>저장</button>
                    <button type='button' class='btn btn-secondary' id='fixNoBtn'>취소</button>
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
                <button type='button' class='btn btn-blue' id='modalOkBtn' onclick="window.location.href='comntclist'">확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>