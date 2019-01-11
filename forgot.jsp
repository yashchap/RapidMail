<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
	Statement st;
	st = con.createStatement();
	String Email=request.getParameter("Email");
	String DOB=request.getParameter("DOB");
	String Password = request.getParameter("Password");
	ResultSet rs =  st.executeQuery("Select * from userauthentication where Email='"+Email+"' and DOB='"+DOB+"' ");
	if(rs.next())
	{
		st = con.createStatement();
		st.executeUpdate("UPDATE userauthentication SET Password = '"+Password+"' WHERE Email='"+Email+"';");
		response.sendRedirect("login.jsp?done=1");
	}
	else
	{
		response.sendRedirect("login.jsp?Error=wrong_dob");
	}
	//st.executeUpdate("UPDATE mails SET Unread = 0 WHERE id="+i+";");
	
%>