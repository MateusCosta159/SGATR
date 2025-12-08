<%@page import="model.Cliente"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/home/app/modulos.jsp" %>

<h1>Clientes</h1>

<%
    ArrayList<Cliente> lista = new Cliente().getAllTableEntities();
%>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Telefone</th>
        <th>Email</th>
        <th>CPF</th>
        <th>Endereço</th>
        <th></th>
        <th></th>
    </tr>

    <% for (Cliente c : lista) { %>
    <tr>
        <td><%= c.getId() %></td>
        <td><%= c.getNome() %></td>
        <td><%= c.getTelefone() %></td>
        <td><%= c.getEmail() %></td>
        <td><%= c.getCpf() %></td>
        <td><%= c.getEndereco() %></td>

        <td>
            <a href="<%=request.getContextPath()%>/home/app/atendimento/clientes_form.jsp?action=update&id=<%=c.getId()%>">
                Alterar
            </a>
        </td>

        <td>
            <a href="<%=request.getContextPath()%>/home?task=clientes&action=delete&id=<%=c.getId()%>"
               onclick="return confirm('Excluir cliente <%=c.getNome()%>?');">
               Excluir
            </a>
        </td>
    </tr>
    <% } %>
</table>

<br>
<a href="<%=request.getContextPath()%>/home/app/atendimento/clientes_form.jsp?action=create">
    Adicionar Cliente
</a>
