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
            String message = (String) request.getAttribute("errorMsg");
        %>
        <div class="container d-flex align-items-center justify-content-center vh-100">
            <div class="col-lg-6 col-md-10">
                <div class="card">
                    <div class="card-header bg-light text-center" style="color:#6666ff;">
                        <h2>Project Manager</h2>
                    </div>
                    <div class="card-body p-3">
                        <form name="auth" method="post" action="/authentication">
                            <div class="row">
                                <div class="form-group col-md-12 mb-4">
                                    <input type="email" class="form-control input-lg" id="email" name="email" placeholder="Insira o seu e-mail">
                                </div>
                                <div class="form-group col-md-12 ">
                                    <input type="password" class="form-control input-lg" id="password" name="password" placeholder="****">
                                </div>
                                
                                <div class="col-md-12">
                                    <button type="submit" class="btn btn-lg  btn-block mb-4" style="background:#6666ff; color:white">Entrar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>