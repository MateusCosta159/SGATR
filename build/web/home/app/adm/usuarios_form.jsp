<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Usuário</title>
</head>
<body>

<%
    int id = 0;
    String nome = "";
    int tipoUsuarioId = 1;
    String senha = "";

    boolean editando = false;

    if (request.getParameter("id") != null) {

        id = Integer.parseInt(request.getParameter("id"));

        Usuario u = new Usuario();
        u.setId(id);

        if (u.load()) {
            editando = true;
            nome = u.getNome();
            tipoUsuarioId = u.getTipoUsuarioId();
        }
    }
%>

<h1><%= editando ? "Editar Usuário" : "Criar Usuário" %></h1>

<form action="<%= request.getContextPath() %>/home?task=usuarios" method="post">

    <input type="hidden" name="action" value="<%= editando ? "update" : "insert" %>">

 
    ID:
    <% if (!editando) { %>
        <input type="number" name="id" value="<%= id %>" required><br><br>
    <% } else { %>
        <!-- ID aparece travado durante edição -->
        <input type="number" name="id" value="<%= id %>" readonly><br><br>
    <% } %>

    Nome:
    <input type="text" name="nome" value="<%= nome %>" required><br><br>

    Senha:
    <input type="password" name="senha" required><br><br>

    Tipo Usuário (ID):
    <input type="number" name="tipo_usuario_id" value="<%= tipoUsuarioId %>" required><br><br>

    <input type="submit" value="Salvar">

</form>

<br>
<a href="usuarios.jsp">Voltar</a>

</body>
</html>
