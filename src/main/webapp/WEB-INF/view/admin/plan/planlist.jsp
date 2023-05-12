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
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title>일정 조회</title>
<script>
	let companyId = "${sessionScope.comId}"

	$(() => {
	    input_company_header()
	    input_company_sidebar()
	    btn_click()
	    input_footer()
	    show_logout()
	})
	
	function isVal(field) {        
	    let isGood = false
	    let errMsg
	
	    if(!field.val()) errMsg = field.attr('placeholder') + '을 입력하세요.'
	    else isGood = true
	
	    if(!isGood) {            
	    	setTimeout(function() {
             $('#modalMsg').text(errMsg)
             $('#modalBtn').hide()
             $('#modalBtn1').hide()
             $('#modal').modal('show')
           }, 300)
	    }
	
	    return isGood
	}
	
	
  	function listPlans(successCallback) {
	    $.ajax({
	        url: 'planlist/getPlan',
	        method: 'get',
	        dataType: 'json',
	        contentType: 'application/json',
	        data: {
	            companyId: companyId
	        },
	        success: function(response) {
	            let events = [];
	            for (let i = 0; i < response.length; i++) {
	                let plan = response[i];
	                let event = {
	                    id: plan.planNo,
	                    title: plan.planTitle,
	                    description: plan.planContent,
	                    start: plan.planDate,
	                    extendedProps: {
	                    	type: 'plan'
	                    }
	                };
	                events.push(event);
	            }
	            calendar.events = events;
	            successCallback(events);
	        },
	    });
	}
    
    // 회사 company_id 의 소속된 직원들의 employee_no 로 검색?
    function listHolidays(successCallback) {
        $.ajax({
            url: 'planlist/getHoliday',
            method: 'get',
            dataType: 'json',
            contentType: 'application/json',
            data: {
            	companyId: companyId
            },
            success: function(response) {
                let events = [];
                for (let i = 0; i < response.length; i++) {
                    let holiday = response[i];
                    let event = {
                        id: holiday.holidayNo,
                        title: holiday.empName + ' 연차',
                        description: holiday.holContent,
                        start: holiday.holDate,
                        extendedProps: {
	                    	type: 'holiday'
	                    }
                    };
                    events.push(event);
                }
                calendar.events = events;
                successCallback(events);
            },
        });
    }
    
    let currentEvent;
    
    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            customButtons: {
                selectHolidays: {
                    text: '연차내역 조회',
                    click: function() {
                        location.href='../holiday/holidaylist';
                    }
                }
            },
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'selectHolidays'
            },
            buttonText: {
                today: '오늘'
            },
            
            initialView: 'dayGridMonth',
            navLinks: false,
            titleFormat : function(date) { 
                return date.date.year +". "+(date.date.month +1); 
            },
            selectable: true,
            selectMirror: true,
            select: function(arg) {
                $('#modalMsg').empty()
                $('#modalBtn1').empty()
                $('#modalMsg').append(`<p>제목: <input type='text' id='planTitle' placeholder='제목'/> </p>`)
                                .append(`<p>내용: <input type='text' class='pb-3'id='planDescription' placeholder='내용'/></p>`)
                $('#modalBtn1').append(`<button type='button' class='btn btn-blue m-2' id='addPlanBtn' data-bs-dismiss='modal'>추가</button>`)
                $('#modalBtn1').show()
                $('#modalBtn').hide()
                $('#modal').modal('show')
                // 일정 추가.
                $('#addPlanBtn').click(() => {
                	if(isVal($('#planTitle')) && isVal($('#planDescription'))) {
	                    const planTitle = $('#planTitle').val()
	                    const planDescription = $('#planDescription').val()
	                    const planDate = moment(arg.start).format('YYYY-MM-DD');
	
	                    $.ajax({
	                        url: 'planlist/add',
	                        type: 'post',
	                        data: {
	                          planTitle: planTitle,
	                          planDate: planDate,
	                          planContent: planDescription,
	                          companyId: companyId
	                        },
	                        success: function() {
	                        	listPlans(function(events) {
				                    calendar.getEventSources().forEach(function(eventSource) {
				                            eventSource.refetch();
				                    });
				                });
				            }
	                    });
	                    calendar.unselect()
                	}
                })
              },
            
            eventClick: function(arg) {
            	currentEvent = null;
            	currentEvent = arg.event;
                $('#modalMsg').empty()
                $('#modalBtn1').empty()
                const eventType = arg.event.extendedProps.type
				// holiday에서 추가한 연차와 plan에서 추가한 연차를 구분
                if(eventType == 'holiday') {
                    $('#modalMsg').append(`<p>제목: \${currentEvent.title} </p>`)
                                .append(`<p>사유: \${currentEvent.extendedProps.description} </p>`)
                    $('#modalBtn').hide()
                } else {
                    $('#modalMsg').append(`<p>제목: <input type='text' value='\${currentEvent.title}' id='planTitle' placeholder='제목'/> </p>`)
                                .append(`<p>내용: <input type='text' class='pb-5' value='\${currentEvent.extendedProps.description}' id='planDescription' placeholder='내용'/> </p>`)
                    $('#modalBtn').show()
                }
                $('#modal').modal('show')
                $('#modalBtn1').hide()
                
				// 일정 수정.
                 $('#fixPlanBtn').off('click').on('click', function() {
               	 	if(isVal($('#planTitle')) && isVal($('#planDescription'))) {
               	 		
				        const planNo = currentEvent.id;
				        const planTitle = $('#planTitle').val();
				        const planDescription = $('#planDescription').val();
				        const planDate = moment(currentEvent.start).format('YYYY-MM-DD');
				
				        let plan = {
				            planNo: planNo,
				            planTitle: planTitle,
				            planDate: planDate,
				            planContent: planDescription
				        };
				
				        $.ajax({
				            url: 'planlist/fix',
				            type: 'put',
				            contentType: 'application/json',
				            data: JSON.stringify(plan),
				            success: function() {
				                listPlans(function(events) {
				                    calendar.getEventSources().forEach(function(eventSource) {
				                            eventSource.refetch();
				                    });
				                });
				            }
				        });
               	 	}
			    });
                // 일정 삭제.
                $('#delPlanBtn').off('click').on('click', function() {
                    const planNo = currentEvent.id;
                    $.ajax({
                        url: 'planlist/del/' + planNo,
                        method: 'delete',
                        success: function() {
                        	listPlans(function(events) {
			                    calendar.getEventSources().forEach(function(eventSource) {
			                            eventSource.refetch();
			                    });
			                });
			            }
                    });
                });
            },
            editable: false,
            dayMaxEvents: false,
            events: function(info, successCallback) {
                $.ajax({
                    url: 'planlist/getPlan',
                    method: 'get',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: {
                    	companyId: companyId
                    },
                    success: function(response) {
                        let events = [];
                        for (let i = 0; i < response.length; i++) {
                            let plan = response[i];
                            let event = {
                                id: plan.planNo,
                                title: plan.planTitle,
                                description: plan.planContent,
                                start: plan.planDate,
                                extendedProps: {
        	                    	type: 'plan'
        	                    }
                            };
                            events.push(event);
                        }
                        
                        listHolidays(function(holidayEvents) {
                            events = events.concat(holidayEvents);
                            successCallback(events);
                        });
                    },
                });
            },
            eventDrop: function(info) {
                info.revert();
            }
        });
    calendar.render();
});
</script>
<style>
    .fc .fc-button-primary {
        color: #fff;
        color: var(--fc-button-text-color, #fff);
        background-color: darkslateblue;
        background-color: var(--fc-button-bg-color, darkslateblue);
        border-color: darkslateblue;
        border-color: var(--fc-button-border-color, darkslateblue);
    }
    .fc-h-event  {
        background-color: darkblue;
        border-color:darkblue;
    }
    #modalMsg input {
        width: calc(100% - 3rem);
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
                <h3><b>일정</b></h3><br>
            </div>
            <div class='row pt-4'>
                <div class='col'>
                    <div id='calendar'></div>
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
                <button type='button' class='btn btn-white' id='fixPlanBtn' data-bs-dismiss='modal'>수정</button>
                <button type='button' class='btn btn-red' id='delPlanBtn' data-bs-dismiss='modal'>삭제</button>
            </div>
            <div class='modal-footer' id='modalBtn1'>
            </div>
        </div>
    </div>
</div>
</body>
</html>