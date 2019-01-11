<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.Date"%>


<%
	
	Date cd = new Date();
	SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
	String cdstr = dateformat.format(cd);
	out.println(cdstr);

%>