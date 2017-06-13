<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"

 %>
<%@ page import="java.util.*" %>

<%
// String x[] = new x[3];
// x[0] = "a";
// x[1] = "b";
// x[2] = "c";
String x = request.getParameter("stringParameter");
String a = "hi";
String b = "bye";
out.print(x);
out.print(a);
out.print(b);

%>
<script>
console.log("insdie jsp");
</script>
