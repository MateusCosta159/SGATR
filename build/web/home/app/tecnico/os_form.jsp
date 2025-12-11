<%@page import="model.OrdemServico"%>
<%@page import="model.Tecnico"%>
<%@page import="model.Equipamento"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/css/os.css">
    <title>Ordem de Serviço</title>
</head>
<body>

<%@ include file="/home/app/modulos.jsp" %>

<%
    OrdemServico os = null;
    ArrayList<Equipamento> equipamentosList = new Equipamento().getAllTableEntities();
    ArrayList<Tecnico> tecnicosList = new Tecnico().getAllTableEntities();

    String action = request.getParameter("action");
    if (action == null) action = "new";

    if ("edit".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        os = new OrdemServico();
        os.setId(id);
        os.load();
    } else {
        os = new OrdemServico(); // nova OS
    }
%>

<h1><%= (os.getId() > 0) ? "Editar Ordem de Serviço" : "Nova Ordem de Serviço" %></h1>

<form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=os" method="post">

    <!-- ID -->
    <label for="id">Id:</label>
    <input type="text" id="id" name="id" pattern="\d+" title="apenas dígitos"
           value="<%= (os.getId() > 0) ? os.getId() : "" %>"
           <%= (os.getId() > 0) ? "readonly" : "" %> required>
    <br/><br/>

    <!-- Equipamento -->
    <label for="equipamentoId">Equipamento:</label>
    <select id="equipamentoId" name="equipamentoId" required>
        <option value="">-- selecione --</option>
        <% for (Equipamento e : equipamentosList) { %>
            <option value="<%= e.getId() %>"
                    <%= (os.getId() > 0 && e.getId() == os.getEquipamentoId()) ? "selected" : "" %>>
                <%= e.getTipo() != null ? e.getTipo() : "Sem tipo" %> -
                <%= e.getMarca() != null ? e.getMarca() : "Sem marca" %> /
                ID:<%= e.getId() %>
            </option>
        <% } %>
    </select>
    <br/><br/>

    <!-- Técnico -->
    <label for="tecnicoId">Técnico:</label>
    <select id="tecnicoId" name="tecnicoId">
        <option value="">-- selecione --</option>
        <% for (Tecnico t : tecnicosList) { %>
            <option value="<%= t.getId() %>"
                    <%= (os.getId() > 0 && t.getId() == os.getTecnicoId()) ? "selected" : "" %>>
                <%= (t.getNome() != null) ? t.getNome() : "Técnico " + t.getId() %>
            </option>
        <% } %>
    </select>
    <br/><br/>

    <!-- Data -->
    <label for="dataAbertura">Data Abertura:</label>
    <input type="date" id="dataAbertura" name="dataAbertura"
           value="<%= (os.getDataAbertura() != null) ? os.getDataAbertura() : "" %>">
    <br/><br/>

    <!-- Status -->
    <label for="status">Status:</label>
    <select id="status" name="status" required>
        <option value="">-- selecione --</option>
        <option value="aberta" <%= "aberta".equals(os.getStatus()) ? "selected" : "" %>>Aberta</option>
        <option value="em_andamento" <%= "em_andamento".equals(os.getStatus()) ? "selected" : "" %>>Em Andamento</option>
        <option value="aguardando_pecas" <%= "aguardando_pecas".equals(os.getStatus()) ? "selected" : "" %>>Aguardando Peças</option>
        <option value="concluida" <%= "concluida".equals(os.getStatus()) ? "selected" : "" %>>Concluída</option>
        <option value="cancelada" <%= "cancelada".equals(os.getStatus()) ? "selected" : "" %>>Cancelada</option>
    </select>
    <br/><br/>

    <!-- Valores -->
    <label for="valorOrcamento">Valor Orçamento:</label>
    <input type="text" id="valorOrcamento" name="valorOrcamento"
           value="<%= (os.getValorOrcamento() != null) ? String.format("%.2f", os.getValorOrcamento()) : "" %>"
           pattern="^\\d+(\\.\\d{1,2})?$" title="Formato: 0.00 (até 2 casas decimais)">
    <br/><br/>

    <label for="valorFinal">Valor Final:</label>
    <input type="text" id="valorFinal" name="valorFinal"
           value="<%= (os.getValorFinal() != null) ? String.format("%.2f", os.getValorFinal()) : "" %>"
           pattern="^\\d+(\\.\\d{1,2})?$" title="Formato: 0.00 (até 2 casas decimais)">
    <br/><br/>

    <!-- Observações -->
    <label for="observacoes">Observações:</label><br/>
    <textarea id="observacoes" name="observacoes" rows="4" cols="50"
              maxlength="500"><%= (os.getObservacoes() != null) ? os.getObservacoes() : "" %></textarea>
    <br/><br/>

    <input type="submit" value="Salvar">
    <a href="<%= request.getContextPath() %>/home?task=os&action=list">Cancelar</a>
</form>

<script>
    // Máscara para valores monetários
    function formatMoneyInput(input) {
        let value = input.value.replace(/\D/g, '');
        if (value.length > 2) {
            value = value.replace(/(\d+)(\d{2})$/, '$1.$2');
        }
        input.value = value;
    }

    document.getElementById('valorOrcamento')?.addEventListener('input', e => formatMoneyInput(e.target));
    document.getElementById('valorFinal')?.addEventListener('input', e => formatMoneyInput(e.target));
</script>

</body>
</html>
