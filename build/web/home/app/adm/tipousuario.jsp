<%@page import="model.TipoUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tipo de Usuário</title>

    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; padding: 6px; }
    </style>
</head>
<body>

    <%@ include file="/home/app/modulos.jsp" %>

    <%
        ArrayList<TipoUsuario> dados = new TipoUsuario().getAllTableEntities();
    %>

    <h1>Tipos de Usuário</h1>

    <table>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Administrativo</th>
            <th>Técnico</th>
            <th>Atendimento</th>
            <th>Alterar</th>
            <th>Excluir</th>
        </tr>

        <% for (TipoUsuario tp : dados) { %>

        <tr>
            <td><%= tp.getId() %></td>
            <td><%= tp.getNome() %></td>

            <!-- Converte S/N para Sim/Não -->
            <td><%= tp.getModuloAdmin().equals("S") ? "Sim" : "Não" %></td>
            <td><%= tp.getModuloAtendimento().equals("S") ? "Sim" : "Não" %></td>
            <td><%= tp.getModuloTecnico().equals("S") ? "Sim" : "Não" %></td>
           

            <!-- LINK ALTERAR -->
            <td>
                <a href="<%= request.getContextPath() %>/home/app/adm/tipousuario_form.jsp?action=update&id=<%= tp.getId() %>">
                    Alterar
                </a>
            </td>

            <!-- LINK EXCLUIR -->
            <td>
                <a href="<%= request.getContextPath() %>/home?task=tipousuario&action=delete&id=<%= tp.getId() %>" 
                   onclick="return confirm('Deseja realmente excluir o Tipo de Usuário <%= tp.getNome() %>?');">
                    Excluir
                </a>
            </td>
        </tr>

        <% } %>

    </table>

    <br>

    <a href="<%= request.getContextPath() %>/home/app/adm/tipousuario_form.jsp?action=create">
        Adicionar Novo Tipo de Usuário
    </a>

</body>
</html>
