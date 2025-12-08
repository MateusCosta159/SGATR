<%@page import="model.Equipamento"%>
<%@page import="model.Cliente"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/home/app/modulos.jsp" %>

<%
    Equipamento e = null;
    String action = request.getParameter("action");

    if ("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        e = new Equipamento();
        e.setId(id);
        e.load();
    }

    ArrayList<Cliente> clientes = new Cliente().getAllTableEntities();
%>

<h1>Equipamento</h1>

<form action="<%=request.getContextPath()%>/home?task=equipamentos&action=<%=action%>" method="post">

    <label>ID:</label>
    <input type="text" name="id" value="<%=e != null ? e.getId() : ""%>"
           <%=e != null ? "readonly" : ""%> required><br>

    <label>Cliente:</label>
    <select name="cliente_id">
        <% for (Cliente c : clientes) { %>
            <option value="<%=c.getId()%>" <%= (e != null && e.getClienteId() == c.getId()) ? "selected" : "" %>>
                <%= c.getNome() %>
            </option>
        <% } %>
    </select><br>

    <label>Tipo:</label>
    <input type="text" name="tipo" value="<%=e != null ? e.getTipo() : ""%>"><br>

    <label>Marca:</label>
    <input type="text" name="marca" value="<%=e != null ? e.getMarca() : ""%>"><br>

    <label>Modelo:</label>
    <input type="text" name="modelo" value="<%=e != null ? e.getModelo() : ""%>"><br>

    <label>Defeito relatado:</label>
    <input type="text" name="defeito_relatado" value="<%=e != null ? e.getDefeitoRelatado() : ""%>"><br>

    <input type="submit" value="Salvar">

</form>
