<%@page import="enums.Profile"%>
<%@page import="entities.User"%>
<%@page import="entities.Project"%>
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
                request.getRequestDispatcher("lista-projeto.jsp").forward(request, response);
                return;
            }
        %>
        <main role="main">
            <%
                String message = (String) request.getAttribute("errorMsg");

                Project p = (Project) request.getAttribute("project");

                if (p == null) {
                    p = new Project();
                    p.setId(0);
                    p.setName("");
                    p.setDescription("");
                }
            %>
            <br/>
            <div class="container col-md-5 mt-5">
                <div class="card " style="margin:10rem">
                    <div class="card-header card-header-border-bottom d-flex justify-content-between align-items-center">
                        <h2> <span style="color:#6666ff" >Cadastrar projeto</span></h2>
                        <a href="lista-projeto.jsp" class="btn btn-outline-secondary btn-sm" role="button">
                            <i class="fa fa-back"></i> Voltar
                        </a>
                    </div>
                    <div class="card-body">
                        <form name="project" method="post" action="/project">
                            <input name="id" type="hidden" value="<%= p.getId()%>">
                            <fieldset class="form-group">
                                <label>Nome do projeto</label> <input type="text"
                                                           class="form-control"
                                                           value="<%= p.getName()%>"
                                                           name="name" id="name" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Descrição do projeto</label> <input type="text"
                                                           class="form-control"
                                                           value="<%= p.getDescription()%>"
                                                           name="description" id="description" required="required">
                            </fieldset>
                            <%
                                if (message != null) {
                            %>
                            <div class="col-md-12 text-center alert alert-danger" role="alert">
                                <%=message%>
                            </div>
                            <% }%>
                            <button type="submit" class="btn btn-block" style="background-color:#6666ff; color:white; border-color: transparent">Gravar</button>
                        </form>
                    </div>

                </div>
            </div>
        </main>
    </body>
</html>