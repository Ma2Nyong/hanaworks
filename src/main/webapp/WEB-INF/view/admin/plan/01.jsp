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
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<script src='../../res/common.js'></script>
<link rel="stylesheet" href="../../res/common.css">
<title>ADMIN.PLAN.01 일정 조회 </title>
<script>
    $(() => {
        input_company_header()
        input_company_sidebar()
        btn_click()
        input_footer()
        show_logout()
    })
    
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            customButtons: {
                selectHolidays: {
                    text: '연차내역 조회',
                    click: function() {
                        location.href='../holiday/01.html';
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
            initialDate: '2023-03-17',
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

                
                $('#addPlanBtn').click(() => {
                    const planTitle = $('#planTitle').val()
                    const planDescription = $('#planDescription').val()

                    calendar.addEvent({
                        id: 'plan',
                        title: planTitle,
                        description: planDescription,
                        start: arg.start,
                        end: arg.end,
                        allDay: arg.allDay,
                        type: 'plan'
                    })

                    $('#modalMsg').empty()
                    $('#modalBtn1').empty()
                    $('#modalMsg').text('일정이 추가 되었습니다.')
                    $('#modalBtn').hide()
                    $('#modal').modal('show')


                    calendar.unselect()
                })
            },
            
            eventClick: function(arg) {
                $('#modalMsg').empty()
                $('#modalBtn1').empty()
                const eventId = arg.event.id

                if(eventId == 'holiday') {
                    $('#modalMsg').append(`<p>제목: ${arg.event.title} </p>`)
                                .append(`<p>사유: ${arg.event.extendedProps.description} </p>`)
                    $('#modalBtn').hide()
                } else {
                    $('#modalMsg').append(`<p>제목: <input type='text' placeholder='${arg.event.title}' id='planTitle'/> </p>`)
                                .append(`<p>내용: <input type='text' class='pb-3' placeholder='${arg.event.extendedProps.description}' id='planDescription'/> </p>`)
                    $('#modalBtn').show()
                }
                $('#modal').modal('show')
                $('#modalBtn1').hide()


                $('#fixPlanBtn').click(() => {
                    $('#modalMsg').empty()
                    $('#modalMsg').text('일정이 수정 되었습니다.')
                    $('#modalBtn').hide()
                    $('#modal').modal('show')
                })

                $('#delPlanBtn').click(() => {
                    $('#modalMsg').empty()
                    $('#modalMsg').text('일정이 삭제 되었습니다.')
                    $('#modalBtn').hide()
                    $('#modal').modal('show')

                    arg.event.remove();
                })
            },
            editable: true,
            dayMaxEvents: false, // allow "more" link when too many events
            events: [
                {
                    id: 'plan',
                    title: '회식',
                    description: '이젠삼겹살 16:00.',
                    start: '2023-03-03',
                },
                {
                    id: 'holiday',
                    title: '이선재 연차',
                    description: '개인 사유',
                    start: '2023-03-10',
                },
                {
                    id: 'holiday',
                    title: '오진성 연차',
                    description: '개인 사유',
                    start: '2023-03-14',
                },
                {
                    id: 'holiday',
                    title: '오진성 연차',
                    description: '개인 사유',
                    start: '2023-03-16',
                },
                {
                    id: 'holiday',
                    title: '최서영 연차',
                    description: '개인 사유',
                    start: '2023-03-20',
                },
                {
                    id: 'plan',
                    title: '워크샵',
                    description: '속초 이젠해수욕장',
                    start: '2023-03-23',
                    end: '2023-03-25'
                },
                {
                    id: 'holiday',
                    title: '김민형 연차',
                    description: '개인 사유',
                    start: '2023-03-27',
                },
                {
                    id: 'holiday',
                    title: '송하나 연차',
                    description: '개인 사유',
                    start: '2023-03-31',
                }
            ]
            
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
            <div class='row'>
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