package Bean;
import java.sql.*;
public class SendDetails
{
	public SendDetails(){}
	private String Ruser;
	private String Mail;
	private String Attachment;
	private String Subject;
	public void setRuser(String Ruser)
	{
		this.Ruser = Ruser;
	}
	public String getRuser()
	{
		return Ruser;
	}
	public void setSubject(String Subject)
	{
		this.Subject = Subject;
	}
	public String getSubject()
	{
		return Subject;
	}
	public void setMail(String Mail)
	{
		this.Mail = Mail;
	}
	public String getMail()
	{
		return Mail;
	}
	public void setAttachment(String Attachment)
	{
		this.Attachment = Attachment;
	}
	public String getAttachment()
	{
		return Attachment;
	}
	
	
	
}