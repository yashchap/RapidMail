<%
	Cookie cookie = null;
	Cookie[] cookies = null;
	cookies = request.getCookies();
	if( cookies != null )
	{
      
      for (int i = 0; i < cookies.length; i++){
         cookie = cookies[i];
         if((cookie.getName( )).compareTo("Email") == 0 )
		 {
			cookie.setValue(null);
            cookie.setMaxAge(0);
			//out.println("as");
            response.addCookie(cookie);
         }
        
      }
	}
	session.invalidate();
	response.sendRedirect("index");
%>