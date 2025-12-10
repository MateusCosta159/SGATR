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

            // Verifica se já existe uma entidade nos atributos da requisição
            OrdemServico entity = (OrdemServico) request.getAttribute("entity");
            if (entity == null) {
                entity = os != null ? os : new OrdemServico();
            }

            // Carrega lista de equipamentos
            equipamentosList = (ArrayList<Equipamento>) request.getAttribute("equipamentosList");
            if (equipamentosList == null || equipamentosList.isEmpty()) {
                equipamentosList = new Equipamento().getAllTableEntities();
            }

            // Carrega lista de técnicos
            tecnicosList = (ArrayList<Tecnico>) request.getAttribute("tecnicosList");
            if (tecnicosList == null || tecnicosList.isEmpty()) {
                tecnicosList = new Tecnico().getAllTableEntities();
            }
        %>

        <h1><%= entity.getId() == 0 ? "Nova Ordem de Serviço" : "Editar Ordem de Serviço" %></h1>

        <form action="<%= request.getContextPath()%>/home?action=save&task=os" method="post">

            <label for="id">Id:</label>
            <input type="text" id="id" name="id" pattern="\d+" title="apenas dígitos" 
                   value="<%= entity.getId() %>" 
                   <%= (entity.getId() != 0) ? "readonly" : "" %> required><br/><br/>

            <label for="equipamentoId">Equipamento:</label>
            <select id="equipamentoId" name="equipamentoId" required>
                <option value="">-- selecione --</option>
                <% if (equipamentosList != null && !equipamentosList.isEmpty()) {
                    for (Equipamento e : equipamentosList) { %>
                <option value="<%= e.getId() %>"
                    <%= (e.getId() == entity.getEquipamentoId()) ? "selected" : "" %>>
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
                    <%= (t.getId() == entity.getTecnicoId()) ? "selected" : "" %>>
                    <%= (t.getNome() != null) ? t.getNome() : "Técnico " + t.getId() %>
                </option>
                <%   }
                   } %>
            </select><br/><br/>

            <label for="dataAbertura">Data Abertura:</label>
            <input type="text" id="dataAbertura" name="dataAbertura" 
                   value="<%= (entity.getDataAbertura() != null) ? entity.getDataAbertura() : "" %>"
                   pattern="\d{2}/\d{2}/\d{4}" title="DD/MM/AAAA" placeholder="DD/MM/AAAA"><br/><br/>

            <label for="status">Status:</label>
            <input type="text" id="status" name="status" 
                   value="<%= (entity.getStatus() != null) ? entity.getStatus() : "" %>"><br/><br/>

            <label for="valorOrcamento">Valor Orçamento:</label>
            <input type="text" id="valorOrcamento" name="valorOrcamento" 
                   value="<%= (entity.getValorOrcamento() != null && entity.getValorOrcamento() != 0) ? 
                           String.format("%.2f", entity.getValorOrcamento()) : "" %>"
                   pattern="\d+(\.\d{2})?" title="Formato: 999.99"><br/><br/>

            <label for="valorFinal">Valor Final:</label>
            <input type="text" id="valorFinal" name="valorFinal" 
                   value="<%= (entity.getValorFinal() != null && entity.getValorFinal() != 0) ? 
                           String.format("%.2f", entity.getValorFinal()) : "" %>"
                   pattern="\d+(\.\d{2})?" title="Formato: 999.99"><br/><br/>

            <label for="observacoes">Observações:</label><br/>
            <textarea id="observacoes" name="observacoes" rows="4" cols="50">
                <%= (entity.getObservacoes() != null) ? entity.getObservacoes() : "" %>
            </textarea><br/><br/>

            <input type="submit" name="Salvar" value="Salvar"> 
            <a href="<%= request.getContextPath() %>/home?task=os&action=list">Cancelar</a>
        </form>

    </body>
</html>