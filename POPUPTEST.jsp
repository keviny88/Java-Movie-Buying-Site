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


  .popbox {
    display: none;
    position: absolute;
    z-index: 99999;
    width: 400px;
    padding: 10px;
    background: #EEEFEB;
    color: #000000;
    border: 1px solid #4D4F53;
    margin: 0px;
    -webkit-box-shadow: 0px 0px 5px 0px rgba(164, 164, 164, 1);
    box-shadow: 0px 0px 5px 0px rgba(164, 164, 164, 1);
  }
  .popbox h2 {
    background-color: #4D4F53;
    color: #E3E5DD;
    font-size: 14px;
    display: block;
    width: 100%;
    margin: -10px 0px 8px -10px;
    padding: 5px 10px;
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

$(function() {

var moveLeft = 0;
var moveDown = 0;
$('a.popper').hover(function (e) {

    ajaxFunction($(this).attr('movie_id'));
    var target = '#' + ($(this).attr('data-popbox'));
    $(target).show();
    moveLeft = $(this).outerWidth();
    moveDown = ($(target).outerHeight() / 2);
}, function () {
    var target = '#' + ($(this).attr('data-popbox'));
    if (!($("a.popper").hasClass("show"))) {
        $(target).hide();
    }
  })


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

      document.getElementById('pop1').innerHTML= val;  
    }
  }


  ajaxRequest.open("GET", url, true);
  ajaxRequest.send();
  console.log("ITS WORKINGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG ");
  console.log(x);


}


 } ); 




  ///* %> onmouseover= 'ajaxFunction(this.id)'; */


</script>



<body>






   <div class='float'> <p>

      <a class="popper" data-popbox="pop1" movie_id= <% out.print(movie_id); %> href= <%= "\"SingleMovie.jsp?Id=" + movie_id + "\"" %> >

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

    %>   

    <div id="pop1" class="popbox">
    </div>



    </body>

</html>

