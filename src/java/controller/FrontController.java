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

                case "clientes":       doGetClientes(request, response); break;
                case "equipamentos":   doGetEquipamentos(request, response); break;
                case "tecnicos":       doGetTecnicos(request, response); break;
                case "os":             doGetOS(request, response); break;
                case "logout":         doGetLogout(request, response); break;

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

                case "clientes":       doPostClientes(request, response); break;
                case "equipamentos":   doPostEquipamentos(request, response); break;
                case "tecnicos":       doPostTecnicos(request, response); break;
                case "os":             doPostOS(request, response); break;
                case "login":          doPostLogin(request, response); break;

                default: doDefault(request, response);

            }

        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
        }
    }



    private void doGetClientes(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            Cliente c = new Cliente();
            c.setId(id);
            c.delete();
        }

        response.sendRedirect(request.getContextPath() + "/home/app/clientes/");
    }



    private void doGetEquipamentos(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            Equipamento e = new Equipamento();
            e.setId(id);
            e.delete();
        }

        response.sendRedirect(request.getContextPath() + "/home/app/equipamentos/");
    }


    private void doGetTecnicos(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            Tecnico t = new Tecnico();
            t.setId(id);
            t.delete();
        }

        response.sendRedirect(request.getContextPath() + "/home/app/tecnicos/");
    }


    private void doGetOS(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));

            OrdemServico os = new OrdemServico();
            os.setId(id);
            os.delete();
        }

        response.sendRedirect(request.getContextPath() + "/home/app/os/");
    }


    private void doGetLogout(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession sessao = request.getSession(false);

        if (sessao != null) {
            sessao.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/home/login.jsp");
    }



    private void doPostClientes(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");

        Cliente c = new Cliente();
        c.setId(id);

        if ("update".equals(action)) c.load();

        c.setNome(nome);
        c.setTelefone(telefone);
        c.setEmail(email);

        c.save();

        response.sendRedirect(request.getContextPath() + "/home/app/clientes/");
    }


    private void doPostEquipamentos(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        int id = Integer.parseInt(request.getParameter("id"));
        int clienteId = Integer.parseInt(request.getParameter("cliente_id"));
        String tipo = request.getParameter("tipo");
        String marca = request.getParameter("marca");
        String modelo = request.getParameter("modelo");
        String defeito = request.getParameter("defeito_relatado");

        Equipamento e = new Equipamento();
        e.setId(id);

        if ("update".equals(action)) e.load();

        e.setClienteId(clienteId);
        e.setTipo(tipo);
        e.setMarca(marca);
        e.setModelo(modelo);
        e.setDefeitoRelatado(defeito);

        e.save();

        response.sendRedirect(request.getContextPath() + "/home/app/equipamentos/");
    }



    private void doPostTecnicos(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String especialidade = request.getParameter("especialidade");

        Tecnico t = new Tecnico();
        t.setId(id);

        if ("update".equals(action)) t.load();

        t.setNome(nome);
        t.setEspecialidade(especialidade);

        t.save();

        response.sendRedirect(request.getContextPath() + "/home/app/tecnicos/");
    }



    private void doPostOS(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String action = request.getParameter("action");

        int id = Integer.parseInt(request.getParameter("id"));
        int equipamentoId = Integer.parseInt(request.getParameter("equipamento_id"));
        int tecnicoId = Integer.parseInt(request.getParameter("tecnico_id"));
        String dataAbertura = request.getParameter("data_abertura");
        String status = request.getParameter("status");
        String observacoes = request.getParameter("observacoes");

        Double valorOrc = request.getParameter("valor_orcamento").isEmpty() ? null :
                Double.valueOf(request.getParameter("valor_orcamento"));

        Double valorFinal = request.getParameter("valor_final").isEmpty() ? null :
                Double.valueOf(request.getParameter("valor_final"));

        OrdemServico os = new OrdemServico();
        os.setId(id);

        if ("update".equals(action)) os.load();

        os.setEquipamentoId(equipamentoId);
        os.setTecnicoId(tecnicoId);
        os.setDataAbertura(dataAbertura);
        os.setStatus(status);
        os.setValorOrcamento(valorOrc);
        os.setValorFinal(valorFinal);
        os.setObservacoes(observacoes);

        os.save();

        response.sendRedirect(request.getContextPath() + "/home/app/os/");
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



    private void doDefault(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.sendRedirect(request.getContextPath() + "/home/login.jsp");
    }

}
