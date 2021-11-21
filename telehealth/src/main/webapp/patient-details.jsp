<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<title>OTS Patient Details</title>

<%@include file="includes/_linkshead.jsp"%>
<link rel="stylesheet" href="assets/stylesheet/header.css"></head>
<style>

.container-search {
	width: 60rem;
	padding-top: 2rem;
	margin: 0 auto;
}

</style>
</head>
<body>
	
	<%@include file="includes/_header.jsp" %>
	<!-- account -->
	<div class="container-search ">
		<div class="patient-details">
			<h4 class="text-left border-bottom">Account Information</h4>
			<table>
				<tr>
					<th>First name:</th>
					<td><c:out value="${detailsPatient.th_fname}" /><br></td>
					<th>Middle Name:</th>
					<td><c:out value="${detailsPatient.th_middle_name}" /><br></td>
					<th>Last Name:</th>
					<td><c:out value="${detailsPatient.th_lname}" /><br></td>
					<th>Age:</th>
					<td><c:out value="${detailsPatient.th_age}" /><br></td>
					<th>Gender:</th>
					<td><c:out value="${detailsPatient.th_gender}" /><br></td>
					<th>Address:</th>
					<td><c:out value="${detailsPatient.th_address}" /><br></td>
					<th>Email:</th>
					<td><c:out value="${detailsPatient.th_email}" /><br></td>
					<th>Contact Number:</th>
					<td><c:out value="${detailsPatient.th_contact}" /></td>
				</tr>
			</table>
		</div>
	</div>
	<br>
</body>
</html>