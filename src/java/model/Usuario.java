package model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Usuario extends DataAccessObject {

    private int id;
    private String nome;
    private String senha;
    private int tipoUsuarioId;

    public Usuario() {
        super("usuarios");
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getSenha() {
        return senha;
    }

    public int getTipoUsuarioId() {
        return tipoUsuarioId;
    }

    

    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setSenha(String senha) throws Exception {
        if (senha == null) return;

        if (!senha.equals(this.senha)) {

            String senhaSal = id + senha + (id / 2);
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            String hash = new BigInteger(1, md.digest(senhaSal.getBytes("UTF-8"))).toString(16);

            this.senha = hash;
            addChange("senha", this.senha);
        }
    }

    public void setTipoUsuarioId(int tipoUsuarioId) {
        this.tipoUsuarioId = tipoUsuarioId;
        addChange("tipo_usuario_id", this.tipoUsuarioId);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + id;
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        nome = (String) data.get(1);
        senha = (String) data.get(2);
        tipoUsuarioId = (int) data.get(3);
        return this;
    }

    @Override
    protected Usuario copy() {
        Usuario cp = new Usuario();
        cp.setId(id);
        cp.setNome(nome);
        cp.senha = senha;
        cp.setTipoUsuarioId(tipoUsuarioId);
        cp.setNovelEntity(false);
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Usuario) {
            return this.id == ((Usuario) obj).getId();
        }
        return false;
    }
}
