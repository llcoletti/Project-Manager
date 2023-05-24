<%@page import="enums.Profile"%>
<%@page import="entities.User"%>
<%@page import="dao.ProjectDAO"%>
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
        <jsp:include page="navbar.jsp" >
            <jsp:param name="projectLink" value="active" />
        </jsp:include>
        <main role="main">
            <%
                
                ArrayList<Project> projects = new ProjectDAO().findAll();
                
                String message = (String) request.getAttribute("errorMsg");

                Project p = (Project) request.getAttribute("project");

                if (p == null) {
                    p = new Project();
                    p.setId(0);
                    p.setName("");
                    p.setDescription("");
                }
            %>
            <br>
            <div class="container col-md-12">
                <div class="card" >
                    <div class="card-header card-header-border-bottom d-flex justify-content-between align-items-center">
                        <h2> <span style="color:#6666ff" >P</span>rojetos</h2>
                        <div>
                            <a href="#" class="modalHandler btn btn-outline-secondary btn-sm" role="button" style="color:#6666ff; border-color:#6666ff">
                                <i class="fa fa-plus"></i>
                            </a>
                        </div>
                    </div>
                    <table class="table table-borderless table-hover " style="margin-bottom: 0px">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Descrição</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < projects.size(); i++) {
                            %>
                            <tr>
                                <td><%= projects.get(i).getId()%></td>
                                <td><%= projects.get(i).getName()%></td>
                                <td><%= projects.get(i).getDescription()%></td>
                                <td>
                                    <a href="/project?param=update&id=<%= projects.get(i).getId()%>" class="btn btn-secondary btn-sm" role="button"><i class="fa fa-edit"></i></a>
                                    <a href="/project?param=delete&id=<%= projects.get(i).getId()%>" class="btn btn-danger btn-sm" role="button"><i class="fa fa-remove"></i></a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>                        
            <div class="modal" id="exampleModal" tabindex="-1" role="dialog">
                <div class="card " style="margin:10rem 20rem 10rem 20rem">
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
                            <button type="submit" class="btn btn-block" style="background-color:#6666ff; color:white; border-color: transparent">Gravar</button>
                        </form>
                    </div>

                </div>

            </div>
        </div>
    </main>
    <script src="/modal.js"></script>
</body>
</html>