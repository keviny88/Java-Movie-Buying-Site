<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.*" %>

<html>
<head>
  <jsp:include page="header.jsp" />
  <title>Single Movie Page</title>

  <style>
    #container {
      text-align: center;
  }

  .actor-name {
    font-size: 24px;
    font-weight: 700;
  }
  </style>



</head>


<%
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection connection =
  DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  String actor_id= request.getParameter("Id");
  Statement select= connection.createStatement();


%>


<body>

  <center>
  <div class='container'>
    <div class="content-body" style="padding: 7%;">
  <%

    String query= "SELECT * FROM stars WHERE id= " + actor_id;
    ResultSet result = select.executeQuery(query);

    result.next();
    String ID = result.getString(1);
    String first_name= result.getString(2);
    String last_name= result.getString(3);
    String dob= result.getString(4);
    String pic_URL= result.getString(5);
    Map<String, String> movies= new HashMap<String, String>();


    String stars_query = "SELECT m.id, m.title FROM movies m, stars s, stars_in_movies sim WHERE sim.star_id = s.id AND sim.movie_id = m.id AND s.id=" + actor_id + ";";

    result= select.executeQuery(stars_query);

    while (result.next())
    {
      String movieTitle= result.getString(2);
      String movieId = result.getString(1);
      movies.put(movieId, movieTitle);
    }

    out.print("<div class='float'>");
    out.print("<div><img src='" + pic_URL +"' style='padding-bottom: 20px; width: 300px; height: 370px;'></div>");
    out.print("<div class='actor-name'>"); out.print(first_name); out.print(" "); out.print(last_name); out.print("</div>");
    out.print("<div>"); out.println("<strong>Date of Birth</strong>: "+ dob); out.print("</div>");
    out.print("<div>"); out.println("<strong>Actor ID</strong>: "+ ID); out.print("</div>");
    out.print("<div> <b>Movies:</b></div>");
    //Formatting all of the actors into a single string
    out.print("<div>");
    Iterator it = movies.entrySet().iterator();
    while (it.hasNext()) {
      Map.Entry pair = (Map.Entry)it.next();
      %>
      <div>
      <a href=<%= "\"SingleMovie.jsp?Id=" + pair.getKey() + "\"" %> >
      </div>
      <%
      out.print(pair.getValue()+ "</a> ");

    }


  %>
    </div>
  </div>
</div>
</center>

</body>



<%
  connection.close();

%>



<html>
