<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Kakao ���� �����ϱ�</title>
</head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<body>
	<h2>MAP</h2>
	<p>
		<em>������ Ŭ�����ּ���!</em>
	</p>
	<p id="result"></p>
	<p id="click"></p>
	<div id="map" style="width: 500px; height: 400px;"></div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=561a845178111e911d22f0a791f9d99a"></script>
	<script>
		var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
		mapOption = {
			center : new kakao.maps.LatLng(37.5662952, 126.97794509999994), // ������ �߽���ǥ
			level : 3
		// ������ Ȯ�� ����
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�
		// �Ϲ� ������ ��ī�̺�� ���� Ÿ���� ��ȯ�� �� �ִ� ����Ÿ�� ��Ʈ���� �����մϴ�
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// ������ ��Ʈ���� �߰��ؾ� �������� ǥ�õ˴ϴ�
		// kakao.maps.ControlPosition�� ��Ʈ���� ǥ�õ� ��ġ�� �����ϴµ� TOPRIGHT�� ������ ���� �ǹ��մϴ�
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// ���� Ȯ�� ��Ҹ� ������ �� �ִ�  �� ��Ʈ���� �����մϴ�
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		// ��Ŀ�� ǥ�õ� ��ġ�Դϴ� 
		var markerPosition  = new kakao.maps.LatLng(37.5662952, 126.97794509999994); 

		// ��Ŀ�� �����մϴ�
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// ��Ŀ�� ���� ���� ǥ�õǵ��� �����մϴ�
		marker.setMap(map);
		

		// ���콺 �巡�׷� ���� �̵��� �Ϸ�Ǿ��� �� ������ �Ķ���ͷ� �Ѿ�� �Լ��� ȣ���ϵ��� �̺�Ʈ�� ����մϴ�
		kakao.maps.event.addListener(map, 'dragend', function() {        
		    
		    // ���� �߽���ǥ�� ���ɴϴ� 
		    var latlng = {
				    _x: map.getCenter().getLat(),
				    _y: map.getCenter().getLng()
				};
			
		    var message = '����� ���� �߽���ǥ�� ' + latlng._x + ' �̰�, ';
		    message += '�浵�� ' + latlng._y + ' �Դϴ�';
		    
		    var resultDiv = document.getElementById('result');  
		    resultDiv.innerHTML = message;
		    
		    $.ajax({
		        url : "center",
		        type : "GET",
		        dataType: "json",
		        data: latlng,
		        success : function(data){
		        	 console.log(latlng._x, latlng._y);
			        	}
		        });
		    
		});
		// ������ Ŭ�� �̺�Ʈ�� ����մϴ�
		// ������ Ŭ���ϸ� ������ �Ķ���ͷ� �Ѿ�� �Լ��� ȣ���մϴ�
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			// Ŭ���� ����, �浵 ������ �����ɴϴ� 
			var latlng = {
				    x: mouseEvent.latLng.getLat(),
				    y: mouseEvent.latLng.getLng()
				};
			
			var message = 'Ŭ���� ��ġ�� ������ ' + latlng.x + ' �̰�, ';
			message += '�浵�� ' + latlng.y + ' �Դϴ�';

			var resultDiv = document.getElementById('click');
			resultDiv.innerHTML = message;

			   $.ajax({
			        url : "radius",
			        type : "GET",
			        //dataType: "json",
			        data: latlng,
			        success : function(data){
				        for(var i=0; i<data.length; i++)
					        console.log(data[i]);
				        	}
			        });
		});
		  $(document).ready(function() {
			   $.ajax({
			        url : "all",
			        type : "POST",
			        dataType: "json",
			        success : function(data){
			        	// ��Ŀ �̹����� �̹��� �ּ��Դϴ�
			        	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			        	for (var i = 0; i < data.length; i++) {
			        		  var coords =new kakao.maps.LatLng(data[i].location[1],data[i].location[0]);
			        		 
			        		  console.log(data[i].location[1],data[i].location[0])
			        		  // ��Ŀ �̹����� �̹��� ũ�� �Դϴ�
			        		    var imageSize = new kakao.maps.Size(24, 35); 
			        		    
			        		    // ��Ŀ �̹����� �����մϴ�    
			        		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			        		    
			        		    // ��Ŀ�� �����մϴ�
			        		    var marker = new kakao.maps.Marker({
			        		        map: map, // ��Ŀ�� ǥ���� ����
			        		        position: coords, // ��Ŀ�� ǥ���� ��ġ
			        		        image : markerImage // ��Ŀ �̹��� 
			        		    });
				        	}
			        	}
			        });
		  });  
		  
	</script>
</body>
</html>