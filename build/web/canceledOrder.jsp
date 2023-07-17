<%-- 
    Document   : canceledOrder
    Created on : 15-Mar-2023, 09:58:06
    Author     : Tan Loc
--%>

<%@page import="mydao.OrderDAO"%>
<%@page import="mybasicobject.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

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
            <!--Load all of completed order info here-->
            <%
                String email = (String) session.getAttribute("email");
                ArrayList<Order> listOfOrder = OrderDAO.getOrders(email);
                String[] status = {"", "Canceled", "Processing","Completed" };
                if (listOfOrder != null && !listOfOrder.isEmpty()) {
            %> 
            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <td>Order ID</td>
                        <td>Order Date</td>
                        <td>Ship Date</td>
                        <td>Order's status</td>
                        <td>Action</td>
                    </tr>
                </thead>
                <tbody>
                    <%for (Order ord : listOfOrder) {
                            if (ord.getStatus() == 1) {%>
                    <tr>
                        <td><%= ord.getOrderID()%></td>
                        <td><%= ord.getOrderDate()%></td>
                        <td><%= (ord.getShipDate() == null) ? "Not Yet" : ord.getShipDate()%></td>
                        <td><%= status[ord.getStatus()]%></td>
                        <td>
                            <a href="orderDetail.jsp?orderid=<%=ord.getOrderID()%>">Detail</a>
                        </td>
                        <td rowspan="2">
                            <form action="reOrderServlet" method="post">
                                <input type="hidden" value="<%= ord.getOrderID()%>" name="txtid">
                                <button type="submit">Order Again</button>
                            </form>
                            
                        </td>
                    </tr>
                </tbody>
                <%} }%>
            </table>
            
            <% 
            } else {
            %>
            <p>You don't have any order</p>
            <%}%>
        </section>
        <footer>
            <%@include file ="footer.jsp" %>
        </footer>
        <% }
        %>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

    </body>
</html>
