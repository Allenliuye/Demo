<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/3.3.3/adapter.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
<script type="text/javascript" src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
    <!-- 載入instascan.min.js -->
<meta charset="UTF-8">
<title>Instascan</title>
</head>

<body>
<div class="d-flex h-100 justify-content-center align-items-center">
		<div style="width: 666px; height: 650px;background-color:#FFFFFF">
					<div class="h5 modal-title text-center">
						<h4 class="mt-2">
							<div>
								<h2>員工打卡系統</h2>
							</div>
							<span>請掃描您的QR code:</span>
						</h4>
					</div >
					<div class="col-md-12">
							<div class="preview-container">
							    <video id="preview"></video>
							</div>
					</div>
		</div>
</div>
    <!-- 詢問是否允許開啟相機後，會顯示在這個元素裡 -->
    <!-- ---------- -->
    <!-- 以下程式面 -->
    <script type="text/javascript">
    let scanner = new Instascan.Scanner({
        video: document.getElementById('preview')
    });
    // 開啟一個新的掃描
    // 宣告變數scanner，在html<video>標籤id為preview的地方開啟相機預覽。
    // Notice:這邊注意一定要用<video>的標籤才能使用，詳情請看他的github API的部分解釋。

    scanner.addListener('scan', function(content) {
        console.log(content);
    	window.open(content);
    });
    //開始偵聽掃描事件，若有偵聽到印出內容。

    Instascan.Camera.getCameras().then(function(cameras) {
    //取得設備的相機數目
        if (cameras.length > 0) {
          ///若設備相機數目大於0 則先開啟第0個相機(程式的世界是從第零個開始的)
            scanner.start(cameras[0]);
        } else {
          //若設備沒有相機數量則顯示"No cameras found";
          //這裡自行判斷要寫什麼
            console.error('No cameras found.');
        }
    }).catch(function(e) {
        console.error(e);
    });
    

    </script>
</body>
</html>