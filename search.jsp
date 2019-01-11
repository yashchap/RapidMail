<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>


<%
   
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
	Statement st;
	st = con.createStatement();
	session=request.getSession(false);  
	String user=(String)session.getAttribute("Email");
	ResultSet rs = st.executeQuery("Select * from mails where Ruser='"+user+"' and  Mail like '%"+request.getParameter("search")+"%' or Suser like '%"+request.getParameter("search")+"%' or Ruser like '%"+request.getParameter("search")+"%' or Subject like '%"+request.getParameter("search")+"%' or Time like '%"+request.getParameter("search")+"%' and Rdelete=0 ORDER BY id DESC" );
	//String text="{\"records\":[";
	out.println("<table class='table table-hover'>");
	while(rs.next()){
	st = con.createStatement();	
	ResultSet rsi =st.executeQuery("Select Name from userauthentication where Email='"+rs.getString("Suser")+"' or GEmail='"+rs.getString("Suser")+"'");
	rsi.next();
	//text +="{\"Name\":\""+rsi.getString("Name")+"\",\"id\":\""+rs.getString("id")+"\",\"Suser\":\""+rs.getString("Suser")+"\",\"Ruser\":\""+rs.getString("Ruser")+"\",\"Subject\":\""+rs.getString("Subject")+"\",\"Mail\":\""+rs.getString("Mail")+"\",\"Unread\":\""+rs.getString("Unread")+"\",\"Time\":\""+rs.getTime("Time")+"\",\"Attachments\":\""+rs.getString("Attachments")+"\"}";
	
	if(rs.getInt("Unread")==1)
					{	
						out.println("<tr id='imsg"+rs.getString("id")+"'>");
							out.println("<td >");out.println("<input form='deleteElement' type='checkbox' name='delete' value='i"+rs.getString("id")+"'>");out.println("</td>");
							out.println("<td id='iu"+rs.getString("id")+"' onclick= \"showMail('i"+rs.getString("id")+"','"+rs.getString("Attachments")+"','"+rs.getString("Suser")+"')\">");
								out.println("<b>");out.println(rsi.getString("Name"));out.println("</b>");
							out.println("</td>");
							out.println("<td  id='im"+rs.getString("id")+"' onclick= \"showMail('i"+rs.getString("id")+"','"+rs.getString("Attachments")+"','"+rs.getString("Suser")+"')\">");
								out.println("<div class='consise_body '><b id='is"+rs.getString("id")+"'>");out.println(rs.getString("Subject")+"-");out.println("</b>");out.println("<font id='ib"+rs.getString("id")+"' class='mail_body'>"+rs.getString("mail")+"</font>");
							out.println("</div></td>");
							if(rs.getString("Attachments").length()!=0)
							{out.println("<td id='ia"+rs.getString("id")+"'><span class='glyphicon glyphicon-paperclip '></span></td>");
							}
							else
							{
								out.println("<td id='ia"+rs.getString("id")+"'><span class='glyphicon glyphicon-paperclip clip'></span></td>");
							
							}out.println("<td  id='it"+rs.getString("id")+"'>"); 
								
								Date dates = rs.getDate("Time"); 
								
															
							out.println("<b>");out.println(dates);out.println("</b>");
							out.println("</td>");
						out.println("</tr>");
					}
					else
					{
						out.println("<tr id='imsg"+rs.getString("id")+"'>");
							out.println("<td>");out.println("<input form='deleteElement' type='checkbox' name='delete' value='i"+rs.getString("id")+"'>");out.println("</td>");
							
							out.println("<td id='iu"+rs.getString("id")+"'  onclick= \"showMail('i"+rs.getString("id")+"','"+rs.getString("Attachments")+"','"+rs.getString("Suser")+"')\">");
								out.println(rsi.getString("Name"));
							out.println("</td>");
							out.println("<td id='im"+rs.getString("id")+"' onclick= \"showMail('i"+rs.getString("id")+"','"+rs.getString("Attachments")+"','"+rs.getString("Suser")+"')\"><div class='consise_body'>");
								out.println("<font id='is"+rs.getString("id")+"'>"+rs.getString("Subject")+"</font>-");out.println("<font id='ib"+rs.getString("id")+"' class='mail_body'>"+rs.getString("mail")+"</font>");
							out.println("</div></td>");
							if(rs.getString("Attachments").length()!=0)
							{out.println("<td id='ia"+rs.getString("id")+"'><span class='glyphicon glyphicon-paperclip '></span></td>");
							}
							else
							{
								out.println("<td id='ia"+rs.getString("id")+"'><span class='glyphicon glyphicon-paperclip clip'></span></td>");
							
							}
							out.println("<td id='it"+rs.getString("id")+"'>");
								Date dates = rs.getDate("Time"); 
																
								out.println(dates);
								
							out.println("</td>");
						out.println("</tr>");
					}
				
	
	}
	out.println("</table>");
	rs.close();
	st.close();
	con.close();
 %> 

					
					
					
				