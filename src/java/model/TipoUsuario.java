package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class TipoUsuario extends DataAccessObject {

    private int id;
    private String nome;
    private String moduloAdmin;
    private String moduloAtendimento;
    private String moduloTecnico;

    public TipoUsuario() {
        super("tipo_usuario");
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getModuloAdmin() {
        return moduloAdmin;
    }

    public String getModuloAtendimento() {
        return moduloAtendimento;
    }

    public String getModuloTecnico() {
        return moduloTecnico;
    }

    

    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setNome(String nome) {
        this.nome = nome;
        addChange("nome", this.nome);
    }

    public void setModuloAdmin(String moduloAdmin) {
        this.moduloAdmin = moduloAdmin;
        addChange("modulo_admin", this.moduloAdmin);
    }

    public void setModuloAtendimento(String moduloAtendimento) {
        this.moduloAtendimento = moduloAtendimento;
        addChange("modulo_atendimento", this.moduloAtendimento);
    }

    public void setModuloTecnico(String moduloTecnico) {
        this.moduloTecnico = moduloTecnico;
        addChange("modulo_tecnico", this.moduloTecnico);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + id;
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        nome = (String) data.get(1);
        moduloAdmin = (String) data.get(2);
        moduloAtendimento = (String) data.get(3);
        moduloTecnico = (String) data.get(4);
        return this;
    }

    @Override
    protected TipoUsuario copy() {
        TipoUsuario cp = new TipoUsuario();
        
        cp.setId(id);
        cp.setNome(nome);
        cp.setModuloAdmin(moduloAdmin);
        cp.setModuloAtendimento(moduloAtendimento);
        cp.setModuloTecnico(moduloTecnico);
        
        cp.setNovelEntity(false);
        
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof TipoUsuario) {
            return this.id == ((TipoUsuario) obj).getId();
        }
        return false;
    }
}
