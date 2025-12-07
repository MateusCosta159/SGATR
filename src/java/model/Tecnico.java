package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Tecnico extends DataAccessObject {

    private int id;
    private String nome;
    private String especialidade;
    private String telefone;

    public Tecnico() {
        super("tecnicos");
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public String getTelefone() {
        return telefone;
    }

    

    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
        addChange("especialidade", this.especialidade);
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
        addChange("telefone", this.telefone);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + id;
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        nome = (String) data.get(1);
        especialidade = (String) data.get(2);
        telefone = (String) data.get(3);
        return this;
    }

    @Override
    protected Tecnico copy() {
        Tecnico cp = new Tecnico();
        cp.setId(id);
        cp.setNome(nome);
        cp.setEspecialidade(especialidade);
        cp.setTelefone(telefone);
        cp.setNovelEntity(false);
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Tecnico) {
            return this.id == ((Tecnico) obj).getId();
        }
        return false;
    }
}
