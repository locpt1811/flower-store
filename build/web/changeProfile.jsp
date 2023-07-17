<%-- 
    Document   : changeProfile
    Created on : 14-Mar-2023, 22:40:27
    Author     : Tan Loc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            if (name == null) {
        %>
        <p><font color='red'>You must login to view personal page.<a href="login.jsp">Login</a></p>
        <p></p>
        <% } else {
        %>
        <header>
            <% if (session.getAttribute("name") != null) {
            %>
            <%@include file="header_loginedUser.jsp" %>
            <% } else { %>

            <%@include file="header.jsp" %>
            <% } %>
        </header>
        <section>
            <form action="mainController" method="post">
                <table>
                    <tr>
                        <td><h2>Update your fullname and phone</h2></td>
                    </tr>
                    <tr>
                        <td>Fullname</td>
                        <td><input type="text" name="nameChanged"></td></tr>
                    <tr><td>Phone</td>
                        <td><input type="number" name="phoneChanged"></td></tr>
                    <tr><td colspan="2"><input type="submit" value="changeProfile" name="action"></td></tr>
                </table>
            </form>
        </section>
        <footer>
            <%@include file ="footer.jsp" %>
        </footer>
        <% }
        %>
    </body>
</html>
