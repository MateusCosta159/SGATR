<%@page import="java.util.ArrayList"%>
<%@page import="model.OrdemServico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/app/css/os.css">

        <title>Ordens de Serviço</title>
    </head>
    <body>

        <%@ include file="/home/app/modulos.jsp" %>

        <%
            // Primeiro tenta pegar do atributo da requisição
            ArrayList<OrdemServico> dados = (ArrayList<OrdemServico>) request.getAttribute("lista");

            // Se não tiver, busca diretamente do modelo
            if (dados == null || dados.isEmpty()) {
                dados = new OrdemServico().getAllTableEntities();
            }
        %>

        <h1>Ordens de Serviço</h1>

        <a href="<%= request.getContextPath()%>/home/app/os/os_form.jsp?action=create">Nova OS</a><br/><br/>

        <table border="1" cellpadding="6" cellspacing="0">

            <tr>
                <th>ID</th>
                <th>Equipamento ID</th>
                <th>Técnico ID</th>
                <th>Data Abertura</th>
                <th>Status</th>
                <th>Valor Orçamento</th>
                <th>Valor Final</th>
                <th></th>
                <th></th>
            </tr>

            <%
                if (dados != null && !dados.isEmpty()) {
                    for (OrdemServico os : dados) {
            %>
            <tr>
                <td><%= os.getId()%></td>
                <td><%= os.getEquipamentoId()%></td>
                <td><%= os.getTecnicoId()%></td>
                <td><%= os.getDataAbertura() != null ? os.getDataAbertura() : "-"%></td>
                <td><%= os.getStatus() != null ? os.getStatus() : "-"%></td>
                <td>
                    <%= os.getValorOrcamento() != null && os.getValorOrcamento() != 0
                            ? "R$ " + String.format("%.2f", os.getValorOrcamento()) : "-"%>
                </td>
                <td>
                    <%= os.getValorFinal() != null && os.getValorFinal() != 0
                            ? "R$ " + String.format("%.2f", os.getValorFinal()) : "-"%>
                </td>

                <td>
                    <a href="<%= request.getContextPath()%>/home/app/os/os_form.jsp?action=update&id=<%= os.getId()%>">
                        Alterar
                    </a>
                </td>

                <td>
                    <a href="<%= request.getContextPath()%>/home?action=delete&id=<%= os.getId()%>&task=os" 
                       onclick="return confirm('Deseja realmente excluir OS <%= os.getId()%><%= os.getStatus() != null ? " (Status: " + os.getStatus() + ")" : ""%>?')">
                        Excluir
                    </a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="9" style="text-align: center;">Nenhuma ordem de serviço cadastrada</td>
            </tr>
            <% }%>

        </table>

    </body>
</html>