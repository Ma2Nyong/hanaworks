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
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title></title>
<script>
	let employeeNo = "${sessionScope.empNo}"

    $(function() {
	    let today = new Date();
	    let dateString = today.getFullYear() + "." + (today.getMonth() + 1)
		
	    function displayToday() {
	        let year = today.getFullYear();
	        let month = today.getMonth() + 1;
	        let dateString = year + "." + month;
	        $("#yearMonth").prepend(dateString);
	    }
	
	    displayToday();
		
	    $("#prevBtn").click(function() {
	        today.setMonth(today.getMonth() - 1);
	        let year = today.getFullYear();
	        let month = today.getMonth() + 1;
	        yearMonthString = year + "." + ("" + month).slice(-2);
	        $("#yearMonth").text(yearMonthString);
	        listWorkHolidays()
	    });
		
	    $("#nextBtn").click(function() {
	        today.setMonth(today.getMonth() + 1);
	        let year = today.getFullYear();
	        let month = today.getMonth() + 1;
	        yearMonthString = year + "." + ("" + month).slice(-2);
	        $("#yearMonth").text(yearMonthString);
	        listWorkHolidays()
	    });
	});
	
	function listWorkHolidays() {
	    $('#workHolidays').empty();
	    let yearMonth = $('#yearMonth').text();
	    yearMonth = yearMonth.split('.').map(Number);
	    yearMonth[1] = yearMonth[1] < 10 ? '0' + yearMonth[1] : yearMonth[1];
	    yearMonth = yearMonth.join('-');
	    $.ajax({
	        url: 'getlist/get',
	        dataType: 'json',
	        data: { 
	        	yearMonth: yearMonth,
	        	employeeNo: employeeNo
        	},
	        success: works => {
	            if (works.length) {
	                const workArr = [];
	                $.each(works, (i, work) => {
	                	const startTime = new Date(work.startTime);
	                    const endTime = new Date(work.endTime);
	                    
	                    const workYear = startTime.getFullYear()
	                    const workMonth = (startTime.getMonth() + 1).toString().padStart(2, '0');
	                    const workDay = startTime.getDate().toString().padStart(2, '0');
						const workToDay = workYear + '-' + workMonth + '-' + workDay
	                    let workNo = `\${work.workNo}`
						
	                    let startHour = startTime.getHours().toString().padStart(2, '0');
	                    const startMinute = startTime.getMinutes().toString().padStart(2, '0');
	                    const endHour = endTime.getHours().toString().padStart(2, '0');
	                    const endMinute = endTime.getMinutes().toString().padStart(2, '0');
	                    let plusWorkHour = 0
		                let workHour = 0
		                
	                    if(startHour < 9) {
	                    	workHour = endHour - 9
	                    } else {
	                    	workHour = endHour - startHour
	                    }
	                    
	                    if(startMinute > 0) {
	                    	workHour = endHour - startHour - 1
	                    }
	                    
	                    if(workHour < 0) workHour = 0
	                    
	                    if (workHour >= 9) {
	                    	plusWorkHour = (workHour - 9)
	                    	workHour = 8
	                    } else {
	                    	plusWorkHour = 0
	                    }
	                    
	                    let endTimes = endHour + ':' + endMinute
	                      
	                      if(work.endTime == null) {
	                         endTimes = ''
	                      }
	                    
	                    if(workNo != 0) {
	                    	workArr.unshift(`
	                        		<tr>
	       	                            <td>\${workToDay}</td>
	       	                            <td>\${startHour}:\${startMinute}</td>
	       	                            <td>\${endTimes}</td>
	       	                            <td>\${workHour}h</td>
	       	                            <td>\${plusWorkHour}h</td>
	       	                            <td></td>
	       	                        </tr>
	    	                    `)
	                    } else {
	                    	workArr.unshift(`
                    			<tr>
       	                            <td>\${workToDay}</td>
       	                            <td>00:00</td>
       	                            <td>00:00</td>
       	                            <td>0h</td>
       	                            <td>0h</td>
       	                            <td>연차</td>
       	                        </tr>
                   			`)
	                    }
	                    
	                });
	                $('#workHolidays').append(workArr.join(''));
	            } else {
	                $('#workHolidays').append('<tr><td colspan=6 class=text-center>근로내역이 없습니다.</td></tr>');
	            }
	        }
	    });
	}
	
	$(() => {
        input_user_header()
        btn_click()
        show_logout()
        listWorkHolidays()
        
        if(employeeNo.length < 1) {
        	location.href='/'
        }
    })
</script>
<style>
    #prevBtn, #nextBtn {
        color: white;
        background-color: darkslateblue;
    }

    #prevBtn, #nextBtn {
        flex: 0 0 auto;
        width: 2.4rem;
    }


    #yearMonth {
        display: inline-block;
        font-size: 1.75em;
        margin: 0;
    }
</style>
</head>
<body>
<div class='container'>
<div class='row header'></div>
<div class='row'>
    <div class='col mt-4 mb-4'>  
        <h3 class='text-center'><b>근로내역 조회</b></h3>
    </div>
</div>
<div class='row'>
    <div class='col d-flex'>
        <div class='col-3'>
            <button type='button' class="btn" id='prevBtn'>
                <i class="fa-solid fa-chevron-left"></i>
            </button>
            <button type='button' class="btn" id='nextBtn'>
                <i class="fa-solid fa-chevron-right"></i>
            </button>
        </div>
        <div class='col'>
            <div id='yearMonth'></div>
        </div>
    </div>
</div>
<div class='row mb-5'>
    <div class='col'>
        <table class='table table-sm'>
            <thead>
                <tr><th>일자</th><th>출근</th><th>퇴근</th><th>근무시간</th><th>추가근무시간</th><th>비고</th></tr>
            </thead>
            <tbody id='workHolidays'>
                <tr>
                	<td>2023-01-03</td>
                	<td>09:30</td>
                	<td>20:00</td>
                	<td>9h</td>
                	<td>2h</td>
                	<td></td>
               	</tr>
            </tbody>
        </table>
    </div>
</div>
<div class='navigation'></div>
</div>
</body>
</html>