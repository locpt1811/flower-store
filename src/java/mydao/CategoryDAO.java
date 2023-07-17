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
import mybasicobject.Category;
import mybasicobject.Order;
import mylib.DBUtils;

/**
 *
 * @author Tan Loc
 */
public class CategoryDAO {

    public static ArrayList<Category> getCategory() {
        ArrayList<Category> categoryList = new ArrayList<>();
        Connection cn = null;
        try {
            Category cate = null;
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String getCategory = "select CateID, CateName\n"
                        + "from Categories\n";
                PreparedStatement pst = cn.prepareStatement(getCategory);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int cateID = rs.getInt("CateID");
                        String cateName = rs.getString("CateName");
                        cate = new Category(cateID, cateName);
                        categoryList.add(cate);
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
        return categoryList;
    }
}
