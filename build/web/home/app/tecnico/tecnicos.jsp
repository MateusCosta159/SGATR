<%@page import="java.util.ArrayList"%>
<%@page import="model.Tecnico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Técnicos</title>
    </head>
    <body>
        
        <%@ include file="/home/app/modulos.jsp" %>
        
        <%
            // Primeiro tenta pegar do atributo da requisição
            ArrayList<Tecnico> dados = (ArrayList<Tecnico>) request.getAttribute("lista");
            
            // Se não tiver, busca diretamente do modelo
            if (dados == null || dados.isEmpty()) {
                dados = new Tecnico().getAllTableEntities();
            }
        %>
        
        <h1>Técnicos</h1>
        
        <a href="<%= request.getContextPath()  %>/home/app/tecnico/tecnicos_form.jsp?action=create">Novo Técnico</a><br/><br/>
        
        <table border="1" cellpadding="6" cellspacing="0">
            
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Especialidade</th>
                <th>Telefone</th>
                <th></th>
                <th></th>
            </tr>
            
            <% 
            if (dados != null && !dados.isEmpty()) {
                for( Tecnico t : dados ) { 
            %>
            <tr>
                <td><%= t.getId() %></td>
                <td><%= t.getNome() != null ? t.getNome() : "-" %></td>
                <td><%= t.getEspecialidade() != null ? t.getEspecialidade() : "-" %></td>
                <td><%= t.getTelefone() != null ? t.getTelefone() : "-" %></td>
                
                <td>
                    <a href="<%= request.getContextPath() %>/home/app/tecnico/tecnicos_form.jsp?action=update&id=<%= t.getId()%>">
                        Alterar
                    </a>
                </td>
                
                <td>
                    <a href="<%= request.getContextPath() %>/home?action=delete&id=<%= t.getId()%>&task=tecnicos" 
                       onclick="return confirm('Deseja realmente excluir Técnico <%= t.getId()%>' + 
                                               '<%= t.getNome() != null ? " (" + t.getNome() + ")" : "" %>' + 
                                               '?')">
                        Excluir
                    </a>
                </td>
            </tr>
            <% 
                }
            } else { 
            %>
            <tr>
                <td colspan="6" style="text-align: center;">Nenhum técnico cadastrado</td>
            </tr>
            <% } %>
            
        </table>
        
    </body>
</html>