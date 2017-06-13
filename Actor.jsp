<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
  <jsp:include page="header.jsp" />
  <title>Single Actor Page</title>


</head>


<%
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection connection =
  DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb", "swag122b", "z0ttieth0ttie");
  String actor_id= (String)session.getAttribute("actorID");
  //String movie_id= "658001";
  Statement select= connection.createStatement();

%>


<body>


  <div class="content-body" style="padding: 7%;">
  <%

    String query= "SELECT * FROM actors WHERE id= " + actor_id;
    ResultSet result = select.executeQuery(query);

    out.print("<div class='container'>");

    result.next();
    
    String title= result.getString(2);
    String year= result.getString(3);
    String director= result.getString(4);
    String pic_URL= result.getString(5);
    String trailer_URL= result.getString(6);
    ArrayList<String> actors= new ArrayList<String>();
    ArrayList<String> genres= new ArrayList<String>();


    String stars_query = "SELECT first_name, last_name FROM stars s, stars_in_movies sim, movies m WHERE sim.star_id = s.id AND sim.movie_id = m.id AND m.id= " + movie_id + ";";

    result= select.executeQuery(stars_query);

    while (result.next())
    {
      String name= result.getString(1) + " " + result.getString(2);
      actors.add(name);
    }

    String genres_query= "SELECT g.name FROM genres g, genres_in_movies gin WHERE gin.genre_id= g.id AND gin.movie_id= '" + movie_id + "'";

    result= select.executeQuery(genres_query);

    while (result.next())
    {
      String genre= result.getString(1);
      genres.add(genre);
    }

    out.print("<div class='float'>");
    out.print("<div><img src='" + pic_URL +"' style='padding-bottom: 20px; width: 200px; height: 350px;'></div></center>");
    out.print("<div class='movie-title'>"); out.print(title); out.print(" ("); out.print(year); out.print(")</div>");
    out.print("<div>"); out.println("Directed by: "+ director); out.print("</div>");
    String star_list= "";

    //Formatting all of the actors into a single string
    for (int i=0; i < actors.size(); i++)
    {
        star_list += actors.get(i);
        if (i != (actors.size() -1))
        {
          star_list += ", ";
        }
    }
    out.print("<div> <b>Actors:</b> " + star_list);

    //Formatting all the genres into a single string
    String genre_list= "";
    for (int i=0; i < genres.size(); i++)
    {
        genre_list += genres.get(i);
        if (i != (genres.size() -1))
        {
          genre_list += ", ";
        }
    }
    out.print("<div> <b>Genres:</b> " + genre_list);
    
    out.println("</div>");


  %>

  </div>


</body>



<%
  connection.close();

%>



<html>