<%@page import="model.Cliente"%>
<%@ include file="/home/app/modulos.jsp" %>

<%
    Cliente c = null;
    String action = request.getParameter("action");

    if ("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        c = new Cliente();
        c.setId(id);
        c.load();
    }
%>

<h1>Cliente</h1>

<form action="<%=request.getContextPath()%>/home?task=clientes&action=<%=action%>" method="post">

    <label>ID:</label>
    <input type="text" name="id" value="<%=c != null ? c.getId() : ""%>"
           <%= c != null ? "readonly" : "" %> required><br><br>

    <label>Nome:</label>
    <input type="text" name="nome" value="<%=c != null ? c.getNome() : ""%>" required><br><br>

    <label>Telefone:</label>
    <input type="text" name="telefone" value="<%=c != null ? c.getTelefone() : ""%>" required><br><br>

    <label>Email:</label>
    <input type="email" name="email" value="<%=c != null ? c.getEmail() : ""%>" required><br><br>

    <label>CPF:</label>
    <input type="text" name="cpf" value="<%=c != null ? c.getCpf() : ""%>" required><br><br>

    <label>Endereço:</label>
    <input type="text" name="endereco" value="<%=c != null ? c.getEndereco() : ""%>" required><br><br>

    <input type="submit" value="Salvar">

</form>
