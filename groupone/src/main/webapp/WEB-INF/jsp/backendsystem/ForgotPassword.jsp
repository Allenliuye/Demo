<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link href="${contextRoot}/css/backend_system_style.css"
	rel="stylesheet" />
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="mx-auto app-login-box col-md-6">
		<div class="app-logo-inverse mx-auto mb-3"></div>
		<div class="modal-dialog w-100">
			<div class="modal-content">
				<div class="modal-header">
					<div class="h5 modal-title">
						忘記密碼?
						<h6 class="mt-1 mb-0 opacity-8">
							<span>請輸入您的Email來找回密碼</span>
						</h6>
					</div>
				</div>
				<div class="modal-body">
					
						<form action="${contextRoot}/forgotpwd" method="post">
							<div class="form-row">
								<div class="col-md-12">
									<div class="position-relative form-group">
										<input name="empEmail" id="exampleEmail" placeholder="Email"
											type="email" class="form-control">
									</div>
									<div>
									<span style="color: red">${requestScope.sendMailMsg}</span>
									</div>
									<div>
									<span style="color: red">${requestScope.errorMsg}</span>
									</div>
								</div>
							</div>
							<div class="modal-footer clearfix">
								<div class="float-right">
									<button class="btn btn-primary btn-lg">送出</button>
								</div>
							</div>
					</form>
				</div>
			</div>
		</div>
		<div class="text-center text-white opacity-8 mt-3">Copyright ©
			KeroUI 2022</div>
	</div>
</body>
</html>