<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<%@page import="java.sql.*,
	 javax.sql.*,
	 java.io.IOException,
	 javax.servlet.http.*,
	 javax.servlet.*"
	%>
<HTML>
	<%!/*
	public class SessionsTracker implements HttpSessionListener{
		private static ArrayList<String> activeSessions = new ArrayList<String>();

		public void sessionCreated( HttpSessionEvent se ){
			activeSessions.add(se.getSession.getId());
		}

		public void sessionDestroyed( HttpSessionEvent se){
			activeSessions.remove(se.getSession.getId());
		}

		public boolean seesionContains( HttpSessionEvent se){
			return activeSessions.contains(se.getSession.getId());
		}
	}*/
	%>

	<%
	request.getSession(false).invalidate();
	request.setAttribute("email", null);
	request.setAttribute("valid", null);
	response.sendRedirect("/TomcatForm/index.jsp");
	%>
</HTML>