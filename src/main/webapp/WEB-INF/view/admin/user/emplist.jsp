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
<script src='<c:url value="/res/common.js"/>'></script>
<link rel='stylesheet' href='<c:url value="/res/common.css"/>'>
<title>직원목록</title>
<script>
	let companyId = "${sessionScope.comId}"

	function isVal(field) {        
	    let isGood = false
	    let errMsg
	
	    if(!field.length) errMsg = '직원을 선택하세요.'
	    else isGood = true
	
	    if(!isGood) {
	    	$('#modalMsg').text(errMsg)
	        $('#modalBtn').hide()
	        $('#modal').modal('show')           
	    }
	
	    return isGood
	}

	function listEmployees() {
		$('input').not(':radio').val('')
	    $('#employees').empty();
	
	    $.ajax({
	        url: 'emplist/get',
	        method: 'get',
	        dataType: 'json',
	        data: {
	        	companyId: companyId
	        },
	        success: employees => {
	            if (employees.length) {
	                const employeeArr = [];
	
	                $.each(employees, (i, employee) => {
	                    employeeArr.unshift(`
                    		<tr class='employee-info'>
	                        	<td><input type='radio' value='\${employee.employeeNo}' id='employeeNo' name='employee'></td>
	                            <td>\${employee.empName}</td>
	                            <td>\${employee.empPh}</td>
	                            <td>\${employee.empPosition ? employee.empPosition : ''}</td>
    							<td>\${employee.empAddr}</td>
    							<td>\${employee.empEmail}</td>
    							<td>\${employee.hireDate}</td>
	                        </tr>
	                    `);
	                });
	
	                $('#employees').append(employeeArr.join(''));
	            } else {
	                $('#employees').append('<tr><td colspan=7 class=text-center>직원이 없습니다.</td></tr>');
	            }
	        }
	    });
	}

	function fixMove() {
		  const employeeNo = $('#employeeNo:checked').val();
		  
		  if(employeeNo > 0) {
			  location.href = 'fixemp?employeeNo=' + employeeNo;  
		  } else {
			  $('#modalMsg').empty()
              $('#modalMsg').text('수정하실 직원을 선택하세요.')
              $('#modalBtn').hide()
              $('#modal').modal('show')
		  }
	}

    $(() => {
        input_company_header()
        input_company_sidebar()
        input_footer()
        btn_click()
        show_logout()
        listEmployees()

        
        $('#employeeDelBtn').click(() => {
        	if(isVal($('#employeeNo:checked'))) {
	        	$('#modalMsg').empty()
	            $('#modalMsg').text('삭제하시겠습니까?')
	            $('#modalBtn').show()
	            $('#modal').modal('show')
	            
	            $('#modalOKBtn').off('click').on('click', function() {
	                $.ajax({
	                    url: 'emplist/del/' + $('#employeeNo:checked').val(),
	                    method: 'delete',
	                    success: listEmployees
	                })
	            })
        	}
        });
        
        $(document).on('click', '.employee-info td:not(:first-child)', function() {
            const employeeNo = $(this).siblings(':first-child').find('input[type="radio"]').val();

            $.ajax({
                url: 'emplist/getInfo/' + employeeNo,
                method: 'get',
                dataType: 'json',
                success: employees => {
                    if (employees.length) {
                        const employee = employees[0];
                        $('#modalMsg').empty();
                        
                        $('#modalMsg').append(`<img src='/attach/\${employee.profileName ? employee.profileName : "emp_img.png"}' class='employeeImage'>`)
                        				.append(`<p> 이름: \${employee.empName} </p>`)
                        				.append(`<p> 전화번호: \${employee.empPh} </p>`)
                        				.append(`<p> 주민등록번호: \${employee.empPino} </p>`)
                        				.append(`<p> 직급: \${employee.empPosition ? employee.empPosition : ''} </p>`)
                        				.append(`<p> 주소: \${employee.empAddr} </p>`)
                        				.append(`<p> 상세주소: \${employee.empDetailAddr} </p>`)
                        				.append(`<p> 우편번호: \${employee.empPostcode} </p>`)
                        				.append(`<p> 이메일: \${employee.empEmail} </p>`)
                        				.append(`<p> 입사일: \${employee.hireDate} </p>`)
                        $('#modalBtn').hide();
                        $('#modal').modal('show');
                    }
                }
            });
        });
    })
</script>
<style>
	.employeeImage {
		width: 12rem; 
		height: auto; 
		margin: 0 auto;
		display: block;
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
                <div class='col'>
                    <h3><b>직원조회</b></h3>
                </div>
                <div class='col pt-3'>
                    <div class='gap-2 d-flex justify-content-end'>
                        <button type='button' class='btn btn-blue' onclick="location.href='addemp'">추가</button>
                        <button type='button' class='btn btn-white' onclick="fixMove()">수정</button>
                        <button type='button' class='btn btn-red' id='employeeDelBtn'>삭제</button>
                    </div>
                </div> 
            </div>                 
            <div class='row'>
                <div class='col'>
                    <table class='table'>
                        <thead>
                            <tr><th>선택</th><th>이름</th><th>전화번호</th><th>직급</th><th>주소</th><th>이메일</th><th>입사일</th></tr>
                        </thead>
                        <tbody id='employees'>
                            
                        </tbody>
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
