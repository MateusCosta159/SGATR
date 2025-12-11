<%@page import="model.Usuario"%>
<%@page import="model.TipoUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession s = request.getSession(false);
    
    Usuario usuarioLogado = (Usuario) s.getAttribute("usuario");
    TipoUsuario tipoUsuarioLogado = (TipoUsuario) s.getAttribute("tipo_usuario");
    
    String currentPath = request.getRequestURI();
    String currentPage = currentPath.substring(currentPath.lastIndexOf("/") + 1);
%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/css/menu.css">
<ul>
    
    <li><a href="<%= request.getContextPath() %>/home/app/menu.jsp">Menu</a></li>

    <% if ("S".equals(tipoUsuarioLogado.getModuloAdmin())) { %>
        <li><a href="<%= request.getContextPath() %>/home/app/adm/tipousuario.jsp">Tipo Usuário</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/adm/usuarios.jsp">Usuários</a></li>
         <li><a href="<%= request.getContextPath() %>/home/app/adm/tecnicos.jsp">Técnicos</a></li>
      
    <% } %>

    <% if ("S".equals(tipoUsuarioLogado.getModuloAtendimento())) { %>
        <li><a href="<%= request.getContextPath() %>/home/app/atendimento/clientes.jsp">Clientes</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/atendimento/equipamentos.jsp">Equipamentos</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/tecnico/os.jsp">Ordens de Serviço</a></li>
    <% } %>

    <% if ("S".equals(tipoUsuarioLogado.getModuloTecnico())) { %>
       
        <li><a href="<%= request.getContextPath() %>/home/app/tecnico/os.jsp">OS Técnicas</a></li>
        <li><a href="<%= request.getContextPath() %>/home/app/atendimento/equipamentos.jsp">Equipamentos p/Tecnico</a></li>
    <% } %>

    <li>
        <a href="<%= request.getContextPath() %>/home?task=logout">
            Logout <%= usuarioLogado != null ? usuarioLogado.getNome() : "" %>
        </a>
    </li>
</ul>