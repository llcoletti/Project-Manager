
<header>
    <nav class="navbar navbar-expand-md navbar-dark" style="background:#6666ff; color:white; height:100px;">
        <a class="navbar-brand " href="home.jsp" style="font-size:36px; font-weight:bold">Project Manager</a>
        <div class="collapse navbar-collapse align-items-center justify-content-center" id="navbar">
            <ul class="navbar-nav mr-auto font-weight-light" style=" font-size:18px; margin-left: 200px">
                <li class="nav-item ${param.userLink} " style="color:whitesmoke;">
                    <a class="nav-link" href="lista-usuario.jsp">Usuários</a>
                </li>
                <li class="nav-item ${param.requirementLink}">
                    <a href="lista.jsp" class="list-group-item list-group-item-action text-center">Listar</a>
                </li>
                <li class="nav-item ${param.projectLink}">
        <a href="buscar.jsp" class="list-group-item list-group-item-action text-center">Procurar</a>
                </li>
            </ul>
            <a href="sair.jsp" class="btn btn-outline-secondary btn-sm" role="button" style="color:white; border-color:white">
                <i class="fa fa-sign-out"></i>
            </a>
        </div>
                    
    </nav>
</header>

