<%@page import="model.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Usuários</title>
</head>
<body>

    <%@ include file="/home/app/modulos.jsp" %>

    <% ArrayList<Usuario> dados = new Usuario().getAllTableEntities(); %>

    <h1>Usuários do Sistema</h1>

    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Tipo Usuário</th>
            <th colspan="2">Ações</th>
        </tr>

        <% for (Usuario us : dados) { %>
        <tr>
            <td><%= us.getId() %></td>
            <td><%= us.getNome() %></td>
            <td><%= us.getTipoUsuarioId() %></td>

            <td><a href="<%= request.getContextPath() %>/home/app/adm/usuarios_form.jsp?action=update&id=<%= us.getId() %>">Alterar</a></td>

            <td>
                <a href="<%= request.getContextPath() %>/home?action=delete&id=<%= us.getId() %>&task=usuarios"
                   onclick="return confirm('Deseja realmente excluir o usuário <%= us.getNome() %>?')">
                   Excluir
                </a>
            </td>
        </tr>
        <% } %>
    </table>

    <br>
    <a href="<%= request.getContextPath() %>/home/app/adm/usuarios_form.jsp?action=create">Adicionar Usuário</a>

</body>
</html>
