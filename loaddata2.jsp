
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

<% 	out.println("hi");
				//HttpSession session=request.getSession(false);  
			String user=(String)session.getAttribute("Email");
				Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/ymail","root","1234");
			Statement st  = con.createStatement();
			ResultSet rs_sent = st.executeQuery("Select * from mails where Suser='"+user+"' ORDER BY id DESC" );
				while(rs_sent.next())
				{
						out.println("<tr>");
							out.println("<td>");
								out.println(rs_sent.getString("Ruser"));
							out.println("</td>");
							out.println("<td>");
								out.println(rs_sent.getString("mail"));
							out.println("</td>");
							out.println("<td>");
								out.println(rs_sent.getString("Time"));
							out.println("</td>");
						out.println("</tr>");
					
					
				} 
				%>