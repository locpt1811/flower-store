<%-- 
    Document   : registration
    Created on : 10-Mar-2023, 10:46:58
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
        <header>
            <%@include file="header.jsp" %>
        </header>
        
        <section>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <form action="mainController" method="post" class="formRegister">
                            <h1>Register</h1>
                            <div class="form-group">
                                <label for="txtemail">Email</label>
                                <input type="text" class="form-control" name="txtemail" required="" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" value="<%=(request.getAttribute("txtemail") == null) ? "" : request.getAttribute("txtemail")%>">
                            </div>
                            <div class="form-group">
                                <label for="txtfullname">Full Name</label>
                                <input type="text" class="form-control" name="txtfullname" required="" value="<%=(request.getAttribute("txtfullname") == null) ? "" : request.getAttribute("txtfullname")%>">
                            </div>
                            <div class="form-group">
                                <label for="txtpassword">Password</label>
                                <input type="password" class="form-control" name="txtpassword" required="">
                            </div>
                            <div class="form-group">
                                <label for="txtphone">Phone</label>
                                <input type="text" class="form-control" name="txtphone" value="<%=(request.getAttribute("txtphone") == null) ? "" : request.getAttribute("txtphone")%>">
                                <%=(request.getAttribute("ERROR") == null) ? "" : request.getAttribute("ERROR")%>
                            </div>
                            <button type="submit" class="btn btn-primary" value="register"  name="action">Register</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
