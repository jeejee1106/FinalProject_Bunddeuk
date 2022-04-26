<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
		
		<!-- Title  -->
		<title>Bunddeuk</title>
		<link rel="stylesheet" type="text/css" href="https://d2om2e6rfn032x.cloudfront.net/wpa/app.a3d4a534a9242368444b.css">
		<!-- Favicon  -->
		<link rel="icon" href="img/core-img/bunddeuk-black.png">
		<!-- Core Style CSS -->
		<link rel="stylesheet" href="/css/core-style.css">
		<link rel="stylesheet" href="/css/bootstrap.css">
		<link rel="stylesheet" href="/css/font-awesome.min.css">
		<link rel="stylesheet" href="/css/main.css">
	</head>
	<body>
		<!-- jQuery (Necessary for All JavaScript Plugins) -->
		<script src="/js/jquery/jquery-2.2.4.min.js"></script>
		
		<div>
			<div>
				<tiles:insertAttribute name="header"/>
			</div>
			<div>
				<tiles:insertAttribute name="main"/>
			</div>
			<div class="footer-css">
				<tiles:insertAttribute name="footer"/>
			</div>
		</div>
		<script src="/js/popper.min.js"></script>
		<script src="/js/bootstrap.min.js"></script>
		<script src="/js/plugins.js"></script>
		<script src="/js/classy-nav.min.js"></script>
		<script src="/js/active.js"></script>
	</body>
</html>