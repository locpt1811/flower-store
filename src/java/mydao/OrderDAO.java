/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mydao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import mybasicobject.Account;
import mybasicobject.Order;
import mybasicobject.OrderDetail;
import mylib.DBUtils;

/**
 *
 * @author Tan Loc
 */
public class OrderDAO {
    public static ArrayList<Order> getOrders() {
        ArrayList<Order> orderList = new ArrayList<>();
        Connection cn = null;
        try {
            Order order = null;
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String getOrder = "select o.OrderID,o.OrdDate,o.shipdate,o.status,o.AccID\n"
                        + "from Accounts a join Orders o\n"
                        + "on a.accID = o.AccID\n";
                PreparedStatement pst = cn.prepareStatement(getOrder);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int OrderID = rs.getInt("OrderID");
                        int AccId = rs.getInt("AccID");
                        String OrdDate = rs.getString("OrdDate");
                        String shipdate = rs.getString("shipdate");
                        int Status = rs.getInt("status");
                        order = new Order(OrderID, OrdDate, shipdate, Status, AccId);
                        orderList.add(order);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return orderList;
    }
    public static ArrayList<Order> getOrders(String email) {
        ArrayList<Order> orderList = new ArrayList<>();
        Connection cn = null;
        try {
            Order order = null;
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String getOrder = "select o.OrderID,o.OrdDate,o.shipdate,o.status,o.AccID\n"
                        + "from Accounts a join Orders o\n"
                        + "on a.accID = o.AccID\n"
                        + "where email like ?";
                PreparedStatement pst = cn.prepareStatement(getOrder);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int OrderID = rs.getInt("OrderID");
                        int AccId = rs.getInt("AccID");
                        String OrdDate = rs.getString("OrdDate");
                        String shipdate = rs.getString("shipdate");
                        int Status = rs.getInt("status");
                        order = new Order(OrderID, OrdDate, shipdate, Status, AccId);
                        orderList.add(order);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return orderList;
    }

    public static ArrayList<OrderDetail> getOrderDetail(int orderID) {
        ArrayList<OrderDetail> orderListDetail = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String getOrderDetail = "select Detailld,OrderID,PID,PName,price,imgPath,quantity\n"
                        + "from OrderDetails,Plants\n"
                        + "where OrderID = ? and OrderDetails.FID=Plants.PID\n";
                PreparedStatement pst = cn.prepareStatement(getOrderDetail);
                pst.setInt(1, orderID);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int detailID = rs.getInt("Detailld");
                        int plantID = rs.getInt("PID");
                        String plantName = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgPath = rs.getString("imgPath");
                        int quantity = rs.getInt("quantity");
                        OrderDetail orderDetail = new OrderDetail(detailID, orderID, plantID, plantName, price, imgPath, quantity);
                        orderListDetail.add(orderDetail);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return orderListDetail;
    }

    public static boolean reOrder(int OrderID) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String reOrder = "update Orders\n"
                        + "set status = 2\n"
                        + "where OrderID = ?\n";
                PreparedStatement pst = cn.prepareStatement(reOrder);
                pst.setInt(1, OrderID);
                check = pst.executeUpdate() > 0 ? true : false;

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return check;
    }

    public static boolean insertOrder(String email, HashMap<String, Integer> cart) {
        Connection cn = null;
        boolean result = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                int accId = 0, orderId = 0;
                cn.setAutoCommit(false);
                String sql = "SELECT accID from Accounts where Accounts.email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    accId = rs.getInt("accID");
                }
                System.out.println("Account ID: " + accId);
                Date d = new Date(System.currentTimeMillis());
                System.out.println("Order date: " + d);
                sql = "INSERT Orders(OrdDate,status,accID) values (?,?,?)";
                pst = cn.prepareStatement(sql);
                pst.setDate(1, d);
                pst.setInt(2, 1);
                pst.setInt(3, accId);
                pst.executeUpdate();
                //Get order ID that is the largest number
                sql = "SELECT TOP 1 OrderID from Orders order by OrderID desc";
                pst = cn.prepareStatement(sql);
                rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    orderId = rs.getInt("OrderID");
                }
                //Insert order details
                System.out.println("Order ID: " + orderId);
                Set<String> pids = cart.keySet();
                for (String pid : pids) {
                    sql = "insert OrderDetails values (?,?,?)";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, orderId);
                    pst.setInt(2, Integer.parseInt(pid.trim()));
                    pst.setInt(3, cart.get(pid));
                    pst.executeUpdate();
                    cn.commit();
                    cn.setAutoCommit(true);
                }
                return true;
            } else {
                System.out.println("Cannot add Order! Please try again");
            }
        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            result = false;
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    public static ArrayList<Order> fromToOrder(String from, String to) {
        ArrayList<Order> fromToList = new ArrayList<>();
        Connection cn = null;
        try {
            Order order = null;
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String getOrder = "SELECT o.OrderID, o.OrdDate, o.ShipDate, o.Status, o.AccID\n"
                        + "FROM Accounts a \n"
                        + "JOIN Orders o ON a.AccID = o.AccID\n"
                        + "WHERE o.OrdDate BETWEEN ? AND ?\n";
                PreparedStatement pst = cn.prepareStatement(getOrder);
                pst.setString(1, from);
                pst.setString(2, to);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int OrderID = rs.getInt("OrderID");
                        int AccId = rs.getInt("AccID");
                        String OrdDate = rs.getString("OrdDate");
                        String shipdate = rs.getString("shipdate");
                        int Status = rs.getInt("status");
                        order = new Order(OrderID, OrdDate, shipdate, Status, AccId);
                        fromToList.add(order);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return fromToList;
    }
    public static ArrayList<Order> fromToOrder(String from, String to, String email) {
        ArrayList<Order> fromToList = new ArrayList<>();
        Connection cn = null;
        try {
            Order order = null;
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String getOrder = "SELECT o.OrderID, o.OrdDate, o.ShipDate, o.Status, o.AccID\n"
                        + "FROM Accounts a \n"
                        + "JOIN Orders o ON a.AccID = o.AccID\n"
                        + "WHERE a.email = ? and o.OrdDate BETWEEN ? AND ?\n";
                PreparedStatement pst = cn.prepareStatement(getOrder);
                 pst.setString(1, email);
                pst.setString(2, from);
                pst.setString(3, to);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int OrderID = rs.getInt("OrderID");
                        int AccId = rs.getInt("AccID");
                        String OrdDate = rs.getString("OrdDate");
                        String shipdate = rs.getString("shipdate");
                        int Status = rs.getInt("status");
                        order = new Order(OrderID, OrdDate, shipdate, Status, AccId);
                        fromToList.add(order);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return fromToList;
    }
    public static boolean updateOrderStatus(String oid, int status) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Orders\n"
                        + "set status = ? \n"
                        + "where OrderID = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, String.valueOf(status));
                pst.setString(2, oid);
                // Syntax : condition ? value_if_true : value_if_false;
                check = pst.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return check;
    }
}
