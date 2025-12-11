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
                   value="<%= (entity.getId() == 0) ? "" : entity.getId()%>" 
                   <%= (entity.getId() != 0) ? "readonly" : ""%> required><br/><br/>

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
                   pattern="\d{4}-\d{2}-\d{2}"
                   title="Formato: AAAA-MM-DD"
                   value="<%= (os != null && os.getDataAbertura() != null) ? os.getDataAbertura() : ""%>"><br/><br/>

            <label for="status">Status:</label>
            <select id="status" name="status" required>
                <option value="">-- selecione --</option>
                <option value="aberta" <%= (os != null && "aberta".equals(os.getStatus())) ? "selected" : "" %>>Aberta</option>
                <option value="em_andamento" <%= (os != null && "em_andamento".equals(os.getStatus())) ? "selected" : "" %>>Em Andamento</option>
                <option value="aguardando_pecas" <%= (os != null && "aguardando_pecas".equals(os.getStatus())) ? "selected" : "" %>>Aguardando Peças</option>
                <option value="concluida" <%= (os != null && "concluida".equals(os.getStatus())) ? "selected" : "" %>>Concluída</option>
                <option value="cancelada" <%= (os != null && "cancelada".equals(os.getStatus())) ? "selected" : "" %>>Cancelada</option>
            </select><br/><br/>

            <label for="valorOrcamento">Valor Orçamento:</label>
            <input type="text" id="valorOrcamento" name="valorOrcamento" 
                   pattern="^\d+(\.\d{1,2})?$"
                   title="Formato: 0.00 (até 2 casas decimais)"
                   value="<%= (os != null && os.getValorOrcamento() != null) ? String.format("%.2f", os.getValorOrcamento()) : ""%>"><br/><br/>

            <label for="valorFinal">Valor Final:</label>
            <input type="text" id="valorFinal" name="valorFinal" 
                   pattern="^\d+(\.\d{1,2})?$"
                   title="Formato: 0.00 (até 2 casas decimais)"
                   value="<%= (os != null && os.getValorFinal() != null) ? String.format("%.2f", os.getValorFinal()) : ""%>"><br/><br/>

            <label for="observacoes">Observações:</label><br/>
            <textarea id="observacoes" name="observacoes" rows="4" cols="50"
                      maxlength="500"
                      title="Máximo 500 caracteres"><%= (os != null && os.getObservacoes() != null) ? os.getObservacoes() : ""%></textarea><br/><br/>

            <input type="submit" name="Salvar" value="Salvar"> 
            <a href="<%= request.getContextPath() %>/home?task=os&action=list">Cancelar</a>
        </form>

        <script>
            // Máscara para valores monetários
            document.getElementById('valorOrcamento')?.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 2) {
                    value = value.replace(/(\d+)(\d{2})$/, '$1.$2');
                }
                e.target.value = value;
            });

            document.getElementById('valorFinal')?.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 2) {
                    value = value.replace(/(\d+)(\d{2})$/, '$1.$2');
                }
                e.target.value = value;
            });
        </script>

    </body>
</html>