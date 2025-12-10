<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>

    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/home/app/css/login.css">
</head>
<body>

    <%
        String msg = (String) request.getAttribute("msg");
        if (msg != null) {
    %>
        <script>alert("<%= msg %>");</script>
    <% } %>

    <%
        HttpSession sessao = request.getSession(false);
        if (sessao != null
                && sessao.getAttribute("usuario") != null
                && sessao.getAttribute("tipo_usuario") != null) {
            response.sendRedirect(request.getContextPath() + "/home/app/menu.jsp");
        }
    %>

    <%
        int id = -1;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("id")) {
                    id = Integer.parseInt(c.getValue());
                }
            }
        }
    %>

    <form action="<%= request.getContextPath() %>/home?task=login" method="post">

        <h2 class="titulo-login">Login</h2>

        <label for="id">ID</label>
        <input type="text" id="id" name="id" pattern="\d+" title="Apenas dígitos"
               value="<%= id != -1 ? id : "" %>" required>

        <label for="senha">Senha</label>
        <input type="password" id="senha" name="senha" required>

        <input type="submit" value="Login">

    </form>

</body>
</html>
