<%-- 
    Document   : viewCart
    Created on : 16-Mar-2023, 17:58:51
    Author     : Tan Loc
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="mybasicobject.Plant"%>
<%@page import="mydao.PlantDao"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <section>
            <%
                String name = (String) session.getAttribute("name");
                if (name != null) {
            %>
            <h1 style="font-family: cursive; font-size: 30px; text-align: center;">
                Welcome <%= session.getAttribute("name")%>!
            </h1>

            <div style="display: flex; justify-content: space-around; margin-top: 30px;">
                <form action="searchServlet" method="post">
                    <input type="text" name="txtsearch">
                    <select name="searchby">
                        <option>by name</option>
                        <option>by category</option>
                    </select>
                    <button type="submit" value="search" name="action" style="background-color: red; color: white; padding: 10px 20px; font-size: 20px; border: none; border-radius: 5px; cursor: pointer;">
                        Search
                    </button>
                </form>

            </div>

            <% }%>
            <h3 style="color: red"> <%= (request.getAttribute("WARNING") == null) ? "" : (String) request.getAttribute("WARNING")%></h3>
            <table style="width: 100%" class="table table-striped">
                <thead><tr><td>Product ID</td><td>Product Name</td><td>Image</td><td>Quantity</td><td>Price</td><td>Action</td></tr></thead>
                <% HashMap<String, Integer> cart = (HashMap) session.getAttribute("cart");
                    int money = 0;
                    if (cart != null) {
                        Set<String> pids = cart.keySet();
                        ArrayList<Plant> list;

                        for (String pid : pids) {
                            int quantity = cart.get(pid);
                            list = PlantDao.getPlants("", "");
                            Plant thisPlant = null;
                            for (Plant p : list) {
                                if (Integer.toString(p.getId()).equals(pid)) {
                                    thisPlant = p;
                                }
                            }
                %>
                <form action="mainController" method="post">
                    <tr><td><input type="hidden" value="<%= pid%>" name="pid"><a href="getPlantServlet?pid=<%= pid%>"><%= pid%></a></td>
                        <td><%= thisPlant.getName()%></td>
                        <td><img style="width: 120px; height: 120px" src="images/<%= thisPlant.getImgPath()%>"></td>

                        <td><input type="number" value="<%= quantity%>" name="quantity"></td>
                        <td><%= thisPlant.getPrice() * quantity%></td>
                        <td>
                            <button class="btn btn-lg btn-primary" type="submit"name="action" value="updatecart">Update</button>
                            <button class="btn btn-lg btn-primary" type="submit"name="action" value="deletecart">Delete</button>
                        </td>

                    </tr>
                </form>
                <%
                        money += thisPlant.getPrice() * quantity;
                    }
                } else {
                %>
                <tr><td colspan="6"></td></tr>
                <%}%>
            </table>
            <div class="alert alert-success" role="alert">
                <h3>Total money: <%= money%></h3>
            </div>
        </section>
        <section>
            <form action="mainController" method="post">
                <button type="submit" name="action" value="saveOrder" class="btn btn-primary">Save Order</button>
            </form>
        </section>

        <footer>
            <%@include file="footer.jsp" %>
        </footer>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

    </body>
</html>
