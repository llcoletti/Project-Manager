/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import dao.ProjectDAO;
import entities.Project;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProjetoServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProjectServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProjectServlet at " + request.getContextPath() + "</h1>");
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
            
            Project project = new ProjectDAO().findById(id);
            
            request.setAttribute("project", project);
            
            RequestDispatcher rd = request.getRequestDispatcher("form-projeto.jsp");
            rd.forward(request, response);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            
            if (new ProjectDAO().delete(id)) {
               request.setAttribute("successMsg", "Projeto excluido com sucesso!");                
               RequestDispatcher rd = request.getRequestDispatcher("/lista-projeto.jsp");  
               rd.include(request, response);
           } else {
               request.setAttribute("errorMsg", "Ocorreu um erro ao excluir o projeto. Tente novamente.");                
               RequestDispatcher rd = request.getRequestDispatcher("/lista-projeto.jsp");  
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
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        Project project = new Project();
        project.setId(id);
        project.setName(name);
        project.setDescription(description);
        
        ProjectDAO dao = new ProjectDAO();
        if (dao.save(project)) {
            RequestDispatcher rd = request.getRequestDispatcher("/lista-projeto.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("errorMsg", "Erro ao salvar os dados! Tente novamente.");                
            RequestDispatcher rd = request.getRequestDispatcher("/form-projeto.jsp");  
            rd.include(request, response);
        }
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
