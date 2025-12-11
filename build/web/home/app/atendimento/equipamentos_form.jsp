<%@page import="model.Equipamento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/css/equipamentos.css">

        <title>Equipamento</title>
    </head>
    <body>

        <%@ include file="/home/app/modulos.jsp" %>

        <%
            Equipamento eq = null;
            ArrayList<Cliente> clientesList = null;

            String action = request.getParameter("action");
            if (action == null) {
                action = "create";
            } else {
                if (action.equals("update")) {
                    int id = Integer.valueOf(request.getParameter("id"));

                    eq = new Equipamento();
                    eq.setId(id);
                    eq.load();
                }
            }

            // Verifica se já existe uma entidade nos atributos da requisição
            Equipamento entity = (Equipamento) request.getAttribute("entity");
            if (entity == null) {
                entity = eq != null ? eq : new Equipamento();
            }

            // Carrega lista de clientes
            clientesList = (ArrayList<Cliente>) request.getAttribute("clientesList");
            if (clientesList == null || clientesList.isEmpty()) {
                
                clientesList = new Cliente().getAllTableEntities();
            }
        %>

        <h1><%= entity.getId() == 0 ? "Novo Equipamento" : "Editar Equipamento" %></h1>

        <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=equipamentos" method="post">

            <label for="id">Id:</label>
            <input type="text" id="id" name="id" pattern="\d+" title="apenas dígitos" 
                   value="<%= (entity.getId() == 0) ? "" : entity.getId()%>" 
                   <%= (entity.getId() != 0) ? "readonly" : ""%> required><br/><br/>

            <label for="clienteId">Cliente:</label>
            <select id="clienteId" name="clienteId" required>
                <option value="">-- selecione --</option>
                <% if (clientesList != null && !clientesList.isEmpty()) {
                    for (Cliente c : clientesList) { %>
                <option value="<%= c.getId() %>"
                    <%= (c.getId() == entity.getClienteId()) ? "selected" : "" %>>
                    <%= (c.getNome() != null) ? c.getNome() : "Cliente " + c.getId() %>
                </option>
                <%   }
                   } %>
            </select><br/><br/>

            <label for="tipo">Tipo:</label>
            <input type="text" id="tipo" name="tipo" 
                   value="<%= (entity.getTipo() != null) ? entity.getTipo() : "" %>" required><br/><br/>

            <label for="marca">Marca:</label>
            <input type="text" id="marca" name="marca" 
                   value="<%= (entity.getMarca() != null) ? entity.getMarca() : "" %>"><br/><br/>

            <label for="modelo">Modelo:</label>
            <input type="text" id="modelo" name="modelo" 
                   value="<%= (entity.getModelo() != null) ? entity.getModelo() : "" %>"><br/><br/>

            <label for="defeitoRelatado">Defeito Relatado:</label><br/>
            <textarea id="defeitoRelatado" name="defeitoRelatado" rows="4" cols="50">
                <%= (entity.getDefeitoRelatado() != null) ? entity.getDefeitoRelatado() : "" %>
            </textarea><br/><br/>

            <input type="submit" name="Salvar" value="Salvar"> 
            <a href="<%= request.getContextPath() %>/home?task=equipamentos&action=list">Cancelar</a>
        </form>

    </body>
</html>