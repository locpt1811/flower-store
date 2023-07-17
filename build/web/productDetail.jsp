<%@page import="java.util.ArrayList"%>
<%@page import="mybasicobject.Plant"%>
<%@page import="mydao.PlantDao"%>
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


            <table border="1">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Image</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Category</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${plantObj.id}</td>
                        <td>${plantObj.name}</td>
                        <td><img style="width: 120px; height: 120px" src="images/${plantObj.imgPath}"></td>
                        <td>${plantObj.price}</td>
                        <td>${plantObj.status}</td>
                        <td>${plantObj.catename}</td>
                    </tr>
                </tbody>
            </table>
        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
    </body>
</html>
