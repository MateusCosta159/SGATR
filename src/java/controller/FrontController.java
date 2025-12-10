package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import logtrack.ExceptionLogTrack;

import model.Cliente;
import model.Equipamento;
import model.OrdemServico;
import model.Tecnico;
import model.Usuario;
import model.TipoUsuario;

public class FrontController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) task = "";

        try {
            switch (task) {

                case "clientes": doGetClientes(request, response); break;
                case "equipamentos": doGetEquipamentos(request, response); break;
                case "tecnicos": doGetTecnicos(request, response); break;
                case "os": doGetOS(request, response); break;

                case "usuarios": doGetUsuarios(request, response); break;
                case "tipousuario": doGetTipoUsuario(request, response); break;

                case "logout": doGetLogout(request, response); break;

                default: doDefault(request, response);
            }

        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) task = "";

        try {
            switch (task) {

                case "clientes": doPostClientes(request, response); break;
                case "equipamentos": doPostEquipamentos(request, response); break;
                case "tecnicos": doPostTecnicos(request, response); break;
                case "os": doPostOS(request, response); break;

                case "usuarios": doPostUsuarios(request, response); break;
                case "tipousuario": doPostTipoUsuario(request, response); break;

                case "login": doPostLogin(request, response); break;

                default: doDefault(request, response);
            }

        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
        }
    }

    // ========== MÉTODOS GET ==========

    private void doGetClientes(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Cliente c = new Cliente();
            c.setId(id);
            c.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/atendimento/clientes.jsp");
    }

    private void doGetEquipamentos(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Equipamento e = new Equipamento();
            e.setId(id);
            e.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/atendimento/equipamentos.jsp");
    }

    private void doGetTecnicos(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Tecnico t = new Tecnico();
            t.setId(id);
            t.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/tecnico/tecnicos.jsp");
    }

    private void doGetOS(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            OrdemServico os = new OrdemServico();
            os.setId(id);
            os.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/os/os.jsp");
    }

    private void doGetUsuarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Usuario u = new Usuario();
            u.setId(id);
            u.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/adm/usuarios.jsp");
    }

    private void doGetTipoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            TipoUsuario tp = new TipoUsuario();
            tp.setId(id);
            tp.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/adm/tipousuario.jsp");
    }

    // ========== MÉTODOS POST ==========

    private void doPostClientes(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");

        // CORREÇÃO: Tratar ID que pode ser vazio em criação
        String idStr = request.getParameter("id");
        int id = 0;
        if (idStr != null && !idStr.trim().isEmpty()) {
            id = Integer.parseInt(idStr);
        }

        String nome = request.getParameter("nome");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String endereco = request.getParameter("endereco");

        Cliente c = new Cliente();
        
        // CORREÇÃO: Só setar ID se for maior que 0
        if (id > 0) {
            c.setId(id);
        }

        // CORREÇÃO: Seguir a mesma lógica do exemplo - verificar se é update
        if ("update".equals(action) && id > 0) {
            c.load();
        }

        c.setNome(nome);
        c.setTelefone(telefone);
        c.setEmail(email);
        c.setCpf(cpf);
        c.setEndereco(endereco);

        c.save();

        response.sendRedirect(request.getContextPath() + "/home/app/atendimento/clientes.jsp");
    }

    private void doPostEquipamentos(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");

        // CORREÇÃO: Tratar ID que pode ser vazio
        String idStr = request.getParameter("id");
        int id = 0;
        if (idStr != null && !idStr.trim().isEmpty()) {
            id = Integer.parseInt(idStr);
        }

        int clienteId = Integer.parseInt(request.getParameter("clienteId"));
        String tipo = request.getParameter("tipo");
        String marca = request.getParameter("marca");
        String modelo = request.getParameter("modelo");
        // CORREÇÃO: Nome do parâmetro estava errado
        String defeito = request.getParameter("defeitoRelatado");

        Equipamento e = new Equipamento();
        
        if (id > 0) {
            e.setId(id);
        }

        // CORREÇÃO: Seguir a mesma lógica do exemplo
        if ("update".equals(action) && id > 0) {
            e.load();
        }

        e.setClienteId(clienteId);
        e.setTipo(tipo);
        e.setMarca(marca);
        e.setModelo(modelo);
        e.setDefeitoRelatado(defeito);

        e.save();

        response.sendRedirect(request.getContextPath() + "/home/app/atendimento/equipamentos.jsp");
    }

    private void doPostTecnicos(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");

        // CORREÇÃO: Tratar ID que pode ser vazio
        String idStr = request.getParameter("id");
        int id = 0;
        if (idStr != null && !idStr.trim().isEmpty()) {
            id = Integer.parseInt(idStr);
        }

        String nome = request.getParameter("nome");
        String especialidade = request.getParameter("especialidade");
        // CORREÇÃO: Adicionar campo telefone que estava faltando
        String telefone = request.getParameter("telefone");

        Tecnico t = new Tecnico();
        
        if (id > 0) {
            t.setId(id);
        }

        if ("update".equals(action) && id > 0) {
            t.load();
        }

        t.setNome(nome);
        t.setEspecialidade(especialidade);
        t.setTelefone(telefone);

        t.save();

        response.sendRedirect(request.getContextPath() + "/home/app/tecnico/tecnicos.jsp");
    }

    private void doPostOS(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    String action = request.getParameter("action");

    int id = Integer.parseInt(request.getParameter("id"));
    
    int equipamentoId = Integer.parseInt(request.getParameter("equipamentoId"));
    
    // IMPORTANTE: Copiar a mesma lógica do Usuário para tecnicoId
    String tecnicoIdStr = request.getParameter("tecnicoId");
    int tecnicoId = 0; // Default 0 como no Usuário (convenioId = 0)
    if (tecnicoIdStr != null && !tecnicoIdStr.trim().isEmpty()) {
        tecnicoId = Integer.parseInt(tecnicoIdStr);
    }
    
    // *** COPIA EXATA DA LÓGICA DO USUÁRIO ***
    String dataAbertura = request.getParameter("dataAbertura");
    
    String status = request.getParameter("status");
    String observacoes = request.getParameter("observacoes");

    // Copiar a mesma lógica para valores monetários
    String valorOrcStr = request.getParameter("valorOrcamento");
    Double valorOrc = null;
    if (valorOrcStr != null && !valorOrcStr.trim().isEmpty()) {
        valorOrc = Double.valueOf(valorOrcStr);
    }

    String valorFinalStr = request.getParameter("valorFinal");
    Double valorFinal = null;
    if (valorFinalStr != null && !valorFinalStr.trim().isEmpty()) {
        valorFinal = Double.valueOf(valorFinalStr);
    }

    OrdemServico os = new OrdemServico();

    os.setId(id);

    // MESMA VERIFICAÇÃO DO USUÁRIO
    if ("update".equals(action)) {
        os.load();
    }

    os.setEquipamentoId(equipamentoId);
    os.setTecnicoId(tecnicoId);
    
    // *** TRATAMENTO IDÊNTICO AO DO USUÁRIO PARA DATA ***
    if (dataAbertura == null || dataAbertura.trim().isEmpty()) {
        os.setDataAbertura(null);
    } else {
        os.setDataAbertura(dataAbertura);
    }
    
    os.setStatus(status);
    os.setObservacoes(observacoes);
    
    // Para valores monetários, se null, o setter deve lidar com isso
    os.setValorOrcamento(valorOrc);
    os.setValorFinal(valorFinal);

    os.save();
    
    response.sendRedirect(request.getContextPath() + "/home/app/os/os.jsp");
}
    private void doPostUsuarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");

        // CORREÇÃO: Tratar ID que pode ser vazio
        String idStr = request.getParameter("id");
        int id = 0;
        if (idStr != null && !idStr.trim().isEmpty()) {
            id = Integer.parseInt(idStr);
        }

        String nome = request.getParameter("nome");
        String senha = request.getParameter("senha");
        int tipoUsuarioId = Integer.parseInt(request.getParameter("tipo_usuario_id"));

        Usuario u = new Usuario();
        
        if (id > 0) {
            u.setId(id);
        }

        if ("update".equals(action) && id > 0) {
            u.load();
        }

        u.setNome(nome);
        u.setSenha(senha);
        u.setTipoUsuarioId(tipoUsuarioId);

        u.save();

        response.sendRedirect(request.getContextPath() + "/home/app/adm/usuarios.jsp");
    }

    private void doPostTipoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");

        // CORREÇÃO: Tratar ID que pode ser vazio
        String idStr = request.getParameter("id");
        int id = 0;
        if (idStr != null && !idStr.trim().isEmpty()) {
            id = Integer.parseInt(idStr);
        }

        String nome = request.getParameter("nome");

        String moduloAdm = request.getParameter("modulo_adm");
        if (moduloAdm == null) moduloAdm = "N";

        String moduloTecnico = request.getParameter("modulo_tecnico");
        if (moduloTecnico == null) moduloTecnico = "N";

        String moduloAtendimento = request.getParameter("modulo_atendimento");
        if (moduloAtendimento == null) moduloAtendimento = "N";

        TipoUsuario tp = new TipoUsuario();
        
        if (id > 0) {
            tp.setId(id);
        }

        if ("update".equals(action) && id > 0) {
            tp.load();
        }

        tp.setNome(nome);
        tp.setModuloAdmin(moduloAdm);
        tp.setModuloAtendimento(moduloAtendimento);
        tp.setModuloTecnico(moduloTecnico);

        tp.save();

        response.sendRedirect(request.getContextPath() + "/home/app/adm/tipousuario.jsp");
    }

    private void doPostLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        String senha = request.getParameter("senha");

        Usuario usuarioTry = new Usuario();
        usuarioTry.setId(id);
        usuarioTry.setSenha(senha);

        Usuario usuario = new Usuario();
        usuario.setId(id);

        boolean existe = usuario.load();

        if (existe && usuario.getSenha().equals(usuarioTry.getSenha())) {
            HttpSession sessao = request.getSession(true);
            sessao.setAttribute("usuario", usuario);

            TipoUsuario tipo = new TipoUsuario();
            tipo.setId(usuario.getTipoUsuarioId());
            tipo.load();

            sessao.setAttribute("tipo_usuario", tipo);
            sessao.setMaxInactiveInterval(60 * 60);

            Cookie cookie = new Cookie("id", String.valueOf(id));
            cookie.setMaxAge(600);
            response.addCookie(cookie);

            response.sendRedirect(request.getContextPath() + "/home/app/menu.jsp");
        } else {
            request.setAttribute("msg", "ID ou senha incorretos!");
            request.getRequestDispatcher("/home/login.jsp").forward(request, response);
        }
    }

    private void doGetLogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sessao = request.getSession(false);
        if (sessao != null) sessao.invalidate();
        response.sendRedirect(request.getContextPath() + "/home/login.jsp");
    }

    private void doDefault(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.sendRedirect(request.getContextPath() + "/home/login.jsp");
    }
}