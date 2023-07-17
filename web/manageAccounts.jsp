<%-- 
    Document   : manageAccounts
    Created on : 20-Mar-2023, 18:08:05
    Author     : Tan Loc
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html
    <html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
    <c:import url="header_loginedAdmin.jsp"></c:import>
        <nav class="navbar navbar-light">
            <form class="ml-auto" action="mainController" method="post">
                <div class="form-inline">
                    <input class="form-control mr-sm-2" type="text" name="txtSearch" placeholder="Search">
                    <input type="hidden" name="action" value="searchAccount">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="searchAccount" value="Search">Search</button>
                </div>
            </form>

            <form action="mainController" method="post">
                <input type="hidden" name="action" value="manageAccounts">
                <button type="submit" class="btn btn-outline-success my-2 my-sm-0">Get All</button>
            </form>
        </nav>




        <section>
            <table border="1" class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Email</th>
                        <th scope="col">Full Name</th>
                        <th scope="col">Status</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Role</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="acc" items="${requestScope.accountList}">
                    <tr>
                        <td scope="row"><c:out value="${acc.getAccID()}"></c:out></td>
                        <td><c:out value="${acc.getEmail()}"></c:out></td>
                        <td><c:out value="${acc.getFullname()}"></c:out></td>
                        <td><c:choose>
                                <c:when test="${acc.getStatus() eq 1}">Active</c:when>
                                <c:otherwise>inActive</c:otherwise>
                            </c:choose>
                        </td>
                        <td><c:out value="${acc.getPhone()}"></c:out></td>
                        <td><c:choose>
                                <c:when test="${acc.getRole() eq 1}">Admin</c:when>
                                <c:otherwise>User</c:otherwise>
                            </c:choose></td>
                        <td>
                            <c:if test="${acc.getRole() eq 0}">
                                <c:url var="mylink" value="mainController">
                                    <c:param name="email" value="${acc.getEmail()}"></c:param>
                                    <c:param name="status" value="${acc.getStatus()}"></c:param>
                                    <c:param name="action" value="updateStatusAccountServlet"></c:param>
                                </c:url>
                                <form action="${mylink}" method="post">
                                    <button type="submit" class="btn btn-danger">Block/Unblock</button>
                                </form>
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
