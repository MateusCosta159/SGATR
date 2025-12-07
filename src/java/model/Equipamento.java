package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class Equipamento extends DataAccessObject {

    private int id;
    private int clienteId;
    private String tipo;
    private String marca;
    private String modelo;
    private String defeitoRelatado;

    public Equipamento() {
        super("equipamentos");
    }

    public int getId() {
        return id;
    }

    public int getClienteId() {
        return clienteId;
    }

    public String getTipo() {
        return tipo;
    }

    public String getMarca() {
        return marca;
    }

    public String getModelo() {
        return modelo;
    }

    public String getDefeitoRelatado() {
        return defeitoRelatado;
    }

    

    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setClienteId(int clienteId) {
        this.clienteId = clienteId;
        addChange("cliente_id", this.clienteId);
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
        addChange("tipo", this.tipo);
    }

    public void setMarca(String marca) {
        this.marca = marca;
        addChange("marca", this.marca);
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
        addChange("modelo", this.modelo);
    }

    public void setDefeitoRelatado(String defeito) {
        this.defeitoRelatado = defeito;
        addChange("defeito_relatado", this.defeitoRelatado);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + id;
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        clienteId = (int) data.get(1);
        tipo = (String) data.get(2);
        marca = (String) data.get(3);
        modelo = (String) data.get(4);
        defeitoRelatado = (String) data.get(5);
        return this;
    }

    @Override
    protected Equipamento copy() {
        Equipamento cp = new Equipamento();
        cp.setId(id);
        cp.setClienteId(clienteId);
        cp.setTipo(tipo);
        cp.setMarca(marca);
        cp.setModelo(modelo);
        cp.setDefeitoRelatado(defeitoRelatado);
        cp.setNovelEntity(false);
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Equipamento) {
            return this.id == ((Equipamento) obj).getId();
        }
        return false;
    }
}
