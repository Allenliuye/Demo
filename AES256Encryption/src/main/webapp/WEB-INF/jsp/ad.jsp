<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
<a href="/GroupOne/st"><button type="button" class="btn btn-primary">查詢資料</button></a>
<a href="/GroupOne/ad"><button type="button" class="btn btn-primary">新增資料</button></a>

<form:form method="post" action="GroupOne/ad">
				
<table style="border:3px #cccccc solid;"  border='1' >
			

				
					<tr>
						<td>Key
						<td><input type="text" id="c_base64" name="c_base64" >
						<td>Value
						<td><input type="text" id="c_aes256" name="c_aes256">
					<tr>
					
				</table>
				<a href="/GroupOne/ad"><button type="button"
					style="font-size: 24px">Cancel</button></a> 
				<input type="submit" style="font-size: 24px" value="OK" id="submit" />
				</form:form>
</body>
</html>