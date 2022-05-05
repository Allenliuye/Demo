<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<meta charset="utf-8">
<title>後臺系統</title>
<style>
        .gray1 {
            filter: grayscale(1);
        }

        .gray0 {
            filter: grayscale(0);
        }

        .center {
            width: 300px;
            margin: 0px auto;
        }

        p {
            display: flex;
            justify-content: center;
            font-size: 40px;
        }
    </style>
</head>
<body>
<header class="head">
    <div class="center">
    <h2>歡迎 ${admin.username} 使用本系統</h2>
    </div>
    
    </header>
        <article>
        <header class="headerlist">
            <ul class="list1">
                <li><a href="${contextRoot}/frontPage">首頁</a></li>
                <li><a href="${contextRoot}/getPersonalInformation">個人資料</a></li>
								<li><a href="${contextRoot}/getPersonalPunchData">個人打卡紀錄</a></li>
				<c:if test="${admin.fkTitleId.titleId >= 10 || admin.fkDeptno.deptno == 300 && admin.fkDeptno.deptno == 400 }">
				<li><a href="${contextRoot}/getEmpPunchData">員工打卡紀錄</a></li>
				</c:if>
				<c:if test="${admin.fkTitleId.titleId >= 30 || admin.fkDeptno.deptno == 300 && admin.fkDeptno.deptno == 400 }">
				<li><a href="${contextRoot}/employeeDataProcessing">員工資料處理</a></li>
				</c:if>
                <li><a href="${contextRoot}/singOut">登出</a></li>
            </ul>
        </header>
        </article>
        <article class="block2">
            <div class="d-flex h-100 justify-content-center align-items-center">
		<div class="modal-dialog w-100 mx-auto">
			<div class="modal-content">
				<div class="modal-body">
					<div class="h5 modal-title text-center">
						<h4 class="mt-2">
							<span>請輸入您的舊密碼:</span>
						</h4>
					</div>
					<form class="" method="post" action="${contextRoot}/changeNewPassword">
						<div class="form-row">
						<div class="col-md-12">
								<div class="position-relative form-group">
									<input name="oldPass" id="oldPass" placeholder="舊密碼"
										type="text" class="form-control">
								</div>
							</div>
							<div class="col-md-12">
								<div class="position-relative form-group">
									<input name="newPassword" id="newPassword" placeholder="新密碼"
										type="password" class="form-control">
									<input name="newPassword2" id="newPassword2" placeholder="請在輸入新密碼"
										type="password" class="form-control">
								</div>
							</div>
									<div>
									<span style="color: red">${errors.oldPassError}</span>
									</div>
									<div>
									<span class="error" style="display:block;color: red">${errors.passwordError}</span>
									</div>
									<div>
									<span style="color: red">${errors.newPassword}</span>
									</div>
									<div>
									<span style="color: red">${errors.newPassword2}</span>
									</div>
									<div>
									<input type="text" value="${emp.empId}" name="empId" hidden="" >
									</div>
						</div>
						<div class="modal-footer clearfix">
							<div class="float-right">
								<button class="btn btn-primary btn-lg" id="submit">送出</button>
							</div>
						</div>
					</form>
					<div class="float-right">
						<button class="btn btn-success btn-lg" id="newPass">新密碼</button>
					</div>
				</div>
			</div>
		</div>
	</div>
        </article>



        <footer>

        </footer>
         <script type="text/javascript">

         $("#submit").click(function(){
        		if(confirm('確定要修改嗎?')){
        			return true;
        		}else{
        			return false;
        		}
        	})
        	
        $("#newPass").click(function(){
        	$("#newPassword").val("Passw0rd123@");
        	$("#newPassword2").val("Passw0rd123@");
        })

    	</script>
</body>
</html>