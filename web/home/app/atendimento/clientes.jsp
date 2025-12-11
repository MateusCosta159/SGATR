<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/css/clientes.css">

        <title>Clientes</title>
    </head>
    <body>
        
        <%@ include file="/home/app/modulos.jsp" %>
        
        <%
            // Primeiro tenta pegar do atributo da requisição
            ArrayList<Cliente> dados = (ArrayList<Cliente>) request.getAttribute("lista");
            
            // Se não tiver, busca diretamente do modelo (como na primeira versão)
            if (dados == null || dados.isEmpty()) {
                dados = new Cliente().getAllTableEntities();
            }
        %>
        
        <h1>Clientes</h1>
        
       
        
        <table border="1" cellpadding="6" cellspacing="0">
            
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
            
            <% 
            if (dados != null && !dados.isEmpty()) {
                for( Cliente cl : dados ) { 
            %>
            <tr>
                <td><%= cl.getId() %></td>
                <td><%= cl.getNome() != null ? cl.getNome() : "-" %></td>
                <td><%= cl.getTelefone() != null ? cl.getTelefone() : "-" %></td>
                <td><%= cl.getEmail() != null ? cl.getEmail() : "-" %></td>
                <td><%= cl.getCpf() != null ? cl.getCpf() : "-" %></td>
                <td><%= cl.getEndereco() != null ? cl.getEndereco() : "-" %></td>
                
                <td>
                    <a href="<%= request.getContextPath() %>/home/app/atendimento/clientes_form.jsp?action=update&id=<%= cl.getId()%>">
                        Alterar
                    </a>
                </td>
                
                <td>
                    <a href="<%= request.getContextPath() %>/home?action=delete&id=<%= cl.getId()%>&task=clientes" 
                       onclick="return confirm('Deseja realmente excluir Cliente <%= cl.getId()%> (<%= cl.getNome() != null ? cl.getNome() : "Sem nome" %>) ?')">
                        Excluir
                    </a>
                </td>
            </tr>
            <% 
                }
            } else { 
            %>
            <tr>
                <td colspan="8" style="text-align: center;">Nenhum cliente cadastrado</td>
            </tr>
            <% } %>
            
        </table>
         <a href="<%= request.getContextPath()  %>/home/app/atendimento/clientes_form.jsp?action=create">Novo Cliente</a><br/><br/>
    </body>
</html>