<%@page import="model.Usuario"%>
<%@page import="model.TipoUsuario"%>

<%
    HttpSession s = request.getSession(false);

    Usuario usuarioLogado = null;
    TipoUsuario tipoUsuarioLogado = null;

    if (s != null) {
        usuarioLogado = (Usuario) s.getAttribute("usuario");
        tipoUsuarioLogado = (TipoUsuario) s.getAttribute("tipo_usuario");
    }
%>

<ul>
    <li><a href="<%= request.getContextPath() %>/home/app/menu.jsp">Menu</a></li>

    <% if (tipoUsuarioLogado != null && "S".equals(tipoUsuarioLogado.getModuloAdmin())) { %>
        <li><a href="<%= request.getContextPath() %>/home/app/adm/tipousuario.jsp">Tipo Usuário</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/adm/usuarios.jsp">Usuários</a></li>
    <% } %>

    <% if (tipoUsuarioLogado != null && "S".equals(tipoUsuarioLogado.getModuloAtendimento())) { %>
        <li><a href="<%= request.getContextPath() %>/home/app/atendimento/clientes.jsp">Clientes</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/atendimento/equipamentos.jsp">Equipamentos</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/os/os.jsp">Ordens de Serviço</a></li>
    <% } %>

    <% if (tipoUsuarioLogado != null && "S".equals(tipoUsuarioLogado.getModuloTecnico())) { %>
        <li><a href="<%= request.getContextPath() %>/home/app/tecnicos/tecnicos.jsp">Técnicos</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/os/os.jsp">OS Técnicas</a></li>
    <% } %>

    <li>
        <a href="<%= request.getContextPath() %>/home?task=logout">
            Logout <%= usuarioLogado != null ? usuarioLogado.getNome() : "" %>
        </a>
    </li>
</ul>
