<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Appointment</title>

<!-- Custom Style -->
<link rel="stylesheet" href="assets/stylesheet/style.css"
	type="text/css">
<link rel="stylesheet" href="assets/stylesheet/header.css"
type="text/css">
<%@include file="includes/_linkshead.jsp"%>
<!-- Calendar CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>

<body>

	<%@include file="includes/_header.jsp"%>
	<div class="card_wrapper mt-4">
		<div class="container border pb-3 pt-5">
			<h4 class="text-center form_name">Request Appointment</h4>
			<h6 class="text-center form_text">Form</h6>
			<div class="mb-3"></div>
			
			<form class="form_appointment" action="book-appointment" id="form-appointment">
				<div class="input-group mb-3">
					<select name="doctor" class="form-select" id="inputGroupSelect01" required>
						<option selected disabled>Find Doctor</option>
						<option value="Dr. Angeline Sebastian">Dr. Angeline Sebastian</option>
					</select>
				</div>
				
				<div class="input-group mb-3">
					<input name="date" type="datetime-local" class="form-control"
						placeholder="Select Date.." required />
				</div>

				<div class="input-group mb-3">
					<input name="time" type="datetime-local" class="form-control"
						placeholder="Select Time Availability.." required />
				</div>

				<div class="input-group mb-3">
					<textarea name="condition" class="form-control"
						style="height: 100%;" rows="8" id="validationTextarea"
						placeholder="Please tell us your current condition." ></textarea>
				</div>
				<button class="btn form-control custom_btn-background-blue" type="submit">Book</button>
			</form>
		</div>
	</div>
	
	
	<%@include file="includes/_linksfooter.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script type="text/javascript" src="assets/js/modal.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script>
		dateConfig = {
			minDate: "2021-01",
			dateFormat: "F d, Y"
		}
		timeConfig = {
			noCalendar: true,
			enableTime: true,
			dateFormat: "h:i K"
		}
		flatpickr("input[name=date]", dateConfig);
		flatpickr("input[name=time]", timeConfig);
		
		$("#form-appointment").submit(function(e) {
			e.preventDefault();
			
			var form = $(this);
			var url = form.attr('action');
			
			$.ajax({
				type: 'POST',
				url: 'book-appointment',
				data: form.serialize(),
				success: function(result){
					if (result == 'success'){
						modal(result, "Appointment Booked Success", "Please wait the doctor confirmation thank you!")
						$('input[type="text"],texatrea, select', this).val('');
					}else {
						modal(result, "Appointment Booked Failed", "Please Try again");
						$('input[type="text"],texatrea, select', this).val('');
					}
				}
			})
		})
	</script>
</body>
</html>