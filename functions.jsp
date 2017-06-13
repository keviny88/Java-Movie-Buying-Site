<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<html>
<%!


public HashMap<String,String> getMovieAttributes(String id)
{
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection connection =
  DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  //String move_id= request.getParameter("movieID");
  Statement select= connection.createStatement();


  HashMap<String,String> result= new HashMap<String,String>();

  result.put("Title", "Titanic");
  return result;


}



</html>