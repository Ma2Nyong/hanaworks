<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
<html>
<head>
<title></title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css' rel='stylesheet'>
<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js'></script>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
        integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="/resources/fullcalendar/lib/main.min.css" rel="stylesheet"/>
<script src="/resources/fullcalendar/lib/main.min.js"></script>
<script src="/resources/fullcalendar/lib/locales/ko.js"></script>
<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>
<style>
    body {
        width: 100%;
        overflow: hidden;
    }
    
    li {
        list-style-type: none;
    }
    a {
        text-decoration: none;
        color: black;
    }

    .gnb {
        position: absolute;
        width: 8rem;
        background-color: lightgray;
        padding: .5rem;
    }   

    .logo_img {
        width: 100%;
        height: 2.5rem;
        border: .01rem solid gray;
    }
    
    .btns>button {
        font-size: .7rem
    }

    .temporary {
        padding: 9rem;
    }

    .footer {
        position: relative;
        height: 5.5rem;
        background-color: #ddd;
    }
    .footer_txt {
        font-size: .7rem;
        letter-spacing: -2px;
    }
</style>
<script>
    $(() => {
        $('.gnb_btn').click(() => 
            $('.gnb').toggleClass('show')
        )
    })
    
    document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: ''
      },
      initialView: 'dayGridMonth',
      locale: 'ko',
      initialDate: '2023-03-17',
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg) {
        var title = prompt('제목:');
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
      eventClick: function(arg) {
        if (confirm('일정을 삭제하시겠습니까?')) {
          arg.event.remove()
        }
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
    	  {
            title: '회식',
            start: '2023-03-03',
          },
          {
            title: '이선재 연차',
            start: '2023-03-10',
          },
          {
            title: '오진성 연차',
            start: '2023-03-14',
          },
          {
            title: '오진성 연차',
            start: '2023-03-16',
          },
          {
            title: '최서영 연차',
            start: '2023-03-20',
          },
          {
            title: '워크샵',
            start: '2023-03-23',
            end: '2023-03-25'
          },
          {
            title: '김민형 연차',
            start: '2023-03-27',
          },
          {
            title: '송하나 연차',
            start: '2023-03-31',
          }
      ]
    });

    calendar.render();
  });
    
</script>
</head>
<body>
<div class='container'>
    <div class='row header mt-1'>
        <div class='col'>
            <div class='row'>
                <div class='col ham'>
                    <button type='button' class='btn gnb_btn'><i class="fa-solid fa-bars"></i></button>
                    <ul class='gnb collapse'>
                        <li><a href=''>공지사항</a></li>
                        <li><a href=''>문의사항</a></li>
                        <li><a href=''>출/퇴근등록</a></li>
                        <li><a href=''>휴가관리</a></li>
                        <li><a href=''>근로내역</a></li>
                        <li><a href=''>사내일정</a></li>
                        <li><a href=''>비밀번호변경</a></li>
                    </ul>
                </div>
    
                <div class='logo col'>
                    <div class='logo_img text-center'>로고</div>
                </div>

                <div class='btns col float-end'>
                    <button type='button' class='btn float-end'>회원가입</button>
                    <button type='button' class='btn float-end'>로그인</button>
                    <button type='button' class='btn float-end collapse'>로그아웃</button>
                    <button type='button' class='btn float-end collapse'>마이페이지</button>
                </div>
            </div>
        </div>
    </div>
    <div class='row mt-5'>
         <div id='calendar'></div>
    </div>
</div>
<div class='row mt-5'>
    <div class='col footer'>
        <p class='text-center mt-3 footer_txt'>
            HANAWORKS 하나웍스 &nbsp; 서울 관악구 신림로 340 6층 대표이사: 송하나<br>
            사업자등록번호: 105-80-**187 &nbsp; 대표전화: 1588-15**(발신자 부담 전화)<br>
            COPYRIGHT HANAWORKS COMPANY ALL RIGHTS RESERVED
        </p>
    </div>
</div>
</body>
</html>