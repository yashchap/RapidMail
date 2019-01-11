import javax.servlet.*;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.Properties;
import java.util.Date;
import java.util.*;
import java.text.*;
import javax.mail.Address;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.MimeBodyPart;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Properties;    
import javax.mail.*;    
import javax.mail.internet.*;  
import javax.mail.BodyPart;  
import javax.activation.*;
import javax.mail.search.SearchTerm;
import javax.mail.search.AndTerm;
import javax.mail.search.ComparisonTerm;
import javax.mail.search.ReceivedDateTerm;
import java.io.InputStream;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.search.*;

public class Gfetch extends HttpServlet{ 

 
	private Date getYesterdayDateString() throws Exception 
	{
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String ydate = dateFormat.format(yesterday());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return sdf.parse(ydate);
	}
	private Date yesterday()
	{
		final Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -5);
		return cal.getTime();
	}
	
   public  void service(HttpServletRequest req, HttpServletResponse res){  
	  
		Properties props = new Properties();
		props.setProperty("mail.store.protocol", "imaps");

		try {
			PrintWriter out = res.getWriter();
			Session session = Session.getInstance(props, null);
			Store store = session.getStore();
			store.connect("imap.gmail.com", "yp101296@gmail.com", "10121996yash");
			Folder[] folderList = store.getFolder("[Gmail]").list();
			/*for (int i = 0; i < folderList.length; i++) {
				out.println(folderList[i].getFullName());
			}*/
			Folder inbox = store.getFolder("INBOX");
			inbox.open(Folder.READ_WRITE);
			System.out.println(getYesterdayDateString());
			System.out.println(new Date());
			SearchTerm st = new ReceivedDateTerm(ComparisonTerm.GT,getYesterdayDateString());
			
			//FlagTerm unseenFlagTerm = new FlagTerm(seen, false);
			//= inbox.search(unseenFlagTerm);
			Message[] msg = inbox.search(st);
		//Message msg=inbox.getMessage(inbox.getMessageCount());
			
			for(int j=0;j<msg.length;j++){
				Address[] fromAddress = msg[j].getFrom();
			    String from = fromAddress[0].toString();
                String subject = msg[j].getSubject();
                String sentDate = msg[j].getSentDate().toString();
				String contentType = msg[j].getContentType();
                String msgContent = "";
				System.out.println(sentDate.substring(11,19));
				//if(!(sentDate.substring(11,19)).equals("15:47:57"))
				//{
				//	continue;
				//}
                // store attachment file name, separated by comma
                String attachFiles = "";
				//msg[j].setFlag(Flags.Flag.DELETED, true);
                if (contentType.contains("multipart")) {
                    // content may contain attachments
                    Multipart multiPart = (Multipart) msg[j].getContent();
                    int numberOfParts = multiPart.getCount();
                    for (int partCount = 0; partCount < numberOfParts; partCount++) {
                        MimeBodyPart part = (MimeBodyPart) multiPart.getBodyPart(partCount);
                        if (Part.ATTACHMENT.equalsIgnoreCase(part.getDisposition())) {
                            // this part is attachment
                            String fileName = part.getFileName();
                            attachFiles += fileName + ", ";
							
                            //part.saveFile("E:/Attachment"+ File.separator + fileName);
                        } else {
                            // this part may be the msg content
                            msgContent = part.getContent().toString();
                        }
                    }
 
                    if (attachFiles.length() > 1) {
                        attachFiles = attachFiles.substring(0, attachFiles.length() - 2);
                    }
                } else if (contentType.contains("text/plain")
                        || contentType.contains("text/html")) {
                    Object content = msg[j].getContent();
                    if (content != null) {
                        msgContent = content.toString();
                    }
                }
 
                //print out details of each msg
                out.println("\t From: " + from);
                out.println("\t Subject: " + subject);
                out.println("\t Sent Date: " + sentDate);
                out.println("\t msg: " + msgContent);
                out.println("\t Attachments: " + attachFiles);
		}
			//System.out.println(count);
    } catch (Exception mex) {
        mex.printStackTrace();
    }   
             
    }  
}  
 
 