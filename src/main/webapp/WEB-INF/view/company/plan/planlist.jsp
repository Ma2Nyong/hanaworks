<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<html>
<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css' rel='stylesheet'>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
        integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='../../res/common.js'></script>
<link rel="stylesheet" href="../../res/common.css">
<title>일정 조회</title>
<script>
    $(() => {
        input_company_header()
        input_company_sidebar()
        btn_click()
        input_footer()
        show_logout()
    })

   function listPlans(successCallback) {
	    $.ajax({
	        url: 'planlist/get',
	        method: 'get',
	        dataType: 'json',
	        success: function(response) {
	            let events = [];
	            for (let i = 0; i < response.length; i++) {
	                let plan = response[i];
	                let event = {
	                    id: plan.planNo,
	                    title: plan.planTitle,
	                    description: plan.planContent,
	                    start: plan.planDate
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
                        location.href='holidaylist';
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
            initialDate: '2023-03-31',
            navLinks: false,
            titleFormat : function(date) { 
                return date.date.year +". "+(date.date.month +1); 
            },
            selectable: true,
            selectMirror: true,
            select: function(arg) {
                $('#modalMsg').empty()
                $('#modalBtn1').empty()
                $('#modalMsg').append(`<p>제목: <input type='text' id='planTitle'/> </p>`)
                                .append(`<p>내용: <input type='text' class='pb-3'id='planDescription'/></p>`)
                $('#modalBtn1').append(`<button type='button' class='btn btn-blue m-2' id='addPlanBtn'>추가</button>`)
                $('#modalBtn1').show()
                $('#modalBtn').hide()
                $('#modal').modal('show')

                // 일정 추가.
                $('#addPlanBtn').click(() => {
                    const planTitle = $('#planTitle').val()
                    const planDescription = $('#planDescription').val()
                    const planDate = moment(arg.start).format('YYYY-MM-DD');


                    $.ajax({
                    	url: 'planlist/add',
                    	type: 'post',
                        data: {
                          planTitle: planTitle,
                          planDate: planDate,
                          planContent: planDescription
                        },
                        success: function() {
                            listPlans(function(events) {
                                calendar.removeAllEvents();
                                calendar.addEventSource(events);
                            });
                        },
                    });

                    $('#modalMsg').empty()
                    $('#modalBtn1').empty()
                    $('#modalMsg').text('일정이 추가 되었습니다.')
                    $('#modalBtn').hide()
                    $('#modal').modal('show')

                    calendar.unselect()
                })
            },
            
            eventClick: function(arg) {
            	currentEvent = null;
            	currentEvent = arg.event;
                $('#modalMsg').empty()
                $('#modalBtn1').empty()
                const eventId = arg.event.id
				// holiday에서 추가한 연차와 plan에서 추가한 연차를 구분해야한다.
                if(eventId == 'holiday') {
                    $('#modalMsg').append(`<p>제목: ${currentEvent.title} </p>`)
                                .append(`<p>사유: ${currentEvent.extendedProps.description} </p>`)
                    $('#modalBtn').hide()
                } else {
                    $('#modalMsg').append(`<p>제목: <input type='text' value='\${currentEvent.title}' id='planTitle'/> </p>`)
                                .append(`<p>내용: <input type='text' class='pb-5' value='\${currentEvent.extendedProps.description}' id='planDescription'/> </p>`)
                    $('#modalBtn').show()
                }
                $('#modal').modal('show')
                $('#modalBtn1').hide()
                
				// 일정 수정.
                 $('#fixPlanBtn').off('click').on('click', function() {
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
			                    calendar.removeAllEvents();
			                    calendar.addEventSource(events);
			                });
			            },
			        });
			
			        $('#modalMsg').empty();
			        $('#modalMsg').text('일정이 수정 되었습니다.');
			        $('#modalBtn').hide();
			        $('#modal').modal('show');
			    });

                // 일정 삭제.
                $('#delPlanBtn').off('click').on('click', function() {
                    const planNo = currentEvent.id;
                    $.ajax({
                        url: 'planlist/del/' + planNo,
                        method: 'delete',
                        success: function(response) {
                            listPlans(function(events) {
                                calendar.removeAllEvents();
                                calendar.addEventSource(events);
                            });
                        }
                    });

                    $('#modalMsg').empty();
                    $('#modalMsg').text('일정이 삭제 되었습니다.');
                    $('#modalBtn').hide();
                    $('#modal').modal('show');
                });
            },
            editable: false,
            dayMaxEvents: false, // allow "more" link when too many events
            events: function(info, successCallback) {
                $.ajax({
                    url: 'planlist/get',
                    method: 'get',
                    dataType: 'json',
                    success: function(response) {
                        let events = [];
                        for (let i = 0; i < response.length; i++) {
                            let plan = response[i];
                            let event = {
                                id: plan.planNo,
                                title: plan.planTitle,
                                description: plan.planContent,
                                start: plan.planDate
                            };
                            events.push(event);
                        }
                        successCallback(events);
                    },
                });
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
                <button type='button' class='btn btn-white' id='fixPlanBtn'>수정</button>
                <button type='button' class='btn btn-red' id='delPlanBtn'>삭제</button>
            </div>
            <div class='modal-footer' id='modalBtn1'>
            </div>
        </div>
    </div>
</div>
</body>
</html>