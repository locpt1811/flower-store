/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mydao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mybasicobject.Plant;
import mylib.DBUtils;

/**
 *
 * @author Tan Loc
 */
public class PlantDao {
    public static boolean updatePlant(String pid, String img, String des, int price) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Plants\n"
                        + "set imgPath = ?, description= ?, price = ?\n"
                        + "where PID = ?\n";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, img);
                pst.setString(2, des);
               pst.setInt(3, price);
               pst.setString(4, pid);
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
    
    public static boolean changePlantStatus(String pid, int status) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Plants\n"
                        + "set status = ?\n"
                        + "where PID = ?\n";
                PreparedStatement pst = cn.prepareStatement(sql);
               pst.setInt(1, status);
               pst.setString(2, pid);
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

    public static Plant getPlants(int pid) {
        Plant plant = null;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select PID,PName,imgPath,price,description,status,Plants.CatelD as cateid,CateName\n"
                        + "from Plants,Categories\n"
                        + "where Plants.CatelD = Categories.CateID and PID = ?\n";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, pid);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    
                        pid = rs.getInt("PID");
                        String name = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgpath = rs.getString("imgPath");
                        String description = rs.getString("description");
                        int status = rs.getInt("status");
                        int cateid = rs.getInt("cateID");
                        String catename = rs.getString("CateName");
                        plant = new Plant(pid, name, price, imgpath, description, status, cateid, catename);

                    

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
        return plant;
    }

    public static ArrayList<Plant> getPlants(String keyword, String searchby) {
        ArrayList<Plant> listOfPlants = new ArrayList<Plant>();
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null && searchby != null) {
                String sql = "select PID,PName,price,imgPath,description,status,Plants.CatelD as 'CateID',CateName\n"
                        + "from Plants join Categories\n"
                        + "on Plants.CatelD = Categories.CateID\n";
                if (searchby.equalsIgnoreCase("byname")) {
                    sql = sql + "where Plants.PName like ?";
                } else {
                    sql = sql + "where CateName like ?";
                }
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("PID");
                        String name = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgpath = rs.getString("imgPath");
                        String description = rs.getString("description");
                        int status = rs.getInt("status");
                        int cateid = rs.getInt("CateID");
                        String catename = rs.getString("CateName");
                        Plant plant = new Plant(id, name, price, imgpath, description, status, cateid, catename);
                        listOfPlants.add(plant);
                        System.out.println(plant);
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
        return listOfPlants;
    }

}
