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
<title></title>
<script>
	let empNo = ${sessionScope.empNo}
	let workNo = ${sessionScope.workNo}
	
    $(() => {
        input_user_header()
        btn_click()
        show_logout()
        
        get_time()
        setInterval(get_time, 1000)
        
        setBtnStart()
        if(workNo > 0) setBtnEnd()
	    else setBtnStart()
		
        $('#modalOkBtn').click(() => {
        	location.reload();
        })
        $('.btn-close').click(() => {
        	location.reload();
        })
        
        $('#work-start').click(e => {
        	e.preventDefault()
        	checkStart(empNo)
        })
        
        $('#work-end').click(e => {
        	e.preventDefault()
        	checkEnd(workNo)
        })
    })
    
    function checkStart(empNo) {
    	$.ajax({
    		url: 'start',
    		data: ({
    			employeeNo: empNo
    		}),
    		success: startTime => {
    			$('#modalMsg').empty()
    			$('#modalMsg').text(startTime + ' 출근이 정상적으로 등록되었습니다.')
    	    	$('#modal').modal('show')
    		}
    	})
    }
    
    function checkEnd(workNo) {
    	$.ajax({
    		url: 'end',
    		data: ({
    			workNo: workNo
    		}),
    		success: endTime => {
    			$('#modalMsg').empty()
    			$('#modalMsg').text(endTime + ' 퇴근이 정상적으로 등록되었습니다.')
    	    	$('#modal').modal('show')
    		}
    	})
    }

    const clock = $('#clock')

    function get_time() {
        const date = new Date()
        const hours = String(date.getHours()).padStart(2, '0')
        const min = String(date.getMinutes()).padStart(2, '0')
        const sec = String(date.getSeconds()).padStart(2, '0')
        $('.time').html(hours + ':' + min + ':' + sec)
    }

    function setBtnStart() {
    	$('#work-start').show()
    	$('#work-end').hide()
    }
    
    function setBtnEnd() {
    	$('#work-start').hide()
    	$('#work-end').show()
    }

</script>
<style>
    #clock {
        height: 8rem;
        line-height: 8rem;
        font-size: 3rem;
    }
    #work-start, #work-end {
        position: relative;
        left: 20%;
        width: 60%;
        height: 4rem;
        font-size: 1.6rem;
    }
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-4'>
        <div class='col'>
            <div class='row mt-5'>
                <div id='clock'>
                    <div class='time text-center'></div>
                </div>
            </div>
            <div class='row mt-5'>
                <div class='col mt-5'>
                    <button type='button' class='btn btn-blue' id='work-start'>출근하기</button>
                    <button type='button' class='btn btn-white' id='work-end'>퇴근하기</button>
                </div>
            </div>
        </div>
    </div>
    <div class='navigation'></div>
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
                <button type='button' class='btn btn-blue' id='modalOkBtn' data-bs-dismiss='modal'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>