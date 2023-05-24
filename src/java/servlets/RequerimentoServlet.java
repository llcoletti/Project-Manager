/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.RequirementDAO;
import entities.Requirement;
import enums.Classification;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class RequerimentoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RequirementServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequirementServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("param");
        
        if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            
            Requirement requirement = new RequirementDAO().findById(id);
            
            request.setAttribute("requirement", requirement);
            
            RequestDispatcher rd = request.getRequestDispatcher("form-requerimento.jsp");
            rd.forward(request, response);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            
            if (new RequirementDAO().delete(id)) {
               request.setAttribute("successMsg", "Requisito excluido com sucesso!");                
               RequestDispatcher rd = request.getRequestDispatcher("/lista-requerimento.jsp");  
               rd.include(request, response);
           } else {
               request.setAttribute("errorMsg", "Ocorreu um erro ao excluir o requisito. Tente novamente.");                
               RequestDispatcher rd = request.getRequestDispatcher("/lista-requerimento.jsp");  
               rd.include(request, response);
           }
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");               
        request.setCharacterEncoding("UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String version = request.getParameter("version");
        
        Requirement requirement = new Requirement();
        requirement.setId(id);
        requirement.setProjectId(projectId);
        requirement.setName(name);
        requirement.setDescription(description);
        requirement.setVersion(version);
        
        RequirementDAO dao = new RequirementDAO();
        if (dao.save(requirement)) {
            RequestDispatcher rd = request.getRequestDispatcher("/lista-requerimento.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("errorMsg", "Erro ao salvar os dados! Tente novamente.");                
            RequestDispatcher rd = request.getRequestDispatcher("/form-requerimento.jsp");  
            rd.include(request, response);
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
