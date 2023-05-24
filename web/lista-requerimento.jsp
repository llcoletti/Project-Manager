<%@page import="enums.Classification"%>
<%@page import="entities.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.RequirementDAO"%>
<%@page import="entities.Requirement"%>
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
            <jsp:param name="requirementLink" value="active" />
        </jsp:include>
        <main role="main">
            <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                ArrayList<Requirement> requirements = new RequirementDAO().findAll();
                ProjectDAO projectDao = new ProjectDAO();
                
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
            <br>
            <div class="container col-md-12">
                <div class="card ">
                    <div class="card-header card-header-border-bottom d-flex justify-content-between align-items-center">

                        <h2> <span style="color:#6666ff" >R</span>equisitos</h2>
                        <div>
                            <a href="#" class="modalHandler btn btn-outline-secondary btn-sm" role="button" style="color:#6666ff; border-color:#6666ff">
                                <i class="fa fa-plus"></i>
                            </a>
                        </div>
                    </div>

                    <table class="table table-borderless table-hover text-center" style="margin-bottom: 0px">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Projeto</th>
                                <th>Nome</th>
                                <th>Descrição</th>
                                <th>Versão</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < requirements.size(); i++) {
                                    Project p = projectDao.findById(requirements.get(i).getProjectId());
                            %>
                            <tr>
                                <td><%= requirements.get(i).getId()%></td>
                                <td><%= p.getName()%></td>
                                <td><%= requirements.get(i).getName()%></td>
                                <td><%= requirements.get(i).getDescription()%></td>
                                <td><%= requirements.get(i).getVersion()%></td>
                                <td>
                                    <a href="/requirement?param=update&id=<%= requirements.get(i).getId()%>" class="btn btn-secondary btn-sm" role="button"><i class="fa fa-edit"></i></a>
                                    <a href="/requirement?param=delete&id=<%= requirements.get(i).getId()%>" class="btn btn-danger btn-sm" role="button"><i class="fa fa-remove"></i></a>
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
                            <button type="submit" class="btn btn-dark btn-block"style="background-color:#6666ff; color:white; border-color: transparent">Gravar</button>
                        </form>
                    </div>
            </div>
        </main>
        <script src="/modal.js"></script>
    </body>
</html>