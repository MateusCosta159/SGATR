<%@page import="model.Usuario"%>
<%@page import="model.TipoUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession s = request.getSession(false);

    Usuario usuarioLogado = null;
    TipoUsuario tipoUsuarioLogado = null;

    if (s != null) {
        usuarioLogado = (Usuario) s.getAttribute("usuario");
        tipoUsuarioLogado = (TipoUsuario) s.getAttribute("tipo_usuario");
    }
    
    // Detectar página atual
    String currentPath = request.getRequestURI();
    String currentPage = currentPath.substring(currentPath.lastIndexOf("/") + 1);
%>

<!-- Incluir o CSS do menu -->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/app/css/menu.css">

<div class="menu-container">
    <ul class="menu-list">
        <li class="menu-item">
            <a class="menu-link <%= currentPage.contains("menu.jsp") ? "active" : "" %>" 
               href="<%= request.getContextPath() %>/home/app/menu.jsp">Menu</a>
        </li>

        <% if (tipoUsuarioLogado != null && "S".equals(tipoUsuarioLogado.getModuloAdmin())) { %>
            <li class="menu-item module-separator">|</li>
            <li class="menu-item module-title">Admin</li>
            <li class="menu-item">
                <a class="menu-link <%= currentPage.contains("tipousuario") ? "active" : "" %>" 
                   href="<%= request.getContextPath() %>/home/app/adm/tipousuario.jsp">Tipo Usuário</a>
            </li>
            <li class="menu-item">
                <a class="menu-link <%= currentPage.contains("usuarios.jsp") ? "active" : "" %>" 
                   href="<%= request.getContextPath() %>/home/app/adm/usuarios.jsp">Usuários</a>
            </li>
        <% } %>

        <% if (tipoUsuarioLogado != null && "S".equals(tipoUsuarioLogado.getModuloAtendimento())) { %>
            <li class="menu-item module-separator">|</li>
            <li class="menu-item module-title">Atendimento</li>
            <li class="menu-item">
                <a class="menu-link <%= currentPage.contains("clientes.jsp") ? "active" : "" %>" 
                   href="<%= request.getContextPath() %>/home/app/atendimento/clientes.jsp">Clientes</a>
            </li>
            <li class="menu-item">
                <a class="menu-link <%= currentPage.contains("equipamentos.jsp") ? "active" : "" %>" 
                   href="<%= request.getContextPath() %>/home/app/atendimento/equipamentos.jsp">Equipamentos</a>
            </li>
            <li class="menu-item">
                <a class="menu-link <%= currentPage.contains("os.jsp") ? "active" : "" %>" 
                   href="<%= request.getContextPath() %>/home/app/os/os.jsp">Ordens de Serviço</a>
            </li>
        <% } %>

        <% if (tipoUsuarioLogado != null && "S".equals(tipoUsuarioLogado.getModuloTecnico())) { %>
            <li class="menu-item module-separator">|</li>
            <li class="menu-item module-title">Técnico</li>
            <li class="menu-item">
                <a class="menu-link <%= currentPage.contains("tecnicos.jsp") ? "active" : "" %>" 
                   href="<%= request.getContextPath() %>/home/app/tecnico/tecnicos.jsp">Técnicos</a>
            </li>
            <li class="menu-item">
                <a class="menu-link <%= currentPage.contains("os.jsp") ? "active" : "" %>" 
                   href="<%= request.getContextPath() %>/home/app/os/os.jsp">OS Técnicas</a>
            </li>
        <% } %>

        <li class="menu-item logout-container">
            <a class="menu-link logout-link" 
               href="<%= request.getContextPath() %>/home?task=logout">
                <span class="logout-icon">🚪</span>
                Logout <%= usuarioLogado != null ? "(" + usuarioLogado.getNome() + ")" : "" %>
            </a>
        </li>
    </ul>
</div>