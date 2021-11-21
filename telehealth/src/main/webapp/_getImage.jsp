<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.fujitsu.telehealth.dao.AppPatientImplementation"%>
<%
	AppPatientImplementation app = new AppPatientImplementation();
    String id = request.getParameter("id");
	try {
		byte byteArray[] = app.getImage(id);
		response.setContentType("image/gif");
		OutputStream os = response.getOutputStream();
		os.write(byteArray);
	    os.flush();
	    os.close();
	}catch (SQLException e) {
		System.out.println(e);
	}
%>
