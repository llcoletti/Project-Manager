<%@page import="enums.Profile"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.UserDAO"%>
<%@page import="entities.User"%>
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
            <jsp:param name="userLink" value="active" />
        </jsp:include>
        <main role="main">
            <%
                ArrayList<User> users = new UserDAO().findAll();

                String message = (String) request.getAttribute("errorMsg");
                Profile[] profiles = Profile.values();

                User u = (User) request.getAttribute("user");

                if (u == null) {
                    u = new User();
                    u.setId(0);
                    u.setName("");
                    u.setEmail("");
                    u.setPassword("");
                    u.setProfile(null);
                }
            %>
            <br>
            <div class="container col-md-12">
                <div class="card">
                    <div class="card-header card-header-border-bottom d-flex justify-content-between align-items-center" >
                        <h2> <span style="color:#6666ff" > U</span>suários</h2>
                        <div>
                            <!--<a href="form-usuario.jsp" class=" modalHandler btn btn-outline-secondary btn-sm" role="button" style="color:#6666ff; border-color:#6666ff">-->
                            <a href="#" class=" modalHandler btn btn-outline-secondary btn-sm" role="button" style="color:#6666ff; border-color:#6666ff">

                                <i class="fa fa-plus"></i>
                            </a>
                        </div>
                    </div>
                    <table class="table table-borderless table-hover " style="margin-bottom: 0px">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>E-mail</th>
                                <th>Perfil</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < users.size(); i++) {
                            %>
                            <tr>
                                <td><%= users.get(i).getId()%></td>
                                <td><%= users.get(i).getName()%></td>
                                <td><%= users.get(i).getEmail()%></td>
                                <td><%= users.get(i).getProfile().getName()%></td>
                                <td>
                                    <a href="/user?param=update&id=<%= users.get(i).getId()%>" class="btn btn-secondary btn-sm" role="button"><i class="fa fa-edit"></i></a>
                                    <a href="/user?param=delete&id=<%= users.get(i).getId()%>" class="btn btn-danger btn-sm" role="button"><i class="fa fa-remove"></i></a>
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
                        <h2> <span style="color:#6666ff" >Cadastrar usuário</span></h2>
                        <a href="lista-usuario.jsp" class="btn btn-outline-secondary btn-sm" role="button">
                            <i class="fa fa-back"></i> Voltar
                        </a>
                    </div>
                    <div class="card-body p-5">
                        <form name="user" method="post" action="/user">
                            <input name="id" type="hidden" value="<%= u.getId()%>">
                            <fieldset class="form-group">
                                <label>Nome</label> <input type="text"
                                                           class="form-control"
                                                           value="<%= u.getName()%>"
                                                           name="name" id="name" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>E-mail</label> <input type="email"
                                                             class="form-control"
                                                             value="<%= u.getEmail()%>"
                                                             name="email" id="email" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Senha</label> <input type="password"
                                                            class="form-control"
                                                            value="<%= u.getPassword()%>"
                                                            name="password" id="password" required="required">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Perfil</label>
                                <select class="form-control" name="profile" id="profile">
                                    <%
                                        for (int i = 0; i < profiles.length; i++) {
                                            if (u.getProfile() != null && profiles[i].getName() == u.getProfile().getName()) {
                                    %>
                                    <option selected><%= profiles[i].getName()%></option>
                                    <%
                                    } else {
                                    %>
                                    <option><%= profiles[i].getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </fieldset>
                            <button type="submit" class="btn btn-dark btn-block"style="background-color:#6666ff; color:white; border-color: transparent">Gravar</button>
                        </form>
                    </div>

                </div>
            </div>
        </main>

        <script src="/modal.js"></script>
    </body>
</html>