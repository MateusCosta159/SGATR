<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/home/css/clientes.css">
        <title>Cliente</title>
    </head>
    <body>

        <%@ include file="/home/app/modulos.jsp" %>

        <%
            Cliente cl = null;

            String action = request.getParameter("action");
            if (action == null) {
                action = "create";
            } else {
                if (action.equals("update")) {
                    int id = Integer.valueOf(request.getParameter("id"));
                    cl = new Cliente();
                    cl.setId(id);
                    cl.load();
                }
            }

            Cliente entity = (Cliente) request.getAttribute("entity");
            if (entity == null) {
                entity = cl != null ? cl : new Cliente();
            }
        %>

        <h1><%= entity.getId() == 0 ? "Novo Cliente" : "Editar Cliente"%></h1>

        <form action="<%= request.getContextPath()%>/home?action=<%= action%>&task=clientes" method="post">

            <label for="id">Id:</label>
            <input type="text" id="id" name="id" pattern="\d+" title="apenas dígitos" 
                   value="<%= (entity.getId() == 0) ? "" : entity.getId()%>" 
                   <%= (entity.getId() != 0) ? "readonly" : ""%> required><br/><br/>


            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" 
                   pattern="^[A-Za-zÀ-ÿ\s']{2,80}$"
                   title="Nome deve conter apenas letras, espaços e apóstrofes (2-80 caracteres)"
                   value="<%= (entity.getNome() != null) ? entity.getNome() : ""%>" required><br/><br/>

            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" 
                   pattern="^(?:\(?\d{2}\)?\s?)?(?:9\d{4}|\d{4})-?\d{4}$"
                   title="Formato: (XX) 9XXXX-XXXX ou (XX) XXXX-XXXX"
                   value="<%= (entity.getTelefone() != null) ? entity.getTelefone() : ""%>"><br/><br/>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" 
                   pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                   title="Email deve estar no formato: usuario@dominio.com"
                   value="<%= (entity.getEmail() != null) ? entity.getEmail() : ""%>"><br/><br/>

            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" 
                   pattern="^\d{3}\.\d{3}\.\d{3}-\d{2}$|^\d{11}$"
                   title="Formato: 000.000.000-00 ou apenas números"
                   value="<%= (entity.getCpf() != null) ? entity.getCpf() : ""%>"><br/><br/>

            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" 
                   pattern="^.{5,255}$"
                   title="Endereço deve ter entre 5 e 255 caracteres"
                   value="<%= (entity.getEndereco() != null) ? entity.getEndereco() : ""%>"><br/><br/>

            <input type="submit" name="Salvar" value="Salvar"> 
            <a href="<%= request.getContextPath()%>/home?task=clientes&action=list">Cancelar</a>
        </form>

        <script>
            // Máscaras para formatação automática
            document.getElementById('cpf')?.addEventListener('input', function (e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length <= 11) {
                    value = value.replace(/(\d{3})(\d)/, '$1.$2')
                            .replace(/(\d{3})(\d)/, '$1.$2')
                            .replace(/(\d{3})(\d{1,2})$/, '$1-$2');
                }
                e.target.value = value;
            });

            document.getElementById('telefone')?.addEventListener('input', function (e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length === 11) {
                    value = value.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
                } else if (value.length === 10) {
                    value = value.replace(/(\d{2})(\d{4})(\d{4})/, '($1) $2-$3');
                }
                e.target.value = value;
            });
        </script>

    </body>
</html>