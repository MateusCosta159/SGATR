<%@page import="java.util.ArrayList"%>
<%@page import="model.Equipamento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Equipamentos</title>
    </head>
    <body>
        
        <%@ include file="/home/app/modulos.jsp" %>
        
        <%
            
            ArrayList<Equipamento> dados = (ArrayList<Equipamento>) request.getAttribute("lista");
            
            // Se não tiver, busca diretamente do modelo
            if (dados == null || dados.isEmpty()) {
                dados = new Equipamento().getAllTableEntities();
            }
        %>
        
        <h1>Equipamentos</h1>
        
        <a href="<%= request.getContextPath()  %>/home/app/atendimento/equipamentos_form.jsp?action=create">Novo Equipamento</a><br/><br/>
        
        <table border="1" cellpadding="6" cellspacing="0">
            
            <tr>
                <th>ID</th>
                <th>Cliente ID</th>
                <th>Tipo</th>
                <th>Marca</th>
                <th>Modelo</th>
                <th>Defeito Relatado</th>
                <th></th>
                <th></th>
            </tr>
            
            <% 
            if (dados != null && !dados.isEmpty()) {
                for( Equipamento eq : dados ) { 
            %>
            <tr>
                <td><%= eq.getId() %></td>
                <td><%= eq.getClienteId() %></td>
                <td><%= eq.getTipo() != null ? eq.getTipo() : "-" %></td>
                <td><%= eq.getMarca() != null ? eq.getMarca() : "-" %></td>
                <td><%= eq.getModelo() != null ? eq.getModelo() : "-" %></td>
                <td>
                    <%= eq.getDefeitoRelatado() != null ? 
                        (eq.getDefeitoRelatado().length() > 30 ? 
                         eq.getDefeitoRelatado().substring(0, 30) + "..." : 
                         eq.getDefeitoRelatado()) : 
                        "-" %>
                </td>
                
                <td>
                    <a href="<%= request.getContextPath() %>/home/app/atendimento/equipamentos_form.jsp?action=update&id=<%= eq.getId()%>">
                        Alterar
                    </a>
                </td>
                
                <td>
                    <a href="<%= request.getContextPath() %>/home?action=delete&id=<%= eq.getId()%>&task=equipamentos" 
                       onclick="return confirm('Deseja realmente excluir Equipamento <%= eq.getId()%> (<%= eq.getTipo() != null ? eq.getTipo() : "Sem tipo" %>) ?')">
                        Excluir
                    </a>
                </td>
            </tr>
            <% 
                }
            } else { 
            %>
            <tr>
                <td colspan="8" style="text-align: center;">Nenhum equipamento cadastrado</td>
            </tr>
            <% } %>
            
        </table>
        
    </body>
</html>