<%-- 
    Document   : login
    Created on : 10-Mar-2023, 10:45:01
    Author     : Tan Loc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--      <link rel="stylesheet" href="style/mycss.css" type="text/css"/>-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>
        <section>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <form action="mainController" method="post">
                            <h3 style="color: red"> <%= (request.getAttribute("WARNING") == null) ? "" : (String) request.getAttribute("WARNING")%></h3>
                            <h2>Please login</h2>
                            <div class="form-group">
                                <label for="txtemail">Email</label>
                                <input type="text" class="form-control" name="txtemail" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$}">
                            </div>
                            <div class="form-group">
                                <label for="txtpassword">Password</label>
                                <input type="password" class="form-control" name="txtpassword">
                            </div>
                            <div class="form-group form-check">
                                <input type="checkbox" class="form-check-input" value="savelogin" name="savelogin">
                                <label class="form-check-label" for="savelogin">Stay signed in</label>
                            </div>
                            <button type="submit" class="btn btn-primary" name="action" value="login">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

    </body>
</html>
