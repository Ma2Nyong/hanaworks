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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title>연차</title>
<script>
let employeeNo = ${sessionScope.empNo}
let employeeName = "${sessionScope.empName}"
let employeeHireDate = "${sessionScope.hireDate}"

$(() => {
	input_user_header()
    btn_click()
    show_logout()
    listHolidays()
})

	function isVal(field) {
	    let isGood = false
	    let errMsg
	
	    if(!field.val()) errMsg = field.attr('placeholder') + '를 입력하세요.'
	    else isGood = true
	
	    if(!isGood) {            
	    	setTimeout(function() {
             $('#modalMsg').text(errMsg)
             $('#modalBtn').hide()
             $('#modal').modal('show')
           }, 300)        
	    }
	
	    return isGood
	}
	
	function listHolidays() {
	    $('#holidays').empty();
	    
	    $.ajax({
	        url: '/holiday/getholiday/get',
	        dataType: 'json',
	        data: {
	        	employeeNo: employeeNo
	        },
	        success: holidays => {
	            if (holidays.length) {
	                const holidayArr = [];
	                
	                $.each(holidays, (i, holiday) => {
	                	// 수정,삭제 버튼을 위한 날짜 계산
	                    const today = new Date()
	                    const holidayDate = new Date(holiday.holDate)
	                    const timeDiff = holidayDate.getTime() - today.getTime()
	                    const daysDiff = timeDiff / (1000 * 3600 * 24)
	                    
	                    let fixdelBtn = ''
	                    if (daysDiff >= 3) {
	                    	fixdelBtn = `<button type='button' class='btn btn-white btn-sm fixHolidayBtn'>수정</button>
	                                   <button type='button' class='btn btn-red btn-sm delHolidayBtn'>삭제</button>`
	                    }
	                    
	                    // 부여연차, 잔여연차, 소진연차 입력.
	                    let grantHoliday = moment().diff(moment(employeeHireDate), 'months')
	                    if(grantHoliday > 12) {
	                    	grantHoliday = 15
	                    }
	                    
	                    const usedHoliday = holidays.length
	                    const remainHoliday = grantHoliday - usedHoliday
	                    if(remainHoliday == 0) {
	                    	$('#addHolidayBtn').hide()
	                    } else {
	                    	$('#addHolidayBtn').show()
	                    }
	                    
	                    $('#grantHoliday').text(`\${grantHoliday}`)
	                    $('#usedHoliday').text(`\${usedHoliday}`)
	                    $('#remainHoliday').text(remainHoliday)
	                    $('#employeeName').text(employeeName)
	
	                    holidayArr.unshift(`
	                        <tr holidayNo='\${holiday.holidayNo}'>
	                            <td>\${employeeName}</td>
	                            <td>\${holiday.holDate}</td>
	                            <td>\${fixdelBtn}</td>
	                        </tr>
	                    `);
	                });
	
	                $('#holidays').append(holidayArr.join(''));
	            } else {
	                let grantHoliday = moment().diff(moment(employeeHireDate), 'months')
                    if(grantHoliday > 12) {
                    	grantHoliday = 15
                    }
                    
                    const usedHoliday = holidays.length
                    const remainHoliday = grantHoliday - usedHoliday
                    if(remainHoliday == 0) {
                    	$('#addHolidayBtn').hide()
                    } else {
                    	$('#addHolidayBtn').show()
                    }
                    
                    $('#grantHoliday').text(`\${grantHoliday}`)
                    $('#usedHoliday').text(`\${usedHoliday}`)
                    $('#remainHoliday').text(remainHoliday)
                    $('#employeeName').text(employeeName)
                    $('#holidays').append('<tr><td colspan=3 class=text-center>연차내역이 없습니다.</td></tr>')
	            }
	        }
	    });
	}
	
    $(() => {
        // 연차 수정
        $('#holidays').on('click', '.fixHolidayBtn', function() {
            const holidayNo = $(this).closest('tr').attr('holidayNo')
            
            $('#modalMsg').empty()
            $('#modalMsg').append(`<p>날짜: <input type='date' id='fixHolidayDate' placeholder='날짜'/> </p>`)
            $('#modalBtn').show()
            $('#modal').modal('show')
            
           	$('#modalOKBtn').off('click').on('click', function() {
           		if(isVal($('#fixHolidayDate'))) {
           			let today = new Date()
                    let selectedDate = new Date($('#fixHolidayDate').val())
           			let holiday = {
	                    holidayNo: holidayNo,
	                    holDate: $('#fixHolidayDate').val() 
	                }
           			
           			if (selectedDate > today) {
		                $.ajax({
		                    url: '/admin/holiday/holidaylist/fix',
		                    type: 'put',
		                    contentType: 'application/json',
		                    data: JSON.stringify(holiday),
		                    success: listHolidays
		                })
           			} else {
                        setTimeout(function() {
                        	$('#modalMsg').empty()
                        	$('#modalMsg').text('날짜를 확인해주세요.')
                            $('#modalBtn').hide()
                            $('#modal').modal('show')
                          }, 300)    
                    }
           		}
       		})
        });
        // 연차 삭제
        $('#holidays').on('click', '.delHolidayBtn', function() {
            const holidayNo = $(this).closest('tr').attr('holidayNo')
            
            $('#modalMsg').empty()
            $('#modalMsg').append(`<p>해당 연차를 삭제 하시겠습니까?<p>`)
            $('#modalBtn').show()
            $('#modal').modal('show')
            $('#modalOKBtn').off('click').on('click', function() {
                $.ajax({
                    url: '/admin/holiday/holidaylist/del/' + holidayNo,
                    method: 'delete',
                    success: listHolidays
                })
            })
        });
        // 연차 추가
        $('#addHolidayBtn').click(() => {
            $('#modalMsg').empty()
            $('#modalMsg').append(`<p>날짜: <input type='date' id='addHolidayDate' placeholder='날짜'/></p>`)
                            .append(`<p>사유: <input type='text' class='pb-3' id='addHolidayContent' placeholder='사유' /></p>`)
            $('#modalBtn').show()
            $('#modal').modal('show')
            
            $('#modalOKBtn').off('click').on('click', function() {
            	if( isVal($('#addHolidayDate')) && isVal($('#addHolidayContent'))) {
            		let today = new Date()
                    let selectedDate = new Date($('#addHolidayDate').val())
                    
                    if (selectedDate > today) {
		                $.ajax({
		                    url: '/holiday/getholiday/add',
		                    type: 'post',
		                    data: {
		                        holDate: $('#addHolidayDate').val(),
		                        holContent: $('#addHolidayContent').val(),
		                        employeeNo: employeeNo
		                    },
		                    success: listHolidays
		                })
                    } else {
                        setTimeout(function() {
                        	$('#modalMsg').empty()
                        	$('#modalMsg').text('날짜를 확인해주세요.')
                            $('#modalBtn').hide()
                            $('#modal').modal('show')
                          }, 300)    
                    }
            	}
            })
        })
    })
</script>
<style>
    table > caption {
        font-size: .8rem;
    }
    table {
        table-layout: fixed;
    }
    th:last-child {
        padding-left: 1rem;
    }
    @media (max-width: 699px) {
        .row.pt-2 .col ul {
            padding-left: 0;
        }
    }
    
    li {
    list-style-type: disc;
}
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-4 mb-3'>
        <div class='col'>
            <div class='row'>
                <h1 class='p-3 text-center'><b>연차</b></h1>
                <div class='col pt-3 text-center'>
                    <h3><span id='employeeName'></span>님의 연차현황</h3>
                    <h3>잔여연차 : <span id='remainHoliday'></span> 일</h3> 
                </div>
            </div>
            <div class='row pt-2'>
                <div class='col-5'></div>
                <div class='col'>
                    <ul>
                        <li>부여연차: <span id='grantHoliday'></span>일</li>
                        <li>소진연차: <span id='usedHoliday'></span>일</li>
                    </ul>
                </div>
                <div class='col-3'>
                    <button class='btn btn-blue' id='addHolidayBtn'>연차신청</button>
                </div>
            </div>
        </div>
    </div>
    <div class='row mb-5'>
        <div class='col'>
            <table class='table'>
                <thead>
                    <tr>
                        <th>&nbsp;이름</th>
                        <th>연차사용일</th>
                        <th>수정 / 삭제</th>
                    </tr>
                </thead>
                <tbody id='holidays'>
                    
                </tbody>
                <caption class="text-end">*연차 사용일로부터 3일 전까지 수정, 삭제가 가능합니다.</caption>
            </table>
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
                <button type='button' class='btn btn-lightgray' id='modalCancelBtn' data-bs-dismiss='modal'>취소</button>
                <button type='button' class='btn btn-blue' id='modalOKBtn' data-bs-dismiss='modal'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>