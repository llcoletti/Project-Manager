<%@page import="entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="enums.Profile"%>
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
            User user = (User) session.getAttribute("loggedInUser");
            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            } else if (user.getProfile() != Profile.ADMIN) {
                request.setAttribute("errorMsg", "Você não tem permissão para acessar essa funcionalidade.");
                request.getRequestDispatcher("lista-usuario.jsp").forward(request, response);
                return;
            }
        %>
        <main role="main">
            <%
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
            <br/>
            <div class="container col-md-5 mt-5">
                <div class="card">
                    <div class="card-header card-header-border-bottom d-flex justify-content-between align-items-center">
                        <h2> <span style="color:#6666ff" >Cadastrar usuário</span></h2>
                        <a href="lista-usuario.jsp" class="btn btn-outline-secondary btn-sm" role="button">
                            <i class="fa fa-back"></i> Voltar
                        </a>
                    </div>
                    <div class="card-body">
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