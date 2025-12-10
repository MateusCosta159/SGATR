<%@page import="model.OrdemServico"%>
<%@page import="model.Tecnico"%>
<%@page import="model.Equipamento"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ordem de Serviço</title>
    </head>
    <body>

        <%@ include file="/home/app/modulos.jsp" %>

        <%
            OrdemServico os = null;
            ArrayList<Equipamento> equipamentosList = null;
            ArrayList<Tecnico> tecnicosList = null;

            String action = request.getParameter("action");
            if (action == null) {
                action = "create";
            } else {
                if (action.equals("update")) {
                    int id = Integer.valueOf(request.getParameter("id"));

                    os = new OrdemServico();
                    os.setId(id);
                    os.load();
                }
            }

            // Carrega lista de equipamentos
            equipamentosList = new Equipamento().getAllTableEntities();

            // Carrega lista de técnicos
            tecnicosList = new Tecnico().getAllTableEntities();
        %>
        
        <h1><%= (os != null && os.getId() > 0) ? "Editar Ordem de Serviço" : "Nova Ordem de Serviço" %></h1>

        <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=os" method="post">

            <label for="id">Id:</label>
            <input type="text" id="id" name="id" pattern="\d+" title="apenas dígitos" 
                   value="<%= (os != null) ? os.getId() : ""%>" 
                   <%= (os != null && os.getId() > 0) ? "readonly" : ""%> required><br/><br/>

            <label for="equipamentoId">Equipamento:</label>
            <select id="equipamentoId" name="equipamentoId" required>
                <option value="">-- selecione --</option>
                <% if (equipamentosList != null && !equipamentosList.isEmpty()) {
                    for (Equipamento e : equipamentosList) { %>
                <option value="<%= e.getId() %>"
                    <%= (os != null && e.getId() == os.getEquipamentoId()) ? "selected" : "" %>>
                    <%= (e.getTipo() != null ? e.getTipo() : "Sem tipo") %> - 
                    <%= (e.getMarca() != null ? e.getMarca() : "Sem marca") %> / 
                    ID:<%= e.getId() %>
                </option>
                <%   }
                   } %>
            </select><br/><br/>

            <label for="tecnicoId">Técnico:</label>
            <select id="tecnicoId" name="tecnicoId">
                <option value="">-- selecione --</option>
                <% if (tecnicosList != null && !tecnicosList.isEmpty()) {
                    for (Tecnico t : tecnicosList) { %>
                <option value="<%= t.getId() %>"
                    <%= (os != null && t.getId() == os.getTecnicoId()) ? "selected" : "" %>>
                    <%= (t.getNome() != null) ? t.getNome() : "Técnico " + t.getId() %>
                </option>
                <%   }
                   } %>
            </select><br/><br/>

            <label for="dataAbertura">Data Abertura:</label>
            <input type="date" id="dataAbertura" name="dataAbertura" 
                   value="<%= (os != null && os.getDataAbertura() != null) ? os.getDataAbertura() : ""%>"><br/><br/>

            <label for="status">Status:</label>
            <input type="text" id="status" name="status" 
                   value="<%= (os != null && os.getStatus() != null) ? os.getStatus() : ""%>"><br/><br/>

            <label for="valorOrcamento">Valor Orçamento:</label>
            <input type="text" id="valorOrcamento" name="valorOrcamento" 
                   value="<%= (os != null && os.getValorOrcamento() != null) ? String.format("%.2f", os.getValorOrcamento()) : ""%>"><br/><br/>

            <label for="valorFinal">Valor Final:</label>
            <input type="text" id="valorFinal" name="valorFinal" 
                   value="<%= (os != null && os.getValorFinal() != null) ? String.format("%.2f", os.getValorFinal()) : ""%>"><br/><br/>

            <label for="observacoes">Observações:</label><br/>
            <textarea id="observacoes" name="observacoes" rows="4" cols="50"><%= (os != null && os.getObservacoes() != null) ? os.getObservacoes() : ""%></textarea><br/><br/>

            <input type="submit" name="Salvar" value="Salvar"> 
            <a href="<%= request.getContextPath() %>/home?task=os&action=list">Cancelar</a>
        </form>

    </body>
</html>