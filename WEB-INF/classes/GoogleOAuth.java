import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Properties;    
import javax.mail.*;    
import javax.mail.internet.*;  
import javax.activation.*;  
import java.sql.*;
public class GoogleOAuth extends HttpServlet{  
    public  void service(HttpServletRequest req, HttpServletResponse res)
	{  
			 
			 String from = req.getParameter("uname");
			 String password = req.getParameter("psw");
			 Properties props = new Properties();    
			 props.put("mail.smtp.host", "smtp.gmail.com");    
			 props.put("mail.smtp.socketFactory.port", "465");      
			 props.put("mail.smtp.socketFactory.class",    
                    "javax.net.ssl.SSLSocketFactory");  
			 props.put("mail.smtp.auth", "true");    
			 props.put("mail.smtp.port", "465");  
			 String to = req.getParameter("uname");
			 String sub = "Welcome to RapidMail";
			 try
			{
				HttpSession session1=req.getSession(false);  
				String user=(String)session1.getAttribute("Email");
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
				Statement st  = con.createStatement();
				ResultSet name =  st.executeQuery("Select Name from userauthentication where Email = '"+user+"'");
				name.next();
				String msg = "<html><body><h1>Welcome to Rapidmail "+name.getString("Name")+"!<br/></h1>Your Authentication has been verified.<br/>Now you can Access your gmail mails from your  Rapidmail account.<br/><b>Rapidmail EmailID:</b>"+user+"<br/><b>gmail EmailID:</b>"+to+"</body></html>";
				//String msg="<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><link rel=\"stylesheet\" type=\"text/css\" href=\"CSS/bootstrap.css\"/></head><body class=\"jumbotron col-sm-9\" style=\"background-color:black\"><a href=\"http://localhost:8080/rapidmail/index\"><div class=\"jumbotron container col-sm-6 \" style=\"color:black;background-color:rgb(0, 188, 212);\"><center><img src=\"../../Images/logo.png\" class=\"img-rounded\"></center><center><h3 style=\"color:#139612\">Welcome to Rapidmail"+ name.getString("Name")+"!</h3></center><p style=\"margin-left: 34px;font-size:15px\">Your Authentication has been verified.Now you can Access your gmail mails from your Rapidmail account.<br/><br/>Rapidmail EmailID: "+user+"<br/>Gmail: "+to+"</p></div></a></body></html>";
				Session session = Session.getInstance(props,    
				new javax.mail.Authenticator() 
				{    
					protected PasswordAuthentication getPasswordAuthentication() 
					{    
						return new PasswordAuthentication(from,password);  
					}    
				});
				
				MimeMessage message = new MimeMessage(session); 
				 				
				message.setFrom(new InternetAddress(from,"Rapid Mail"));
				message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));    
				message.setSubject(sub);    
				message.setContent(msg,"text/html");    
				Transport.send(message);
				System.out.println("correct Username");
				st = con.createStatement();
				st.executeUpdate("UPDATE userauthentication SET GEmail = '"+from+"' , GPassword = '"+password+"' WHERE Email = '"+user+"';");
				res.sendRedirect("index?Error=none");
				con.close();
	
			}
			
			catch(AuthenticationFailedException e)
			{
				System.out.println("check username and password");
				try{
				res.sendRedirect("index?Error=OAuthFailed");
				}catch(Exception e1)
				{
					System.out.println(e);
				}
			}
			catch(MessagingException e)
			{
				try{
				res.sendRedirect("index?Error=problem");}
				catch(Exception e1)
				{
					System.out.println(e);
				}
			}
			catch(Exception e)
			{
				System.out.println(e);
				try{
				res.sendRedirect("index?Error=problem");}
				catch(Exception e1)
				{
					System.out.println(e);
				}
			}
	}
}