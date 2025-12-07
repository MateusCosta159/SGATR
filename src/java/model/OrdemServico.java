package model;

import java.util.ArrayList;
import model.framework.DataAccessObject;

public class OrdemServico extends DataAccessObject {

    private int id;
    private int equipamentoId;
    private int tecnicoId;
    private String dataAbertura;
    private String status;
    private Double valorOrcamento;
    private Double valorFinal;
    private String observacoes;

    public OrdemServico() {
        super("ordens_servico");
    }

    public int getId() {
        return id;
    }

    public int getEquipamentoId() {
        return equipamentoId;
    }

    public int getTecnicoId() {
        return tecnicoId;
    }

    public String getDataAbertura() {
        return dataAbertura;
    }

    public String getStatus() {
        return status;
    }

    public Double getValorOrcamento() {
        return valorOrcamento;
    }

    public Double getValorFinal() {
        return valorFinal;
    }

    public String getObservacoes() {
        return observacoes;
    }

    

    public void setId(int id) {
        this.id = id;
        addChange("id", this.id);
    }

    public void setEquipamentoId(int equipamentoId) {
        this.equipamentoId = equipamentoId;
        addChange("equipamento_id", this.equipamentoId);
    }

    public void setTecnicoId(int tecnicoId) {
        this.tecnicoId = tecnicoId;
        addChange("tecnico_id", this.tecnicoId);
    }

    public void setDataAbertura(String dataAbertura) {
        this.dataAbertura = dataAbertura;
        addChange("data_abertura", this.dataAbertura);
    }

    public void setStatus(String status) {
        this.status = status;
        addChange("status", this.status);
    }

    public void setValorOrcamento(Double valorOrcamento) {
        this.valorOrcamento = valorOrcamento;
        addChange("valor_orcamento", this.valorOrcamento);
    }

    public void setValorFinal(Double valorFinal) {
        this.valorFinal = valorFinal;
        addChange("valor_final", this.valorFinal);
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
        addChange("observacoes", this.observacoes);
    }

    @Override
    protected String getWhereClauseForOneEntity() {
        return " id = " + id;
    }

    @Override
    protected DataAccessObject fill(ArrayList<Object> data) {
        id = (int) data.get(0);
        equipamentoId = (int) data.get(1);
        tecnicoId = (int) data.get(2);
        dataAbertura = (String) data.get(3);
        status = (String) data.get(4);
        valorOrcamento = data.get(5) == null ? null : Double.valueOf(data.get(5).toString());
        valorFinal = data.get(6) == null ? null : Double.valueOf(data.get(6).toString());
        observacoes = (String) data.get(7);
        return this;
    }

    @Override
    protected OrdemServico copy() {
        OrdemServico cp = new OrdemServico();
        cp.setId(id);
        cp.setEquipamentoId(equipamentoId);
        cp.setTecnicoId(tecnicoId);
        cp.setDataAbertura(dataAbertura);
        cp.setStatus(status);
        cp.setValorOrcamento(valorOrcamento);
        cp.setValorFinal(valorFinal);
        cp.setObservacoes(observacoes);
        cp.setNovelEntity(false);
        return cp;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof OrdemServico) {
            return this.id == ((OrdemServico) obj).getId();
        }
        return false;
    }
}
