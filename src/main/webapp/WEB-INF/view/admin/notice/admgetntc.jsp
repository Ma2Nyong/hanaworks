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
<title>admin 전체 공지사항 상세 조회</title>
<script>
	let adminId = "${sessionScope.adminId}"

	const urlParams = new URLSearchParams(window.location.search);
	const publicNoticeNo = urlParams.get('publicNoticeNo');
	
    $(() => {
    	input_admin_header()
        input_admin_sidebar()
        input_footer()
        PublicNoticeDetail()
    	
    	if(adminId != 'admin') {
            location.href='/admin'
    	}

        $('#delPublicNoticeBtn').on('click', function() {
        	$('#modalMsg').empty()
        	$('#modalMsg').text('정말로 삭제하시겠습니까?')
        	$('#modalBtn').show()
        	$('#modal').modal("show")
        	
        	$('#modalOkBtn').off('click').on('click', function() {
        		$.ajax({
        			url: 'getntc/del/' + publicNoticeNo,
        			method:'delete',
        			success: move
        		})
        	})
        })
    })
    
	function PublicNoticeDetail() {
		$.ajax({
			url: 'getntc/get',
			dataType: 'json',
			data : {
				publicNoticeNo: publicNoticeNo
			},
			success : publicNoticeDetail => {
				if(publicNoticeDetail.length) {
					const publicNoticeArr = [];
					
					$.each(publicNoticeDetail, (i, publicNotice) => {
						publicNoticeArr.unshift(
							`<thead>
								<tr>
									<th>\${publicNotice.pubntcTitle}</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>\${publicNotice.pubntcContent.replace(/\n/g, '<br>')}</td>
								</tr>
							</tbody>`
						)
					})
					$('#publicNoticeDetail').append(publicNoticeArr.join(''));
				}
			}
		})
	}
	
    function move() {
    	window.location.href="../notice/admntclist"
    }
</script>
<style>
    .table {
        border: .1rem solid;
    }

    th {
        font-size: 1.2rem;
    }

    #modalOkBtn {
        background-color: darkblue;
        color: white;
    }

    #modalCancelBtn {
        background-color: lightgray;
        color: black;
    }
   
    .liNone {
        list-style-type: none;
    }

    ul {
        padding: 1rem;
    }
    
    tbody tr {
    	width: 100%;
        height: 15rem;
        padding: 10px;
        border-color: black;
        border-radius: .2rem;
    }
    thead {
		background-color: #f0f0f1;
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
                </div>
            </div>
            <div class='row pt-2'>
                <div class='col'>
                    <table class='table' id='publicNoticeDetail'>
                        
                    </table>
                </div>
            </div>
            <div class='row'>
                <div class='col d-flex justify-content-end'>
                    <button type='button' class='btn me-3 btn-white'
                    		onclick="window.location.href=`fixntc?publicNoticeNo=\${publicNoticeNo}`">수정</button>
                    <button type='button' class='btn me-3 btn-secondary' onclick="window.location.href='admntclist'">목록</button>
                    <button type='button' class='btn btn-red' id='delPublicNoticeBtn'>삭제</button>
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
                <button type='button' class='btn m-2' id='modalCancelBtn' data-bs-dismiss='modal'>취소</button>
                <button type='button' class='btn' id='modalOkBtn'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>