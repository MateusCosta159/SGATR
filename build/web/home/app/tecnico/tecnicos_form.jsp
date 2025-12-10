<%@page import="model.Tecnico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/app/css/tecnicos.css">

        <title>Técnico</title>
    </head>
    <body>

        <%@ include file="/home/app/modulos.jsp" %>

        <%
            Tecnico tec = null;

            String action = request.getParameter("action");
            if (action == null) {
                action = "create";
            } else {
                if (action.equals("update")) {
                    int id = Integer.valueOf(request.getParameter("id"));

                    tec = new Tecnico();
                    tec.setId(id);
                    tec.load();
                }
            }

            
            Tecnico entity = (Tecnico) request.getAttribute("entity");
            if (entity == null) {
                entity = tec != null ? tec : new Tecnico();
            }
        %>

        <h1><%= entity.getId() == 0 ? "Novo Técnico" : "Editar Técnico" %></h1>

        <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=tecnicos" method="post">

            <label for="id">Id:</label>
            <input type="text" id="id" name="id" pattern="\d+" title="apenas dígitos" 
                   value="<%= entity.getId() %>" 
                   <%= (entity.getId() != 0) ? "readonly" : "" %> required><br/><br/>

            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" 
                   value="<%= (entity.getNome() != null) ? entity.getNome() : "" %>" required><br/><br/>

            <label for="especialidade">Especialidade:</label>
            <input type="text" id="especialidade" name="especialidade" 
                   value="<%= (entity.getEspecialidade() != null) ? entity.getEspecialidade() : "" %>"><br/><br/>

            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" 
                   value="<%= (entity.getTelefone() != null) ? entity.getTelefone() : "" %>"
                   pattern="\(?\d{2}\)?\s?\d{4,5}-\d{4}" title="Formato: (XX) XXXX-XXXX ou (XX) XXXXX-XXXX"><br/><br/>

            <input type="submit" name="Salvar" value="Salvar"> 
            <a href="<%= request.getContextPath() %>/home?task=tecnicos&action=list">Cancelar</a>
        </form>

    </body>
</html>