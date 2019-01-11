<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%
   
		//1) download two jar file
		//	commons.io and commons.fileupload copy it to jre and lib
		//	use thier documentation for further help
		
		//check session and retriveing username
try{
		session=request.getSession(false);  
		String user=(String)session.getAttribute("Email");
		
		//making directory according to requirement
		
		String userDirString="D:/soft/apache-tomcat-9.0.0.M17/webapps/rapidmail/Attachments/"+user;
		File userDir=new File(userDirString);
		if(!userDir.exists()) 
		{
			userDir.mkdirs();
			
		}
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/rapidmail","root","1234");
		Statement st;
		st = con.createStatement();
		ResultSet rs = st.executeQuery("Select max(id) from mails");
		rs.next();
		int intId = rs.getInt("max(id)");
		//String id = "107";
		//int intId = Integer.parseInt(id);
		intId=intId+1;
		String id = Integer.toString(intId);
		String subuserDirString = "D:/soft/apache-tomcat-9.0.0.M17/webapps/rapidmail/Attachments/"+user+"/"+id;
		File subuserDir = new File(subuserDirString);
		subuserDir.mkdirs();
		

   File file ;
   int maxFileSize = 50000 * 1024;
   int maxMemSize = 50000 * 1024;
    String filePath = "D:/soft/apache-tomcat-9.0.0.M17/webapps/rapidmail/Attachments/"+user+"/"+id+"/";

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
		 
	
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();
		int c=0;
		String pathfile="";
         while ( i.hasNext () ) 
         {
			c++;
		   FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
			if(fileName.length()!=0){
			String filefolder = "D:/soft/apache-tomcat-9.0.0.M17/webapps/rapidmail/Attachments/"+user+"/"+id+"/file"+c;
			File filefold = new File(filefolder);
			if(!filefold.exists()) 
			{
			filefold.mkdirs();
				
			}
			
			filePath = filefolder + "/";
			}
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file
            if( fileName.lastIndexOf("\\") >= 0 ){
            file = new File( filePath + 
            fileName.substring( fileName.lastIndexOf("\\"))) ;
            }else{
            file = new File( filePath + 
            fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
			
            fi.write( file ) ;
			
			out.print("Attachments/"+user+"/"+id+"/file"+c+"/"+ fileName + ";");
            }
         }
		 
		
     con.close();  
	   }catch(Exception ex) {
         System.out.println(ex);
      }
   }else{
      out.println("No file uploaded"); 
      }
}
catch(Exception e)
{
	
}
%>