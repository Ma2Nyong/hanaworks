<%@ page language='java' contentType='text/html; charset=utf-8' pageEncoding='utf-8'%>
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
<script src='../../res/common.js'></script>
<link rel="stylesheet" href="../../res/common.css">
<title> 연차 내역 조회 </title>
<script>
    $(() => {
        input_company_header()
        input_company_sidebar()
        btn_click()
        input_footer()
        show_logout()
        listHolidays()

        $('.fixHolidayBtn').click(() => {
            $('#modalMsg').empty()
            $('#modalMsg').append(`<p>날짜: <input type='date' id='fixHolidayDate'/> </p>`)
            $('#modalBtn').show()
            $('#modal').modal('show')

            $('#modalOKBtn').click(() => {
                $('#modalMsg').empty()
                $('#modalMsg').text('연차 수정 되었습니다.')
                $('#modalBtn').hide()
                $('#modal').modal('show')
            })
        })

        $('.delHolidayBtn').click(() => {
            $('#modalMsg').empty()
            $('#modalMsg').append(`<p>해당 연차를 삭제 하시겠습니까?<p>`)
            $('#modalBtn').show()
            $('#modal').modal('show')

            $('#modalOKBtn').click(() => {
                $('#modalMsg').empty()
                $('#modalMsg').text('연차 삭제 되었습니다.')
                $('#modalBtn').hide()
                $('#modal').modal('show')
            })
        })
    })
    
    $(function() {
        let today = new Date();
        let dateString = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();

        $("#datepicker").datepicker({
            onSelect: function(date) {
                today = new Date(date);
                dateString = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
                $("#yearMonth").text(dateString);
            }
        });

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
        });

        $("#nextBtn").click(function() {
            today.setMonth(today.getMonth() + 1);
            let year = today.getFullYear();
            let month = today.getMonth() + 1;
            yearMonthString = year + "." + ("" + month).slice(-2);
            $("#yearMonth").text(yearMonthString);
        });
    });
    
    function listHolidays() {
        $('#holidaylist').empty()
        
        $.ajax({
    		url: 'holidaylist/get',
    		dataType: 'json',
    		success: holidaylist => {
		        if(holidaylist.length) {
		            const holidayArr = []
		            
		            $.each(holidaylist, (i, holiday) => {
		            	holidayArr.unshift(
		                    `<tr>
		                        <td>\${holiday.employeeName}</td>
		                        <td>\${holiday.holDate}</td>
		                        <td><button type='button' class='btn btn-white btn-sm fixHolidayBtn'>수정</button>
                                <button type='button' class='btn btn-red btn-sm delHolidayBtn'>삭제</button></td>
		                    </tr>`
		                )
		            })
		    
		            $('#holidaylist').append(holidayArr.join(''))
		        } else $('#holidaylist').append(
		            '<tr><td colspan=4 class=text-center>연차내역이 없습니다.</td></tr>')
    		}
        })
    }
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
                            <button type='button' class='btn' id='planBtn' onclick="window.location.href='planlist'">사내일정 조회</button>
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
                        <tbody id='holidayList'>
                        </tbody>
                        <caption class="text-end">*연차 사용일로부터 3일 전까지 수정, 취소가 가능합니다.</caption>
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
                <button type='button' class='btn btn-blue' id='modalOKBtn'>확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>