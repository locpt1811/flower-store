<%-- 
    Document   : manageOrder
    Created on : 21-Mar-2023, 07:45:43
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
                <form class="ml-auto" action="fromToOrderAdmin" method="post">
                    <div class="form-inline">
                        From <input class="form-control mr-sm-2" type="date" name="from">
                        To <input class="form-control mr-sm-2" type="date" name="to">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="searchOrder" value="search">Search</button>
                    </div>
                </form>
                <form action="mainController" method="post">
                    <input type="hidden" name="action" value="manageOrders">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="getall">Get All</button>
                </form>
            </nav>


            <section>
                <table border="1" class="table table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Order ID</th>
                            <th scope="col">Order Date</th>
                            <th scope="col">Ship Date</th>
                            <th scope="col">Status</th>
                            <th scope="col">Acc ID</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="ord" items="${requestScope.orderList}">
                        <tr>
                            <td scope="row"><c:out value="${ord.getOrderID()}"></c:out></td>
                            <td><c:out value="${ord.getOrderDate()}"></c:out></td>
                            <td><c:choose>
                                    <c:when test="${ord.getShipDate() eq null}">Not yet</c:when>
                                    <c:otherwise><c:out value="${ord.getShipDate()}"></c:out></c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${ord.getStatus()}"></c:out></td>
                            <td><c:out value="${ord.getAccID()}"></c:out></td>
                                <td>
                                <c:if test="${ord.getStatus() ne 0}"> <!-- only not change the completed order --> 
                                    <c:url var="cancelLink" value="mainController">
                                        <c:param name="orderid" value="${ord.getOrderID()}"></c:param>
                                        <c:param name="status" value="${ord.getStatus()}"></c:param>
                                        <c:param name="action" value="updateStatusOrderServlet"></c:param>
                                        <c:param name="change" value="cancel"></c:param> <!-- added parameter for cancel -->
                                    </c:url>
                                    <button class="btn btn-warning" onclick="location.href = '${cancelLink}'">Cancel</button>

                                    <c:url var="processingLink" value="mainController">
                                        <c:param name="orderid" value="${ord.getOrderID()}"></c:param>
                                        <c:param name="status" value="${ord.getStatus()}"></c:param>
                                        <c:param name="action" value="updateStatusOrderServlet"></c:param>
                                        <c:param name="change" value="processing"></c:param> <!-- added parameter for processing -->
                                    </c:url>
                                    <button class="btn btn-primary" onclick="location.href = '${processingLink}'">Processing</button>

                                    <c:url var="completeLink" value="mainController">
                                        <c:param name="orderid" value="${ord.getOrderID()}"></c:param>
                                        <c:param name="status" value="${ord.getStatus()}"></c:param>
                                        <c:param name="action" value="updateStatusOrderServlet"></c:param>
                                        <c:param name="change" value="complete"></c:param> <!-- added parameter for complete -->
                                    </c:url>
                                    <button class="btn btn-success" onclick="location.href = '${completeLink}'">Complete</button>


                                </c:if>
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
