/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mydao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mybasicobject.Account;
import java.sql.SQLException;
import java.util.ArrayList;
import mylib.DBUtils;

/**
 *
 * @author Tan Loc
 */
public class AccountDAO {
    public static ArrayList<Account> searchAccount(String search) {
        Connection cn = null;
        Account acc = null;
        ArrayList<Account> listOfAccount = new ArrayList<Account>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "SELECT * FROM Accounts WHERE  Accounts.fullname LIKE ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + search + "%");
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    int AccId = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String FullName = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    acc = new Account(AccId, Email, Password, FullName, Status, Phone, Role);
                    listOfAccount.add(acc);
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
        return listOfAccount;
    }

    public static Account getAccount(String email, String password) {
        Connection cn = null;
        Account acc = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select accID,email,password,fullname,phone,status,role\n"
                        + "from Accounts\n"
                        + "where status = 1 and email = ? and password = ? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    int AccId = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String FullName = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    acc = new Account(AccId, Email, Password, FullName, Status, Phone, Role);
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
        return acc;
    }
    public static ArrayList<Account> getAccounts() {
        Connection cn = null;
        Account acc = null;
        ArrayList<Account> listOfAccount = new ArrayList<Account>();
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select accID,email,password,fullname,phone,status,role\n"
                        + "from Accounts\n";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    int AccId = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String FullName = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    acc = new Account(AccId, Email, Password, FullName, Status, Phone, Role);
                    listOfAccount.add(acc);
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
        return listOfAccount;
    }

    public static Account getAccountByToken(String token) {
        Connection cn = null;
        Account acc = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "select accID,email,password,fullname,phone,status,role\n"
                        + "from Accounts\n"
                        + "where token = ?\n";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, token);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    int AccId = rs.getInt("accID");
                    String Email = rs.getString("email");
                    String Password = rs.getString("password");
                    String FullName = rs.getString("fullname");
                    String Phone = rs.getString("phone");
                    int Status = rs.getInt("status");
                    int Role = rs.getInt("role");
                    acc = new Account(AccId, Email, Password, FullName, Status, Phone, Role);
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
        return acc;
    }

    //This function will update the account’s status based 
    //on the given email and return true/false
    public static boolean updateAccountStatus(String email, int status) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Accounts\n"
                        + "set status = ? \n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, String.valueOf(status));
                pst.setString(2, email);
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

    public static boolean updateAccount(String email, String newPassword, String newFullname, String newPhone) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Accounts\n"
                        + "set password = ? , fullname = ?, phone = ?\n"
                        + "where email = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newPassword);
                pst.setString(2, newFullname);
                pst.setString(3, newPhone);
                pst.setString(4, email);
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

    public static boolean insertAccount(String newEmail, String newPassword, String newFullname, String newPhone, int newSatus, int newRole) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "insert into Accounts (email,password,fullname,phone,status,role)\n"
                        + "values(?,?,?,?,?,?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newEmail);
                pst.setString(2, newPassword);
                pst.setString(3, newFullname);
                pst.setString(4, newPhone);
                pst.setString(5, String.valueOf(newSatus));
                pst.setString(6, String.valueOf(newRole));
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

    public static boolean changeProfileAccount(String email, String newName, String newPhone) {
        Connection cn = null;
        boolean check = false;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String sql = "Update Accounts\n"
                        + "set fullname = ?, phone = ?\n"
                        + "where email = ?\n";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, newName);
                pst.setString(2, newPhone);
                pst.setString(3, email);
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

    public static boolean updateToken(String token, String email) {
        boolean check = false;
        Connection cn = null;
        try {
            cn = DBUtils.makeConnection();
            if (cn != null) {
                String updateToken = "update Accounts\n"
                        + "set token = ?\n"
                        + "where email = ?\n";
                PreparedStatement pst = cn.prepareStatement(updateToken);
                pst.setString(1, token);
                pst.setString(2, email);
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
