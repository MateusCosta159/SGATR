<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/app/css/clientes.css">
        <title>Cliente</title>
    </head>
    <body>

        <%@ include file="/home/app/modulos.jsp" %>

        <%
            Cliente cl = null;

            String action = request.getParameter("action");
            if (action == null) {
                action = "create";
            } else {
                if (action.equals("update")) {
                    int id = Integer.valueOf(request.getParameter("id"));
                    cl = new Cliente();
                    cl.setId(id);
                    cl.load();
                }
            }

            Cliente entity = (Cliente) request.getAttribute("entity");
            if (entity == null) {
                entity = cl != null ? cl : new Cliente();
            }
        %>

        <h1><%= entity.getId() == 0 ? "Novo Cliente" : "Editar Cliente" %></h1>

        <!-- CORREÇÃO AQUI: usar action dinâmica como no Convênio -->
        <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=clientes" method="post">

            <label for="id">Id:</label>
            <input type="text" id="id" name="id" pattern="\d+" title="apenas dígitos" 
                   value="<%= entity.getId() %>" 
                   <%= (entity.getId() != 0) ? "readonly" : "" %> required><br/><br/>

            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" 
                   value="<%= (entity.getNome() != null) ? entity.getNome() : "" %>" required><br/><br/>

            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" 
                   value="<%= (entity.getTelefone() != null) ? entity.getTelefone() : "" %>"><br/><br/>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" 
                   value="<%= (entity.getEmail() != null) ? entity.getEmail() : "" %>"><br/><br/>

            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" 
                   value="<%= (entity.getCpf() != null) ? entity.getCpf() : "" %>"><br/><br/>

            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" 
                   value="<%= (entity.getEndereco() != null) ? entity.getEndereco() : "" %>"><br/><br/>

            <input type="submit" name="Salvar" value="Salvar"> 
            <a href="<%= request.getContextPath() %>/home?task=clientes&action=list">Cancelar</a>
        </form>

    </body>
</html>