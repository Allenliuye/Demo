<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>登出</title>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${contextRoot}/css/backend_system_style.css">
<script src="${contextRoot}/js/jquery-3.6.0.min.js"></script>
<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<meta HTTP-EQUIV="pragma" content="no-cache">
<meta HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<meta HTTP-EQUIV="expires" content="0">
<meta HTTP-EQUIV="keywords" content="keyword1,keyword2,keyword3">
<meta HTTP-EQUIV="description" content="This is my page">

</head>
<body>
<div align="center" style="height: 350px"></div>
<div align="center">
<a href="${contextRoot}/loginPage" ><button class="btn btn-danger btn-lg">已登出，再次登入請回首頁</button></a>
</div>
</body>
</html>