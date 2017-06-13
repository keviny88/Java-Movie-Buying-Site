<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*,

 java.io.*,
 java.net.*,
 java.sql.*,
 java.text.*,
 java.util.*,
 javax.servlet.*,
 javax.servlet.http.*,
 java.io.InputStream,
 java.io.OutputStream,
 java.net.URL,
 
 javax.json.Json,
 javax.json.JsonObject,
 javax.json.JsonReader,

 javax.net.ssl.HttpsURLConnection"
%>

<%
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
	Statement select= connection.createStatement();
	String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";
	String SECRET_KEY= "6Lc0YCEUAAAAAGPKm1ISshTmaavn-cVwgHDw8_wh";

	String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

	boolean valid;
%>

<%!
String name = "";

public boolean validate_login( Connection c, String email, String pw)
	{
	try{
		boolean status = false;
		String ps = "SELECT * FROM customers where email=? AND password=?";
		PreparedStatement statement = c.prepareStatement(ps);

		statement.setString(1, email);
		statement.setString(2, pw);

		ResultSet rs = statement.executeQuery();
		rs.next();
		if( rs.getString(7).equals(pw) )
		{
    //  session.setAttribute("personName", "Bob");
      name = rs.getString(2);
      status = true;
		}
		rs.close();
		return status;
	}
	catch( SQLException e )
	{
		return false;
	}
}
%>

<%
	
	if (gRecaptchaResponse == null || gRecaptchaResponse.length() == 0) 
		{
            valid= false;
        }
 	else 
 		{
        try {
            URL verifyUrl = new URL(SITE_VERIFY_URL);

            
 
            // Open Connection to URL

            
            HttpsURLConnection conn = (HttpsURLConnection) verifyUrl.openConnection();
 
            // Add Request Header
            conn.setRequestMethod("POST");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");
            conn.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
 

            String postParams = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;
 
            // Send Request
            conn.setDoOutput(true);
            
            // Get the output stream of Connection
            // Write data in this stream, which means to send data to Server.
            OutputStream outStream = conn.getOutputStream();
            outStream.write(postParams.getBytes());
 
            outStream.flush();
            outStream.close();
 
            // Response code return from server.
            int responseCode = conn.getResponseCode();
            //System.out.println("responseCode=" + responseCode);
 
  
            // Get the InputStream from Connection to read data sent from the server.
            InputStream is = conn.getInputStream();
 
            JsonReader jsonReader = Json.createReader(is);
            JsonObject jsonObject = jsonReader.readObject();
            jsonReader.close();

 
            // ==> {"success": true}
            //System.out.println("Response: " + jsonObject);
 
            valid = jsonObject.getBoolean("success");

		
        } catch (Exception e) {
            e.printStackTrace();
            valid = false;
        }

	}

%> 

<%

	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	

	if(  (validate_login( connection, email, pw ) && (valid)) )
	{
		connection.close();
		session.setAttribute("email", email);
    	session.setAttribute("name", name);
    	if(session.getAttribute("checkoutLogin") != null){
    		response.sendRedirect("/TomcatForm/Checkout.jsp");
    	}else{
			response.sendRedirect("/TomcatForm/index.jsp");
    	}
	}else{
		connection.close();
		session.setAttribute("invalid", "true");
		response.sendRedirect("/TomcatForm/Login.jsp");
	}
%>
</HTML>
