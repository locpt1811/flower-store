<%-- 
    Document   : adminPage
    Created on : 20-Mar-2023, 17:49:42
    Author     : Tan Loc
--%>

<%@page import="mydao.AccountDAO"%>
<%@page import="mybasicobject.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");
            Cookie[] c = request.getCookies();
            boolean login = false;
            if (name == null) {
                String token = "";
                for (Cookie aCookie : c) {
                    if (aCookie.getName().equals("selector")) {
                        token = aCookie.getValue();
                        Account acc = AccountDAO.getAccountByToken(token);
                        if (acc != null) {
                            name = acc.getFullname();
                            email = acc.getEmail();
                            if (acc.getRole() == 1) {
                                login = true;
                            }

                        }
                    }
                }

            } else if (email.equals("admin@gmail.com")) {
                login = true;
            }
            if (!login) {
        %>
        <p><font color='red'>You must login as Admin to view Admin page.<a href="login.jsp">Login</a></p>
        <p></p>
        <% } else {
        %>
        <c:import url="header_loginedAdmin.jsp"></c:import>
            <section class="right">
                <img style="width: 100%; height: auto" src="images/background.jpg">
            </section>
        <% }
        %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
    </body>
</html>
