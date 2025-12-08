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
    int tipoUsuarioId = 1; // valor padrão
    String senha = "";

    if (request.getParameter("id") != null) {

        id = Integer.parseInt(request.getParameter("id"));

        Usuario u = new Usuario();
        u.setId(id);

        if (u.load()) {
            nome = u.getNome();
            tipoUsuarioId = u.getTipoUsuarioId();
            // senha não é carregada, permanece vazia
        }
    }
%>

<h1><%= id == 0 ? "Criar Usuário" : "Editar Usuário" %></h1>

<form action="<%= request.getContextPath() %>/home?task=usuarios" method="post">

    <input type="hidden" name="action" value="<%= id == 0 ? "insert" : "update" %>">
    <input type="hidden" name="id" value="<%= id %>">

    Nome:
    <input type="text" name="nome" value="<%= nome %>" required><br><br>

    Senha:
    <input type="password" name="senha" value="" required><br><br>

    Tipo Usuário (ID):
    <input type="number" name="tipo_usuario_id" value="<%= tipoUsuarioId %>" required><br><br>

    <input type="submit" value="Salvar">

</form>

<br>
<a href="usuarios.jsp">Voltar</a>

</body>
</html>
