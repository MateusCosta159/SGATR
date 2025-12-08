<%@page import="model.Equipamento"%>
<%@page import="model.Cliente"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/home/app/modulos.jsp" %>

<h1>Equipamentos</h1>

<%
    ArrayList<Equipamento> lista = new Equipamento().getAllTableEntities();
%>

<table border="1">
<tr>
    <th>ID</th>
    <th>Cliente</th>
    <th>Tipo</th>
    <th>Marca</th>
    <th>Modelo</th>
    <th>Defeito</th>
    <th></th>
    <th></th>
</tr>

<% for (Equipamento e : lista) { %>
<tr>
    <td><%= e.getId() %></td>
    <td><%= e.getClienteId() %></td>
    <td><%= e.getTipo() %></td>
    <td><%= e.getMarca() %></td>
    <td><%= e.getModelo() %></td>
    <td><%= e.getDefeitoRelatado() %></td>

    <td><a href="equipamentos_form.jsp?action=update&id=<%= e.getId() %>">Alterar</a></td>

    <td>
        <a href="<%=request.getContextPath()%>/home?task=equipamentos&action=delete&id=<%= e.getId() %>"
           onclick="return confirm('Excluir equipamento?');">Excluir</a>
    </td>
</tr>
<% } %>

</table>

<br>
<a href="equipamentos_form.jsp?action=create">Adicionar Equipamento</a>
