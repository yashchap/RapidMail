 <%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="Bean.*"%>
 <%
	
	String Ruser =request.getParameter("Email");
	String Subject = request.getParameter("Subject");
	String Mail = request.getParameter("Mail");
	String Rusers[] = Ruser.split(";");
	String Attachment = request.getParameter("Attachment");
	String from = request.getParameter("fromid");
	System.out.println(from);
	//String from = "gmail";
	if(from.equals("rapidmail")){
		try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
		Statement st;
		Statement st1; 
		String errors="";
		int c=0;
		for (int i =0;i<Rusers.length;i++)
			{
			st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery("Select Name from userauthentication where Email='"+Rusers[i]+"'");
			if(rs1.next())
			{
			st = con.createStatement();
			session=request.getSession(false);  
			String Suser=(String)session.getAttribute("Email");
			int Unread=1;
			st.executeUpdate("INSERT INTO mails(`Suser`, `Ruser`, `Subject`, `Mail`, `Unread`, `Attachments`) VALUES ('"+Suser+"','"+Rusers[i]+"','"+Subject+"','"+Mail+"',1,'"+Attachment+"')");
			
			}
			else
			{
				c=1;
				errors += "-"+Rusers[i]+"\n";
				continue;
			}
			}
		
		if(c==1)
		{
			out.println("Mail not Sent to \nUsers :\n"+errors+"doesn't exists, Please try again..");
		}
			//st.close();
			con.close();
		}
		catch(Exception e){System.out.println(e);}
	}
	else
	{
		System.out.println(from);
		try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
		Statement st;
		for (int i =0;i<Rusers.length;i++)
			{
			
			st = con.createStatement();
			Statement st2 = con.createStatement();
			session=request.getSession(false);  
			String Suser=(String)session.getAttribute("Email");
			int Unread=1;
			ResultSet rs = st2.executeQuery("Select * from userauthentication where Email='"+Suser+"'");
			rs.next();
			st.executeUpdate("INSERT INTO mails(`Suser`, `Ruser`, `Subject`, `Mail`, `Unread`, `Attachments`) VALUES ('"+rs.getString("GEmail")+"','"+Rusers[i]+"','"+Subject+"','"+Mail+"',1,'"+Attachment+"')");
			
			
			
			}
		
		
		con.close();	
			
		}
		catch(Exception e){System.out.println(e);}
		SendDetails send = new SendDetails();
		send.setRuser(Ruser);
		send.setSubject(Subject);
		send.setMail(Mail);
		send.setAttachment(Attachment);
		request.setAttribute("send",send);
		RequestDispatcher rd = request.getRequestDispatcher("sendMail");
		rd.forward(request,response);
		
	}

	
 %>
 