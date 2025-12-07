package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Cliente extends DataAccessObject {

    private int id;
    private String nome;
    private String telefone;
    private String email;
    private String cpf;
    private String endereco;

    public Cliente() {
        super("clientes");
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getTelefone() {
        return telefone;
    }

    public String getEmail() {
        return email;
    }

    public String getCpf() {
        return cpf;
    }

    public String getEndereco() {
        return endereco;
    }

    
    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
        addChange("telefone", this.telefone);
    }

    public void setEmail(String email) {
        this.email = email;
        addChange("email", this.email);
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
        addChange("cpf", this.cpf);
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
        addChange("endereco", this.endereco);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + id;
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        nome = (String) data.get(1);
        telefone = (String) data.get(2);
        email = (String) data.get(3);
        cpf = (String) data.get(4);
        endereco = (String) data.get(5);

        return this;
    }

    @Override
    protected Cliente copy() {
        Cliente cp = new Cliente();
        cp.setId(getId());
        cp.setNome(getNome());
        cp.setTelefone(getTelefone());
        cp.setEmail(getEmail());
        cp.setCpf(getCpf());
        cp.setEndereco(getEndereco());
        cp.setNovelEntity(false);
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Cliente) {
            return this.id == ((Cliente) obj).getId();
        }
        return false;
    }
}
