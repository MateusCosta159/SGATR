<%@page import="model.TipoUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tipo de Usuário</title>
</head>
<body>

    <%@ include file="/home/app/modulos.jsp" %>

<%
    // Objeto do tipo usuário
    TipoUsuario tp = null;

    String action = request.getParameter("action");
    if (action == null) {
        action = "create";
    } else if (action.equals("update")) {

        int id = Integer.parseInt(request.getParameter("id"));

        tp = new TipoUsuario();
        tp.setId(id);
        tp.load();
    }

    // Evitar null pointer nos campos
    String nome = (tp != null && tp.getNome() != null) ? tp.getNome() : "";

    String modAdmin  = (tp != null && "S".equals(tp.getModuloAdmin())) ? "checked" : "";
    String modTec    = (tp != null && "S".equals(tp.getModuloTecnico())) ? "checked" : "";
    String modAtend  = (tp != null && "S".equals(tp.getModuloAtendimento())) ? "checked" : "";
%>

<h1>Tipo de Usuário</h1>

<form action="<%= request.getContextPath() %>/home?task=tipousuario&action=<%= action %>" method="post">

    <label for="id">ID:</label>
    <input type="text" id="id" name="id" pattern="\d+" 
        value="<%= (tp != null ? tp.getId() : "") %>"
        <%= (tp != null ? "readonly" : "") %> required>
    <br><br>

    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" value="<%= nome %>" required>
    <br><br>

    <!-- ADMINISTRATIVO -->
    <input type="checkbox" id="modulo_adm" name="modulo_adm" value="S" <%= modAdmin %>>
    <label for="modulo_adm">Administrativo</label>
    
    
    <!-- ATENDIMENTO -->
    <input type="checkbox" id="modulo_atendimento" name="modulo_atendimento" value="S" <%= modAtend %>>
    <label for="modulo_atendimento">Atendimento</label>

    <!-- TÉCNICO -->
    <input type="checkbox" id="modulo_tecnico" name="modulo_tecnico" value="S" <%= modTec %>>
    <label for="modulo_tecnico">Técnico</label>


    <br><br>

    <input type="submit" value="Salvar">

</form>

</body>
</html>
