/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mybasicobject.Plant;
import mydao.PlantDao;

/**
 *
 * @author Tan Loc
 */
public class searchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String keyword = request.getParameter("txtsearch");
            String searchby = request.getParameter("searchby");
            ArrayList<Plant> listOfPlant = PlantDao.getPlants(keyword, searchby);

            if (listOfPlant == null) {
                System.out.println("listOfPlant is null");
            } else if (listOfPlant.isEmpty()) {
                System.out.println("listOfPlant is empty");
            }

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Plant Search Results</title>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<link rel='stylesheet' href=\"style/search.css\" type='text/css' />");
            out.println("</head>");
            out.println("<body>");
            out.println("<section>");
            out.println("<h1>Plant Search Results</h1>");
            ServletContext context = getServletContext();
            String country = context.getInitParameter("countryName");
            ServletConfig config = getServletConfig();
            String language = config.getInitParameter("language");
            out.println("<p>This website is develop in : " + country + "</p>");
            out.println("<p>This is display in : " + language + "</p>");
            
            if (listOfPlant == null) {
                out.println("<p>An error occurred while fetching plant data.</p>");
            } else if (listOfPlant.isEmpty()) {
                out.println("<p>No plants found for the given search criteria.</p>");
            } else {
                out.println("<table class='producttable'>");
                out.println("<thead><tr><td>product id</td><td>name</td><td>price</td><td>image</td><td>detail</td><td>action</td></thead>");
                out.println("<tbody>");
                for (Plant plant : listOfPlant) {
                    out.println("<tr>");
                    out.println("<td class=\"col1\">" + plant.getId() + "</td>");
                    out.println("<td class=\"col2\">" + plant.getName() + "</td>");
                    out.println("<td class=\"col3\">" + plant.getPrice() + "</td>");
                    out.println("<td class=\"col4\"><img src=\"images/" + plant.getImgPath() + "\" class='product'/></td>");
                    out.println("<td class=\"col5\"><a href='#'>view detail</a></td>");
                    out.println("<td class=\"col6\"><a href='#'>add to your cart</a></td>");
                    out.println("</tr>");
                }
                out.println("</tbody>");
                out.println("</table>");
            }

            out.println("</section>");
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Error</title>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<link rel='stylesheet' href='style/mycss.css' type='text/css' />");
            out.println("</head>");
            out.println("<body>");
            out.println("<section>");
            out.println("<h1>Error</h1>");
            out.println("<p>An error occurred while processing your request.</p>");
            out.println("</section>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
