<%-- 
    Document   : header
    Created on : 10-Mar-2023, 10:34:42
    Author     : Tan Loc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-light" >

                <a class="navbar-brand" href="index.jsp">
                    <img src="images/logo.jpg" width="30" height="30" class="d-inline-block align-top" alt="">
                </a>
                <div  class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active"><a href="index.jsp">Home</a></li>
                        <li class="nav-item"><a href="registration.jsp">Register</a></li>
                        <li class="nav-item"><a href="login.jsp">Login</a></li>
                        <li class="nav-item"><a href="mainController?action=viewcart">View Cart</a></li>
                    </ul>
                    <form action="mainController" method="post">
                        <div class="form-group d-flex align-items-center">
                            <input placeholder="Search" class="form-control" type="text" name="txtsearch" value="<%= request.getParameter("txtsearch") == null ? "" : request.getParameter("txtsearch")%>">
                            <select class="form-control" name="searchby">
                                <option value="byname">by name</option>
                                <option value="bycategory">by category</option>
                            </select>
                            <button class="btn btn-outline-success" type="submit" value="search" name="action">Search</button>
                        </div>
                    </form>


                </div>

            </nav>
        </header>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    </body>
</html>
