<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>
<%@include file="includes/_linkshead.jsp"%>
<link rel="stylesheet" href="assets/stylesheet/header.css">

<style>
@import
	url('https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,400;0,500;0,600;0,700;0,800;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800&display=swap');	

.thead-custom-background {
	background: #28d;
	color: #fff;
}

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

<%@include file="assets/stylesheet/main.css"%>
</style>

</head>

<body>

	<%
		String uid = (String) session.getAttribute("uid");
		
		if (uid == null) {
			response.sendRedirect("login");
		}
			
		String role = (String) session.getAttribute("role");
		
			 if (role.equals("doctor")) 
				response.sendRedirect("doctor-dashboard.jsp");
	%>
	<%@include file="includes/_header.jsp"%>
	<div class="container-search ">
		<form action="patient-dashboard" class="py-3 d-flex" method="post">
			<select name="dropdown" id="list" class="form-select mr-2">
				<option value="All" selected
					<%if ((request.getAttribute("dropdown") != null) && request.getAttribute("dropdown").equals("Pending")) {%>
					 <%}%>>All</option>
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
				<th>Doctor</th>
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
						<td><c:out value="${a.meetingDoctor}" /></td>
						<td><c:out value="${a.meetingDate}" /></td>
						<td><c:out value="${a.meetingTime}" /></td>
						<td style="align-items: center;"><c:out value="${a.meetingStatus}" /></td>
						<c:choose>
							<c:when test="${a.meetingStatus == 'Pending' || a.meetingStatus == 'Payment'}">
								<td class="d-flex flex-end">
									<button id="cancel${a.meetingNumber}" class="btn btn-primary">Cancel</button>
							<c:if test="${a.meetingStatus == 'Payment'}">
								<input type="button" onclick="location.href='payment.jsp';" class="btn btn-primary" value="Pay"/>
							 	<button id="view${a.meetingNumber}" class="btn btn-primary">View</button>					 	
					            <button id="upload${a.meetingNumber}" class="btn btn-primary">Upload</button>
							</c:if>
									<script>
        	
									var a = document.getElementById('upload'+${a.meetingNumber});
									if(a){
									//FOR UPLOADING									
        document.getElementById('upload'+${a.meetingNumber}).addEventListener('click', function(){
        	(async () => {

        		const { value: file } = await Swal.fire({
        		  title: 'Select image',
        		  input: 'file',
        		  inputAttributes: {
        		    'accept': 'image/*',
        		    'aria-label': 'Upload your profile picture'
        		  }
        		})

        		if (file) {
        		  const reader = new FileReader()
        		  reader.onload = (e) => {
        		    Swal.fire({
        		      title: 'Your uploaded picture',
        		      imageUrl: e.target.result,
        		      imageAlt: 'The uploaded picture'
        		    })
        		  }
        		  reader.readAsDataURL(file)
        		}
        	    var formData = new FormData();
    			
    			formData.append("imageId", ${a.meetingNumber});
    			formData.append("image", file);
    			fetch ('http://localhost:8080/telehealth/uploadImage',{
    				method: 'POST',
					body: formData
    			})
    			location.reload()
        		})()
        		

        	});
			}
</script>
									
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
						</td>
						</c:if>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="d-flex">
		<button onclick="location.href='appointment'"  class="btn btn-primary mt-4 "><i class="fa fa-calendar-plus"></i> Request Appointment</button>
	</div>
</div>


	<%@include file="includes/_linksfooter.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script type="text/javascript" src="assets/js/modal.js"></script>
</html>