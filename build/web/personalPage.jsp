<%-- 
    Document   : personalPage
    Created on : 11-Mar-2023, 07:49:31
    Author     : Tan Loc
--%>

<%@page import="mybasicobject.Account"%>
<%@page import="mydao.AccountDAO"%>
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
                            login = true;
                        }
                    }
                }

            } else {
                login = true;
            }
            if (!login) {
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
            <% }%>

        </header>
        <section>
            <h1 style="font-family: cursive; font-size: 30px; text-align: center;">
                Welcome <%= session.getAttribute("name")%>!
            </h1>

            <div style="display: flex; justify-content: space-around; margin-top: 30px;">
                <form action="mainController" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button style="background-color: red; color: white; padding: 10px 20px; font-size: 20px; border: none; border-radius: 5px; cursor: pointer;">
                        Log out
                    </button>
                </form>

            </div>
        </section>
            <section style="padding: 20px">
            <form action="fromToOrder" method="post">
                <div class="form-group d-flex align-items-center">
                    From<input class="form-control" type="date" name="from">
                    To <input class="form-control" type="date" name="to">

                    <button class="btn btn-outline-success" type="submit" value="search" name="action">Search</button>
                </div>
            </form>
        </section>
        <section>
            <!--Load all of order info here-->
            <!--Load all of order info here-->
            <%
                //String email = (String) session.getAttribute("email");
                ArrayList<Order> listOfOrder = (ArrayList<Order>) request.getAttribute("fromToList");
                if (listOfOrder == null || listOfOrder.isEmpty()) {
                    listOfOrder = OrderDAO.getOrders(email);
                }
                String[] status = {"", "Canceled", "Processing","Completed" };
                if (listOfOrder != null && !listOfOrder.isEmpty()) {%>

            <table class="table table-striped">
                <thead class="thead-dark">
                    <tr>
                        <td scope="col">Order ID</td>
                        <td scope="col">Order Date</td>
                        <td scope="col">Ship Date</td>
                        <td scope="col">Order's status</td>
                        <td scope="col">Action</td>
                    </tr>
                </thead>
                <tbody>
                    <% for (Order ord : listOfOrder) {%>
                    <tr>
                        <td><%= ord.getOrderID()%></td>
                        <td><%= ord.getOrderDate()%></td>
                        <td><%= (ord.getShipDate() == null) ? "Not Yet" : ord.getShipDate()%></td>
                        <td><%= status[ord.getStatus()]%>
                            <br><% if (ord.getStatus() == 2) {%><form action="cancelOrder" method="post"><input type="hidden" name="oid" value="<%= ord.getOrderID()%>"><button type="submit">Cancel</button></form><%}%>
                        </td>
                        <td><a href="orderDetail.jsp?orderid=<%=ord.getOrderID()%>">detail</a></td>
                    </tr>
                </tbody>
                <%      } %>
            </table>


            <%} else {
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
