<%-- 
    Document   : index
    Created on : 10-Mar-2023, 10:43:29
    Author     : Tan Loc
--%>

<%@page import="mydao.PlantDao"%>
<%@page import="mybasicobject.Plant"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>index</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <% if (session.getAttribute("name") != null) {
            %>
            <%@include file="header_loginedUser.jsp" %>
            <% } else { %>

            <%@include file="header.jsp" %>
            <% } %>
        </header>
        
        <form action="fromToOrder" method="post">
                <div class="form-group d-flex align-items-center">
                    From<input class="form-control" type="date" name="from">
                    To <input class="form-control" type="date" name="to">

                    <button class="btn btn-outline-success" type="submit" value="search" name="action">Search</button>
                </div>
            </form>
        <section>
            <% String keyword = request.getParameter("txtsearch");
                String searchby = request.getParameter("searchby");
                ArrayList<Plant> listOfPlant;
                String plantStatus[] = {"Out of stock", "Available"};
                if (keyword == null && searchby == null) // when page loaded all of plant will be display
                {
                    listOfPlant = PlantDao.getPlants("", "");
                } else {
                    listOfPlant = PlantDao.getPlants(keyword, searchby);
                }
                if (listOfPlant != null && !listOfPlant.isEmpty()) {%>

            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr >
                        <th scope="col">Plant ID</th>
                        <th scope="col">Plant Name</th>
                        <th scope="col">Plant ID</th>
                        <th scope="col">Price</th>
                        <th scope="col">Status</th>
                        <th scope="col">Category Name</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>

                <tbody>
                    <%

                        for (Plant p : listOfPlant) {%>
                    <tr>
                        <td scope="row"><img src="images/<%=p.getImgPath()%>" class ="plantImg"></td>
                        <td><%=p.getId()%></td>
                        <td><%=p.getName()%></td>
                        <td><%=p.getPrice()%></td>
                        <td><%=plantStatus[p.getStatus()]%></td>
                        <td><%=p.getCatename()%></td>
                        <td>
                            <form action="mainController" method="get">
                                <input type="hidden" name="action" value="addtocart">
                                <input type="hidden" name="pid" value="<%= p.getId()%>">
                                <button class="btn btn-lg btn-primary" type="submit">Add to cart</button>
                            </form>
                        </td>

                    </tr>
                </tbody>
                <%}
                    }%> 
            </table>


        </section>
        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    </body>
</html>
