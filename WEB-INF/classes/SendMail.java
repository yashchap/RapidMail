import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Properties;    
import javax.mail.*;    
import javax.mail.internet.*;  
import javax.activation.*;  
import Bean.*;
import java.sql.*;
public class SendMail extends HttpServlet
{  
		public  void service(HttpServletRequest req, HttpServletResponse res)
	{  
  
			
			try{
				
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
			Statement st;
			HttpSession session1=req.getSession(false);  
			String user=(String)session1.getAttribute("Email");
			st= con.createStatement();
			ResultSet rs = st.executeQuery("Select * from userauthentication where Email='"+user+"'");
			rs.next();
			SendDetails send = (SendDetails)req.getAttribute("send");
			String from=rs.getString("GEmail");
			String password=rs.getString("GPassword");
			String to=send.getRuser();
			String sub=send.getSubject();
			String msg=send.getMail();
			String Name=rs.getString("Name");
			String Attachment=send.getAttachment();
			String filenames[] = Attachment.split(";");
			to = to.replaceAll(";",",");
			
          //Get properties object    
			Properties props = new Properties();    
			props.put("mail.smtp.host", "smtp.gmail.com");    
			props.put("mail.smtp.socketFactory.port", "465");      
			props.put("mail.smtp.socketFactory.class",    
                    "javax.net.ssl.SSLSocketFactory");  
			//props.put("mail.smtp.user", "yashpatel");					
			props.put("mail.smtp.auth", "true");    
			props.put("mail.smtp.port", "465");    
			PrintWriter out;
          //get Session   
         try{
			 
				InternetAddress froms = new InternetAddress(from,Name); 
				Session session = Session.getInstance(props,    
				new javax.mail.Authenticator() 
				{    
					protected PasswordAuthentication getPasswordAuthentication() 
					{   
				
						return new PasswordAuthentication(from,password);  
					}    
				}); 
     
  //2) compose message     
  
  
    MimeMessage message = new MimeMessage(session);  
    message.setFrom(froms);  
    message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(to));   
    message.setSubject(sub);  
      
    //3) create MimeBodyPart object and set your message text     
    BodyPart messageBodyPart1 = new MimeBodyPart();  
    messageBodyPart1.setContent(msg,"text/html");
	Multipart multipart = new MimeMultipart();  	
    multipart.addBodyPart(messageBodyPart1); 
    //4) create new MimeBodyPart object and set DataHandler object to this object      
	if(Attachment.length()!=0){
	for(int i=0;i<filenames.length;i++)
	{	
		
	MimeBodyPart messageBodyPart = new MimeBodyPart();  
	DataSource source = new FileDataSource("D:/soft/apache-tomcat-9.0.0.M17/webapps/rapidmail/"+filenames[i]);  
    messageBodyPart.setDataHandler(new DataHandler(source));  
    messageBodyPart.setFileName(new File(filenames[i]).getName());  
    multipart.addBodyPart(messageBodyPart); 
	}
	}
    //6) set the multiplart object to the message object  
    message.setContent(multipart ,"text/html");  
     
    //7) send message  
	
    Transport.send(message); 
	System.out.println("message sent....");  
   }catch (Exception ex) {System.out.println(ex);} 
			}catch(Exception e)
			{
				System.out.println(e);
			}			
 }  
}