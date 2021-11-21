<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Appointment</title>
	
	<%@include file="includes/_linkshead.jsp"%>
	<link rel="stylesheet" href="assets/stylesheet/header.css">
	
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,400;0,500;0,600;0,700;0,800;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800&display=swap');	

.swal2-input {
	border: 1px !important;
}

.btn-primary, .btn-primary:hover, .btn-primary:active, .btn-primary:visited {
    	background-color: #1c87c9 !important;
    	font-family: 'Montserrat' !important;
    	margin-left: .5rem;
}

table td{
	font-family: 'Montserrat', sans-serif !important;
	
}


.container-search {
	width: 60rem;
	padding-top: 2rem;
	margin: 0 auto;
}

#appointment th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #1c87c9;	
	color: white;
}

body {
height: 100vh !important;
}

<%@include file="assets/stylesheet/main.css"%>
</style>
</head>
<body>
	<%
	String uid = (String) session.getAttribute("uid");
	String role = (String) session.getAttribute("role");
		if (uid == null) 
			response.sendRedirect("login");
		
		if (role.equals("patient")) 
			response.sendRedirect("patient-dashboard.jsp");
		
	%>
	<%@include file="includes/_header.jsp"%>
	<div class="container-search ">
		<form action="doctor-dashboard" class="py-3 d-flex" method="post">
		<select name="dropdown" id="list" class="form-select mr-2">
			<option value="All"
				<%if ((request.getAttribute("dropdown") != null) && request.getAttribute("dropdown").equals("All")) {%>
				selected <%}%>>All</option>
			<option value="Pending"
				<%if ((request.getAttribute("dropdown") != null) && request.getAttribute("dropdown").equals("Pending")) {%>
				selected <%}%>>Pending</option>
			<option value="Payment"
				<%if ((request.getAttribute("dropdown") != null) && request.getAttribute("dropdown").equals("Payment")) {%>
				selected <%}%>>Payment</option>
			<option value="Done"
				<%if ((request.getAttribute("dropdown") != null) && request.getAttribute("dropdown").equals("Done")) {%>
				selected <%}%>>Done</option>
			<option value="Declined"
				<%if ((request.getAttribute("dropdown") != null) && request.getAttribute("dropdown").equals("Declined")) {%>
				selected <%}%>>Declined</option>
		</select>
		<button type="submit" class="btn btn-primary" >Search</button>
		</form>

	<table id="appointment" class="groove border">
		<thead>
			<tr>
				<th>Patient</th>
				<th>Date</th>
				<th>Time</th>
				<th>Status</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="a" items="${meeting}">
				<c:if test="${dropdown == a.meetingStatus || dropdown == 'All'}">
					<tr>
						<td><c:out value="${a.meetingPatient}" /></td>
						<td><c:out value="${a.meetingDate}" /></td>
						<td><c:out value="${a.meetingTime}" /></td>
						<td style="align-items: center;"><c:out value="${a.meetingStatus}" /></td>
						
						<c:choose>
						
						<c:when test="${a.meetingStatus == 'Pending' || a.meetingStatus == 'Payment'}">
						<td>
							<button id="cancel${a.meetingNumber}" class="btn btn-primary">Cancel</button>
							<button id="approve${a.meetingNumber}" class="btn btn-primary">Approve</button>
									
						<c:if test="${a.meetingStatus == 'Payment'}">
						
					 	<button id="view${a.meetingNumber}" class="btn btn-primary">View</button>					 	
				       <!-- <form action="uploadImage" method="post" enctype="multipart/form-data">
				        
			             <input type="file" name="image" required="required"/><br/><br/>
			            <input type="hidden" name="imageId" value ="${a.meetingNumber}" required="required"/><br/><br/>
			            <input type="submit"/>
			        	</form>-->
						</c:if>
									
									
<script>
			var a = document.getElementById('view'+${a.meetingNumber});
			if(a){
							
		//FOR VIEWING									
        document.getElementById('view'+${a.meetingNumber}).addEventListener('click', function(){

        	Swal.fire({
        		  title: 'Proof of payment',
        		  imageUrl: '_getImage.jsp?id='+${a.meetingNumber},
        		  imageAlt: 'No Image Uploaded Yet',
            	  confirmButtonColor: '#1c87c9'
        		})
        	});
									}
</script>
									
<script>
//FOR APPROVE
									
		var type = "";
		
		if(${a.meetingStatus == 'Pending'})
			type = "Pending";
		else if(${a.meetingStatus == 'Payment'})
			type = "Payment";

									
        document.getElementById('approve'+${a.meetingNumber}).addEventListener('click', function(){
        	Swal.fire({
        		  icon: 'success',
        		  title: 'Appointment status approved',
        		  showConfirmButton: false,
        		  timer: 1500
        		})
        		
        	    var formData = new FormData();
    			
    			formData.append("approve", ${a.meetingNumber});
    			formData.append("approvetype", type);
    			
    			fetch ('http://localhost:8080/telehealth/approve',{
    				method: 'POST',
					body: formData
    			})
    			location.reload()
        	});
</script>
									
<script>
		//FOR DECLINE W/ REASON
        document.getElementById('cancel'+${a.meetingNumber}).addEventListener('click', function(){

        	Swal.fire({
        	  title: 'Are you sure?',
        	  text: "Reason for appointment cancellation",
        	  input: 'text',
        	  inputAttributes: {
        		    autocapitalize: 'off'
        		  },
        	  icon: 'warning',
        	  showCancelButton: true,
        	  confirmButtonColor: '#1c87c9',
        	  cancelButtonColor: '#d33',
        	  confirmButtonText: 'Cancel Meeting'
        	}).then((result) => {
        	  if (result.isConfirmed) {
        	    Swal.fire(
        	      'Cancelled!',
        	      'Your appointment has been cancelled.',
        	      'success'
        	    )
        	    
        	    var formData = new FormData();
    			
    			formData.append("message", result.value);
    			formData.append("drop", ${a.meetingNumber});
    			
    			fetch ('http://localhost:8080/telehealth/drop',{
    				method: 'POST',
					body: formData
    			})
    			location.reload()
        	  }

        	});
        })
</script>

							</td>
						</c:when>
						<c:when test="${a.meetingStatus == 'Declined'}">
						<td><c:out value="${a.meetingComment}" /></td>
						</c:when>
						
						
						<c:otherwise>
						<c:if test="${a.meetingLink != null && a.meetingStatus != 'Done' }">
						<td><c:out value="" /></td>
						</c:if>
						</c:otherwise>
						
						</c:choose>
						
						<c:if test="${a.meetingStatus == 'Done'}">
						<td>
						<input type="button" onclick="location.href='https://${a.meetingLink}';" class="btn btn-primary" value="Link"/>
						
						<button id="update${a.meetingNumber}" class="btn btn-primary">Edit</button>
						
<script>
        document.getElementById('update'+${a.meetingNumber}).addEventListener('click', function(){

        	Swal.fire({
        	  title: 'Enter Meeting Link',
        	  text: "(i.e. Google Meets, Microsoft Teams, Zoom, etc)",
        	  input: 'text',
        	  inputAttributes: {
        		    autocapitalize: 'off'
        		  },
        	  icon: 'question',
        	  showCancelButton: true,
        	  confirmButtonColor: '#1c87c9',
        	  cancelButtonColor: '#d33',
        	  confirmButtonText: 'Update'
        	}).then((result) => {
        	  if (result.isConfirmed) {
        	    Swal.fire(
        	      'Updated!',
        	      'Meeting link has been updated.',
        	      'success'
        	    )
        	    
        	    var formData = new FormData();
    			
    			formData.append("link", result.value);
    			formData.append("edit", ${a.meetingNumber});

    			fetch ('http://localhost:8080/telehealth/update-link',{
    				method: 'POST',
					body: formData
    			})
    			
    			location.reload()
    			
        	  }

        	});
        })
</script>
						</td>
						</c:if>

					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>
		
</body>
</html>