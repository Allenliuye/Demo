<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Register Page</title>
<!-- Style-CSS -->
<link rel="stylesheet" href="${contextRoot}/css/style.css" type="text/css" media="all" />  
<!-- font-awesome-icons -->
<link href="${contextRoot}/css/font-awesome.css" rel="stylesheet">
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700" rel="stylesheet">
<link href="//fonts.googleapis.com/css?family=Source+Sans+Pro:200,200i,300,300i,400,400i,600,600i,700,700i,900" rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="${contextRoot}/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${contextRoot}/css/adminlte.min.css">
<link rel="stylesheet" href="${contextRoot}/css/loginPage.css" />
<!-- jQuery -->
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${contextRoot}/js/adminlte.min.js"></script>
<script src="${contextRoot}/js/loginPage.js"></script>
 <script>
      addEventListener("load", function() {
          setTimeout(hideURLbar, 0);
      }, false);

      function hideURLbar() {
          window.scrollTo(0, 1);
      }
  </script>
  <style>
	.menu {
		font-size: 20px;
	}
		#big-head, #cart-img {
		width: 20px;
		height: 20px;
	}
</style>
</head>
<body data-entry_false="${entryFalse}">
<%-- ${entryFalse} --%>
   <!-- ???????????? -->
    <div class="main-banner inner" id="home">
         <!-- ?????? -->
        <header class="header">
            <div class="container-fluid px-lg-5">
                <!-- ?????? -->
                <nav class="py-4">
                    <div id="logo">
                        <h1> <a href="${contextRoot}/">A-Jen Sport</a></h1>
                    </div>
                    <label for="drop" class="toggle">Menu</label>
                    <input type="checkbox" id="drop" />
                    <ul class="menu mt-2">
                        <li><a href="${contextRoot}/">Home</a></li>
                       <li><a href="${contextRoot}/about">About</a></li>
                        <li><a href="${contextRoot}/blog">Blog</a></li>
						<li><a href="${contextRoot}/shop">Products</a>
                            <label for="drop-2" class="toggle">Products</label>
                            <input type="checkbox" id="drop-2" />
                            <ul>
                                <li><a href="${contextRoot}/shop">All</a></li>
                            	<c:forEach var="category" items="${categoriesList}" varStatus="status">
	                                <li>
	                                	<a href="${contextRoot}/shop?type${status.count}=${category.type}">
	                                		<c:out value="${category.type}"/>
	                                	</a>
	                                </li>
                            	</c:forEach>
                            </ul>
						</li>
						<li><a href="${contextRoot}/contact">Contact</a></li>
                        <li class="active">
						<c:choose>
								<c:when test="${sessionScope.accountId == null}">
									<a href="${contextRoot}/register"> Register/Login </a>
								</c:when>
								<c:otherwise>
									<a href="#">										
										<img id="cart-img" src="${contextRoot}/css/images/member.png"
										width="9"
										data-user_id="${sessionScope.accountId}"
										data-web_url="${pageContext.request.contextPath}">
										<span><c:out value="${sessionScope.ac}" /></span>
									</a>
									<a href="#"><span>|LogOut</span></a>
								</c:otherwise>
							</c:choose>
						</li>
                        <li>
                        	<c:choose>
                        		<c:when test="${sessionScope.accountId == null}">
	                        		<a href="${contextRoot}/register">
										<img id="cart-img" src="${contextRoot}/css/images/cart2.svg">
									</a>
                        		</c:when>
                        		<c:otherwise>
                        			<a href="<c:url value='/myCartList/accountId/${sessionScope.accountId}'/>">
										<img id="cart-img" src="${contextRoot}/css/images/cart2.svg" data-user_id="${sessionScope.accountId}">
									</a>
									<span id="show-number-in-cart"  style="color: yellow;">
										<c:if test="${sessionScope.numberInCart > 0}">
											<c:out value="${sessionScope.numberInCart}"/>
										</c:if>
									</span>
                        		</c:otherwise>
                        	</c:choose>
                        </li>
					</ul>
                </nav>
                <!-- //?????? -->
            </div>
        </header>
        <!-- //?????? -->

    </div>
    <!--//????????????-->
    <!--??????????????????-->
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a href="${contextRoot}/">Home</a>
        </li>
        <li class="breadcrumb-item active">????????????|??????</li>
    </ol>
	<!--?????????????????? -->
	<!-- ??????????????? -->
		<div class="container border padding-10" id="login-div">
		<nav>
			<div class="nav nav-tabs justify-content-center" id="nav-tab" role="tablist">
			    <a class="nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home"  role="tab" aria-controls="nav-home" aria-selected="true">???????????????</a>
			    <a class="nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">???????????????</a>
			    <a class="nav-link" id="nav-admin-tab" data-toggle="tab" href="#nav-admin" role="tab" aria-controls="nav-admin" aria-selected="false">????????????</a>
		  	</div>
		</nav>
		<div class="tab-content border border-top-0" id="nav-tabContent">
		    <div class="tab-pane fade show active padding-10" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
		    	<form:form id="log-in-form" modelAttribute="accountBean" name="login"  onsubmit="return validatelogin()" action="login" method="Post">
					<div class="form-group">
					    <label for="loginUserName">???????????????</label>
					    <form:input path="ac" type="text" class="form-control" name="accountL" id="accountL" autofocus="autofocus" placeholder="?????????????????????" required="required"
					    	value="${nameForLogin}"/>
				  	</div>
				  	<div class="form-group">
					    <label for="loginUserPassword">??????</label>
					    <form:input  path="pw" type="password" class="form-control" id="loginUserPassword" name="loginUserPassword" placeholder="?????????????????????"  required="required"
					    	value="${passwordForLogin}"/>
				  	</div>
				  	<span id="acsp" style="font-size: 10px;"></span>
				  	<br>
					<button type="submit" class="btn btn-primary">??????</button>
					<button type="button" id="auto-log-in-btn" class="btn btn-outline-danger">????????????</button><br><br>
					<button type="button" id="newest-member-btn" class="btn btn-warning">????????????</button>
				</form:form>
		    </div>
		  	<div class="tab-pane fade padding-10" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		  		<form:form id="register-form" modelAttribute="accountBean" name="Register" onsubmit="return validateRegister()" action="${contextRoot}/register" method="Post">
					<div class="form-group">
					    <label>???????????????</label>
					    <form:input type="text" class="form-control" path="ac" name="accountR" id="accountR" autocomplete="off" placeholder="?????????????????????" onblur="checkAC()"/>
						<span id="acr" style="font-size: 10px;"></span>
					</div>
				  	<div class="form-group">
					    <label>???????????????</label>
					    <form:input type="password" class="form-control" path="pw"  name="pwd" id="pwd" placeholder="???????????????" onblur="checkPW()"/>
				  		<span id="pwsp" style="font-size: 10px;"></span>
				  	</div>
				  	<div class="form-group">
					    <label>???????????????</label>
					    <form:input type="password" class="form-control" path=""  name="pwdcheck" id="pwdcheck" placeholder="???????????????" onblur="checkPWR()"/>
				  		<span id="pwck" style="font-size: 10px;"></span>
				  	</div>
				  	<div class="form-group">
					    <label>????????????</label>
					    <form:input type="text" class="form-control" path="aname"  name="aname" id="aname" placeholder="?????????????????????" onblur="checkNM()"/>
				  		<span id="nmsp" style="font-size: 10px;"></span>
				  	</div>
				  	<div class="form-group">
					    <label>????????????</label>
					    <form:input type="text" class="form-control" path="mail"  name="mail" id="mail" placeholder="?????????????????????" onblur="checkMail()"/>
				  		<span id="mailsp" style="font-size: 10px;"></span>
				  	</div>
				  	<span id="rsp" style="font-size: 10px;"></span>
				  	<br>
  					<button type="submit" class="btn btn-primary">??????</button>
  					<button type="button" id="auto-register-btn" class="btn btn-outline-warning">????????????</button>
				</form:form>
		  	</div>
		  	<div class="tab-pane fade padding-10" id="nav-admin" role="tabpanel" aria-labelledby="nav-admin-tab">
		    	<form:form id="admin-log-in-form" modelAttribute="accountBean" name="admin"  onsubmit="return validateAdmin()" action="admin" method="Post">
					<div class="form-group">
					    <label for="loginUserName">???????????????</label>
					    <form:input path="ac" type="text" class="form-control" name="accountA" id="accountA" autofocus="autofocus" placeholder="?????????????????????"/>
				  	</div>
				  	<div class="form-group">
					    <label for="loginUserPassword_2">??????</label>
					    <form:input  path="pw" type="password" class="form-control" name="loginUserPassword_2" id="loginUserPassword_2" placeholder="?????????????????????"/>
				  	</div>
				  	<span id="adsp" style="font-size: 10px;"></span>
				  	<br>
					<button type="submit" class="btn btn-primary">??????</button>
					<br><br>
					<button type="button" id="" class="btn btn-outline-danger auto-login-btns-admin" data-num="0">????????????</button>
					<button type="button" id="" class="btn btn-outline-danger auto-login-btns-admin" data-num="1">??????</button>
					<button type="button" id="" class="btn btn-outline-danger auto-login-btns-admin" data-num="2">??????</button>
					<button type="button" id="" class="btn btn-outline-danger auto-login-btns-admin" data-num="3">??????</button>
				</form:form>
		    </div>
		</div>
	</div>
	<br>
	<!-- ??????????????? -->
    <!-- ?????? -->
    <footer>
        <div class="container">
            <div class="row footer-top">
                <div class="col-lg-4 footer-grid_section_w3layouts">
                    <p class="col-md-10">?? 2022 A-Jen Sport. All rights reserved | Design by
                            <a href="https://www.ispan.com.tw/longterm/JJEEITT">???????????? EEIT138.</a>
                        </p>                   
                </div>
            </div>
        </div>
    </footer>
    <!-- //?????? -->
<script>
function validatelogin() {
	var account = document.getElementById("accountL");
	let acspstr = document.getElementById("acsp");
    let x = account.value;
	  if (/^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{8,}$/.test(x)&& /^[^\s]*$/.test(x)) {	    
	  } else {
		acspstr.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">???????????????`;	  	    	
		return false;
		 }
	}
	
function validateAdmin() {
	var account = document.getElementById("accountA");
	let acspstr = document.getElementById("adsp");
    let x = account.value;
	  if (/^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{8,}$/.test(x)&& /^[^\s]*$/.test(x)) {	    
	  } else {
		acspstr.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">???????????????`;	  	    	
		return false;
		 }
	}

function checkAC() {
    var account = document.getElementById("accountR");
    let accountstr = account.value;
    let acspstr = document.getElementById("acr");
    if (/^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{8,}$/.test(accountstr)&& /^[^\s]*$/.test(accountstr)) {
        acspstr.innerHTML = ``;
    } else {
        acspstr.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">??????????????????????????????????????????????????????`;
    }
}

function checkPW() {
    var pwd = document.getElementById("pwd");
    let pwdstr = pwd.value;
    let pwspstr = document.getElementById("pwsp");
    if (/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/.test(pwdstr)) {
    	pwspstr.innerHTML = ``;
    } else {
        pwspstr.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">?????????????????????????????????????????????????????????????????????`;
    }
}

function checkPWR() {
	var pwd = document.getElementById("pwd");
    var pwdcheck = document.getElementById("pwdcheck");
    let pwdstr = pwd.value;
    let pwdckstr = pwdcheck.value;
    let pwcspstr = document.getElementById("pwck");
    if (pwdstr === pwdckstr) {
    	pwcspstr.innerHTML = ``;
    } else {
        pwcspstr.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">???????????????`;
    }
}

function checkNM() {
    var name = document.getElementById("aname");
    let nmstr = name.value;
    let nmspstr = document.getElementById("nmsp");
    if (/^[\u4e00-\u9fa5]{2,}$/.test(nmstr)) {
    	nmspstr.innerHTML = ``;
    } else {
        nmspstr.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">????????????????????????????????????`;
    }
}

function checkMail() {
    var mail = document.getElementById("mail");
    let mailstr = mail.value;
    let mailpstr = document.getElementById("mailsp");
    var pattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    if (pattern.test(mailstr)) {
    	mailpstr.innerHTML = ``;
    } else {
    	mailpstr.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">?????????????????????`;
    }
}

function validateRegister() {
	var account = document.getElementById("accountR");
    let accountstr = account.value;
    var pwd = document.getElementById("pwd");
    var pwdcheck = document.getElementById("pwdcheck");
    let pwdstr = pwd.value;
    let pwdckstr = pwdcheck.value;
    var name = document.getElementById("aname");
    let nmstr = name.value;
    var mail = document.getElementById("mail");
    let mailstr = mail.value;
    var patternA1 = /^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{8,}$/;
    var patternA2 = /^[^\s]*$/;
    var patternP = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
    var patternN = /^[\u4e00-\u9fa5]{2,}$/;
    var patternM = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    let rsp = document.getElementById("rsp");
	  if (patternA1.test(accountstr) &&
		  patternA2.test(accountstr) &&
		  patternP.test(pwdstr) &&
		  patternN.test(nmstr) &&
		  patternM.test(mailstr) &&
		  pwdstr === pwdckstr) {	    
	  } else {
		rsp.innerHTML = `<img style="width :10px" src="https://memeprod.sgp1.digitaloceanspaces.com/user-resource-thumbnail/aaa5ea30708aef68af78543f707fe55c.png">?????????????????????????????????`;	  	    	
		return false;
		 }
	}
</script>

</body>
</html>