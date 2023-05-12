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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/smoothness/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title> 연차 내역 조회 </title>
<script>
	let companyId = "${sessionScope.comId}"
	
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
	
	$(function() {
	    let today = new Date();
	    let dateString = today.getFullYear() + "." + (today.getMonth() + 1)
		
	    // 년 월 나타내기.
	    function displayToday() {
	        let year = today.getFullYear();
	        let month = today.getMonth() + 1;
	        let dateString = year + "." + month;
	        $("#yearMonth").prepend(dateString);
	    }
	
	    displayToday();
		
	    // 이전달 버튼
	    $("#prevBtn").click(function() {
	        today.setMonth(today.getMonth() - 1);
	        let year = today.getFullYear();
	        let month = today.getMonth() + 1;
	        yearMonthString = year + "." + ("" + month).slice(-2);
	        $("#yearMonth").text(yearMonthString);
	        listHolidays()
	    });
		
	    // 다음달 버튼
	    $("#nextBtn").click(function() {
	        today.setMonth(today.getMonth() + 1);
	        let year = today.getFullYear();
	        let month = today.getMonth() + 1;
	        yearMonthString = year + "." + ("" + month).slice(-2);
	        $("#yearMonth").text(yearMonthString);
	        listHolidays()
	    });
	});
	
	// 연차내역조회
	function listHolidays() {
	    $('#holidays').empty();
	    let yearMonth = $('#yearMonth').text();
	    yearMonth = yearMonth.split('.').map(Number);
	    yearMonth[1] = yearMonth[1] < 10 ? '0' + yearMonth[1] : yearMonth[1];
	    yearMonth = yearMonth.join('-');
	    $.ajax({
	        url: 'holidaylist/get',
	        dataType: 'json',
	        data: { 
	        	yearMonth: yearMonth,
	        	companyId: companyId
	        	},
	        success: holidays => {
	            if (holidays.length) {
	                const holidayArr = [];
	                $.each(holidays, (i, holiday) => {
	                    const today = new Date();
	                    const holidayDate = new Date(holiday.holDate);
	                    const timeDiff = holidayDate.getTime() - today.getTime();
	                    const daysDiff = timeDiff / (1000 * 3600 * 24);
	                    let fixdelBtn = '';
	                    if (daysDiff >= 3) {
	                    	fixdelBtn = `<button type='button' class='btn btn-white btn-sm fixHolidayBtn'>수정</button>
	                                   <button type='button' class='btn btn-red btn-sm delHolidayBtn'>삭제</button>`;
	                    }
	                    holidayArr.unshift(`
	                        <tr holidayNo='\${holiday.holidayNo}'>
	                            <td>\${holiday.empName}</td>
	                            <td>\${holiday.holDate}</td>
	                            <td>\${fixdelBtn}</td>
	                        </tr>
	                    `);
	                });
	                $('#holidays').append(holidayArr.join(''));
	            } else {
	                $('#holidays').append('<tr><td colspan=3 class=text-center>연차내역이 없습니다.</td></tr>');
	            }
	        }
	    });
	}
    $(() => {
        input_company_header()
        input_company_sidebar()
        btn_click()
        input_footer()
        show_logout()
        listHolidays()
		
        // 연차 수정
        $('#holidays').on('click', '.fixHolidayBtn', function() {
            const holidayNo = $(this).closest('tr').attr('holidayNo');
            
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
    	                    url: 'holidaylist/fix',
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
            const holidayNo = $(this).closest('tr').attr('holidayNo');
            
            $('#modalMsg').empty()
            $('#modalMsg').append(`<p>해당 연차를 삭제 하시겠습니까?<p>`)
            $('#modalBtn').show()
            $('#modal').modal('show')
            $('#modalOKBtn').off('click').on('click', function() {
                $.ajax({
                    url: 'holidaylist/del/' + holidayNo,
                    method: 'delete',
                    success: listHolidays
                })
            })
        });
    })
    
</script>
<style>
    #prevBtn, #nextBtn, #planBtn {
        color: white;
        background-color: darkslateblue;
    }
    #prevBtn, #nextBtn {
        flex: 0 0 auto;
        width: 30%;
    }
    table {
        table-layout: fixed;
    }
    
    th {
        padding-left: 1rem;
    }
    #yearMonth {
        display: inline-block;
        font-size: 1.75em;
        margin: 0;
    }
    #prevNextBtn {
        flex: 0 0 auto;
        width: 23%;
    }
    tr th:first-child, th:last-child {
        padding-left: 1rem;
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
                <h3><b>연차 내역 조회</b></h3>
            </div>
            <div class='row pt-4'>
                <div class='col'>
                    <div class='row'>
                        <div class='btn-group col' id='prevNextBtn'>
                            <button type='button' class="btn" id='prevBtn'>
		                        <i class="fa-solid fa-chevron-left"></i>
		                    </button>
		                    <button type='button' class="btn me-5" id='nextBtn'>
		                        <i class="fa-solid fa-chevron-right"></i>
		                    </button>
                 			
                        </div>
                        <div class='col'>
                            <div class='ps-4' id='yearMonth'></div>
                        </div>
                        <div class='col d-md-flex justify-content-md-end'>
                            <button type='button' class='btn' id='planBtn' onclick="window.location.href='../plan/planlist'">사내일정 조회</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class='row pt-3'>
                <div class='col'>
                    <table class='table'>
                        <thead>
                            <tr>
                                <th>이름</th>
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
                <button type='button' class='btn btn-blue' id='modalOKBtn' data-bs-dismiss='modal'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>