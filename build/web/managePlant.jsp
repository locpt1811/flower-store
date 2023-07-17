<%-- 
    Document   : managePlant
    Created on : 21-Mar-2023, 15:40:42
    Author     : Tan Loc
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body>
        <c:import url="header_loginedAdmin.jsp"></c:import>
            <nav class="navbar navbar-light bg-light">
                <form action="mainController" method="post" class="ml-auto">
                    <div class="form-inline">
                        <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" name="txtSearch">
                        <input type="hidden" name="action" value="searchPlant">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="searchOrder" value="action">Search</button>
                    </div>
                </form>
                <form action="mainController" method="post">
                    <input type="hidden" name="action" value="managePlants">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="getall">Get All</button>
                </form>
            </nav>


            <section>
                <table border="1" class="table table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Plant ID</th>
                            <th scope="col">Plant Name</th>
                            <th scope="col">Description</th>
                            <th scope="col">Image</th>
                            <th scope="col">Price</th>
                            <th scope="col">Status</th>
                            <th scope="col">Category ID</th>
                            <th scope="col">Category Name</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${requestScope.plantList}">
                        <tr>
                            <td scope="row"><c:out value="${p.getId()}"></c:out></td>
                            <td><c:out value="${p.getName()}"></c:out></td>
                            <td><c:out value="${p.getDescription()}"></c:out></td>
                            <td><img style="width: 100px; height:100px" class="rounded" src="images/${p.getImgPath()}"></td>
                            <td><c:out value="${p.getPrice()}"></c:out></td>
                            <td><c:choose>
                                    <c:when test="${p.getStatus() eq 1}">Available</c:when>
                                    <c:otherwise>Out of stock</c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${p.getCateid()}"></c:out></td>
                            <td><c:out value="${p.getCatename()}"></c:out></td>
                                <td>
                                <c:url var="mylink" value="updatePlantStatusServlet">
                                    <c:param name="status" value="${p.getStatus()}"></c:param>
                                    <c:param name="pid" value="${p.getId()}"></c:param>
                                </c:url>
                                <form action="${mylink}" method="post">
                                    <button type="submit" class="btn btn-danger">In Stock/ Out of Stock</button>
                                </form>
                                <form action="changePlantinfo.jsp">
                                    <input type="hidden" name="pid" value="${p.getId()}">
                                    <input type="hidden" name="action" value="changePlantInfo">
                                    <button class="btn btn-primary" type="submit">Change Plant</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

        </section>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
