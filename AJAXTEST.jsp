<html>

<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>


<%@ page import="java.util.*" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<head>


  <jsp:include page="header.jsp" />

  <title>Movie Search</title>


  <style>

  #tooltip {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
  }

  #tooltip #tooltiptext {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;

    /* Position the tooltip */
    position: absolute;
    z-index: 1;
  }

  #tooltip:hover #tooltiptext {
    visibility: visible;
  }


  #container {
      text-align: center;
  }

  .float {
      display:inline-block;
      text-align: left;

      width:100%;
      height:350px;
      margin:5px;
      padding-left: 10%;
  }

  .movie-title {
    font-size: 16px;
    font-weight: 700;
  }


  </style>

</head>

  <%
  String pic_URL= "";

  String movie_id = "905";
  String movie_title= "Revenge of the Sith";
  String year= "2005";
  String director= "George Lucas";

  %>

<script>

//Browser Support Code


function ajaxFunction(x){
  var ajaxRequest;  // The variable that makes Ajax possible!
  var url= "../TomcatForm/popup_servlet.jsp?id=" + x;
  try{
    // Opera 8.0+, Firefox, Safari
    ajaxRequest = new XMLHttpRequest();
  } catch (e){
    // Internet Explorer Browsers
    try{
      ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      try{
        ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (e){
        // Something went wrong
        alert("Your browser broke!");

        return false;
      }
    }
  }


  // Create a function that will receive data sent from the server
  ajaxRequest.onreadystatechange = function(){

    if(ajaxRequest.readyState == 4){
      var val= ajaxRequest.responseText;

      document.getElementById('tooltiptext').innerHTML= val;  
    }
  }

  ajaxRequest.open("GET", url, true);
  ajaxRequest.send();
  console.log("ITS WORKINGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG ");
  console.log(x);


  //ajaxRequest.open("GET", "../TomcatForm/servlet.jsp?sQuery="+sQuery, true);
  //ajaxRequest.send(null);

  ///* %> onmouseover= 'ajaxFunction(this.id)'; */
}

</script>









<body>

This is a popbox test.  <a href="#" > Hover here</a> to see how it works.


    <p>Move the mouse over the text below:</p>
    ASDSADSAASSDAD
    <div movie_id= "11" id="tooltip" onmouseover= 'ajaxFunction(this.movie_id)' > Hover over me
      <span id="tooltiptext"></span> 
    </div>



    <div movie_id= "12" id="tooltip" onmouseover= 'ajaxFunction(this.movie_id)' > Hover over me
      <span id="tooltiptext"></span> 
    </div>


<!--     <div class='float'> <p>

      <a movie_id= "12" id="tooltip" onmouseover= 'ajaxFunction(this.movie_id)' movie_id= <% out.print(movie_id); %> href= <%= "\"SingleMovie.jsp?Id=" + movie_id + "\"" %> >
        <span id="tooltiptext"></span> 

      <%
      out.print("<img src='" + pic_URL +"' style='float:left; width: 200px; height: 300px;'>");
      out.print("<div style='padding-left: 30%'>");
      out.print("<div class='movie-title'>"); out.print(movie_title); out.print(" ("); out.print(year); out.print(")</a></div>");
      out.print("<div><strong>"); out.println("Directed by: </strong>"+ director); out.print("</div>");
      out.print("<div>"); out.println("<strong>Movie ID</strong>: "+ movie_id); out.print("</div>");

      out.print("<div> <b>Actors:</b>");
      out.print("</div>");


    out.print("<div> <b>Genres:</b> ");
    out.print("</div></div>");

    %>  -->







    </body>

</html>

