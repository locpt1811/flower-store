<%-- 
    Document   : orderDetail
    Created on : 14-Mar-2023, 10:19:25
    Author     : Tan Loc
--%>

<%@page import="mydao.OrderDAO"%>
<%@page import="mybasicobject.OrderDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="style/mycss.css" type="text/css"/>
    </head>
    <body>
        <%
            String name = (String) session.getAttribute("name");
            if(name == null){
        %>
        <p><font color='red'>You must login to view personal page.<a href="login.jsp">Login</a></p>
        <p></p>
        <% }else{
        %>
        <header>
            <%@include file="header_loginedUser.jsp"%>
        </header>
        <section>
            <h3>Welcome <%=name%> come back</h3>
            <h3><a href="mainController?action=logout">Log out</a></h3>
        </section>
        <section>
            <% String orderid= request.getParameter("orderid");
                if(orderid!= null){
                    int orderID = Integer.parseInt(orderid.trim());
                    ArrayList<OrderDetail> list = OrderDAO.getOrderDetail(orderID);
                    if(list != null && !list.isEmpty()){
                        int money =0;
                        for(OrderDetail detail: list){%>
                        <table class="order">
                            <tr><td>Order ID</td><td>Plant ID</td><td>Plant Name</td><td>Image</td><td>Quantity</td></tr>
                            <tr><td><%= detail.getOrderID()%></td>
                                <td><%= detail.getPlantID()%></td>
                                <td><%= detail.getPlantName()%></td>
                                <td><img src="images/<%=detail.getImgPath()%>" class="plantImg"><br><%=detail.getPrice()%></td>
                                <td><%=detail.getQuantity()%></td>
                                <% money=money + detail.getPrice() * detail.getQuantity(); %>
                                
                            </tr>
                        </table>
                    <%    } %>
                    <h3>Total money : <%=money%></h3>
                 <%   } else { %>
                    <p>You don't have enough money</p>
               <% }     
                } 
               %>
        </section>
        <footer>
            <%@include file ="footer.jsp" %>
        </footer>
        <% }
        %>
    </body>
</html>
