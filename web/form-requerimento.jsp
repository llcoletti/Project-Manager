<%@page import="enums.Profile"%>
<%@page import="entities.User"%>
<%@page import="entities.Project"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="entities.Requirement"%>
<%@page import="enums.Classification"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="head.jsp" >
            <jsp:param name="title" value="Project Manager" />
        </jsp:include>
    </head>
    <body style="background-color:#D7D7FF">
        <%
            User user = (User)session.getAttribute("loggedInUser");
            if (user == null) {            
                response.sendRedirect("index.jsp");
                return;
            } else if (user.getProfile() != Profile.ADMIN) {
                request.setAttribute("errorMsg", "Você não tem permissão para acessar essa funcionalidade.");
                request.getRequestDispatcher("lista-requerimento.jsp").forward(request, response);
                return;
            }
        %>
        <main role="main">
            <%
                String message = (String) request.getAttribute("errorMsg");
                Classification[] classifications = Classification.values();

                Requirement r = (Requirement) request.getAttribute("requirement");

                if (r == null) {
                    r = new Requirement();
                    r.setId(0);
                    r.setProjectId(0);
                    r.setName("");
                    r.setDescription("");
                    r.setVersion("");
                    r.setCreatedAt(null);
                }
            %>
            <br/>
            <div class="container col-md-5 mt-5">
                <div class="card">
                    <div class="card-header card-header-border-bottom d-flex justify-content-between align-items-center">
                        <h2> <span style="color:#6666ff" >Cadastrar requisitos</span></h2>
                        <a href="lista-requerimento.jsp" class="btn btn-outline-secondary btn-sm" role="button">
                            <i class="fa fa-back"></i> Voltar
                        </a>
                    </div>
                    <div class="card-body">
                        <form name="requirement" method="post" action="/requirement">
                            <input name="id" type="hidden" value="<%= r.getId()%>">

                            <fieldset class="form-group">
                                <label>Selecione o projeto</label>
                                <select class="form-control" name="projectId" id="projectId">
                                    <%
                                        ArrayList projects = new ProjectDAO().findAll();
                                        for (int i = 0; i < projects.size(); i++) {
                                            Project p = (Project) projects.get(i);
                                            if (r.getProjectId() == p.getId()) {
                                    %>
                                    <option value="<%= p.getId()%>" selected><%= p.getName()%></option>
                                    <%
                                        } else {
                                    %>
                                    <option value="<%= p.getId()%>"><%= p.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Nome do requisito</label> <input type="text"
                                                           class="form-control"
                                                           value="<%= r.getName()%>"
                                                           name="name" id="name" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Descrição do requisito</label> <input type="text"
                                                                class="form-control"
                                                                value="<%= r.getDescription()%>"
                                                                name="description" id="description" required="required">
                            </fieldset>
                                
                            <fieldset class="form-group">
                                <label>Versão</label> <input type="text"
                                                           class="form-control"
                                                           value="<%= r.getVersion()%>"
                                                           name="version" id="version" required="required">
                            </fieldset>
                            <%
                                if (message != null) {
                            %>
                            <div class="col-md-12 text-center alert alert-danger" role="alert">
                                <%=message%>
                            </div>
                            <% }%>
                            <button type="submit" class="btn btn-dark btn-block"style="background-color:#6666ff; color:white; border-color: transparent">Gravar</button>
                        </form>
                    </div>

                </div>
            </div>
        </main>
    </body>
</html>