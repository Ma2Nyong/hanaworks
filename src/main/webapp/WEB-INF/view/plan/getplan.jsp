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
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title>사내 일정 조회</title>
<script>
    let companyId = "${sessionScope.comId}"

    $(() => {
        input_user_header()
        btn_click()
        show_logout()
    })
    
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
	            let events = []
	            for (let i = 0; i < response.length; i++) {
	                let plan = response[i]
	                let event = {
	                    id: plan.planNo,
	                    title: plan.planTitle,
	                    description: plan.planContent,
	                    start: plan.planDate,
	                    extendedProps: {
	                    	type: 'plan'
	                    }
	                }
	                events.push(event)
	            }
	            calendar.events = events
	            successCallback(events)
	        },
	    })
	}
    
    function listHolidays(successCallback) {
        $.ajax({
            url: '/admin/plan/planlist/getHoliday',
            method: 'get',
            dataType: 'json',
            contentType: 'application/json',
	        data: {
	            companyId: companyId
	        },
            success: response => {
                let events = [];
                for (let i = 0; i < response.length; i++) {
                    let holiday = response[i]
                    let event = {
                        id: holiday.holNo,
                        title: holiday.empName + ' 연차',
                        description: holiday.holContent,
                        start: holiday.holDate,
                        extendedProps: {
	                    	type: 'holiday'
	                    }
                    }
                    events.push(event)
                }
                calendar.events = events
                successCallback(events)
            },
        })
    }
    
    document.addEventListener('DOMContentLoaded', () => {
        let calendarEl = document.getElementById('calendar')

        let calendar = new FullCalendar.Calendar(calendarEl, {
            
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: ''
            },
            initialView: 'dayGridMonth',
            navLinks: false, // can click day/week names to navigate views
            titleFormat : date => { // title 설정
                    return date.date.year +". "+(date.date.month +1); 
                    },
            buttonText: {
                today: '오늘'
            },
            height: 550,
            selectable: false,
            selectMirror: true,
            select: arg => {
                let title = prompt('제목:');
                if (title) {
                calendar.addEvent({
                    title: title,
                    start: arg.start,
                    end: arg.end,
                    allDay: arg.allDay
                })
                }
                calendar.unselect()
            },
          	
            // 일정 클릭
            eventClick: arg => {
                $('#modalMsg').empty()
                const eventType = arg.event.extendedProps.type

                if(eventType == 'plan') {
                    $('#modalMsg').append(`<p>제목: \${arg.event.title} </p>`)
                                .append(`<p>내용: \${arg.event.extendedProps.description} </p>`)
                } else {
                    $('#modalMsg').append(`<p>제목: \${arg.event.title} </p>`)
                                .append(`<p>사유: \${arg.event.extendedProps.description} </p>`)
                }
                $('#modalBtn').hide()
                $('#modal').modal('show')
            },
            editable: true,
            dayMaxEvents: false,
            events: (info, successCallback) => {
                $.ajax({
                    url: '/admin/plan/planlist/getPlan',
                    method: 'get',
                    dataType: 'json',
                    contentType: 'application/json',
        	        data: {
        	            companyId: companyId
        	        },
                    success: response => {
                        let events = [];
                        for (let i = 0; i < response.length; i++) {
                            let plan = response[i]
                            let event = {
                                id: plan.planNo,
                                title: plan.planTitle,
                                description: plan.planContent,
                                start: plan.planDate,
                                extendedProps: {
        	                    	type: 'plan'
        	                    }
                            }
                            events.push(event)
                        }
                        
                        listHolidays(holidayEvents => {
                            events = events.concat(holidayEvents)
                            successCallback(events)
                        })
                    },
                })
            },
            eventDrop: info => {
                info.revert()
            }
        })
        
        calendar.render()
  })
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

	#calendar {
		margin-bottom: 3rem;
	}
</style>
</head>
<body>
<div class='container'>
    <div class='row header'></div>
    <div class='row mt-5 mb-3'>
        <div class='col'>
            <h1 class='text-center'><b>일정</b></h1><br>
            <div id='calendar'></div>
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
                <button type='button' class='btn btn-blue' id='modalOKBtn'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>