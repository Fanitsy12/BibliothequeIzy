package itu.models;

import jakarta.persistence.*;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "profil")
public class Profil {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_profil")
    private Long idProfil;

    @Column(name = "nom_profil", nullable = false, length = 50)
    private String nomProfil;

    @Column(name = "quota_maxsurplace", nullable = false)
    private Integer quotaMaxSurPlace;

    @Column(name = "quota_maxemprunter")
    private Integer quotaMaxEmprunter;

    @Column(name = "duree_pret", nullable = false)
    private Integer dureePret;

    @Column(name = "duree_penalite")
    private Integer dureePenalite;

    @OneToMany(mappedBy = "profil", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonBackReference
    private List<Adherent> adherents;

    // Constructeurs
    public Profil() {}

    public Profil(String nomProfil, Integer quotaMaxSurPlace, Integer quotaMaxEmprunter, Integer dureePret) {
        this.nomProfil = nomProfil;
        this.quotaMaxSurPlace = quotaMaxSurPlace;
        this.quotaMaxEmprunter = quotaMaxEmprunter;
        this.dureePret = dureePret;
    }

    public Profil(String nomProfil, Integer quotaMaxSurPlace, Integer quotaMaxEmprunter, Integer dureePret, Integer dureePenalite) {
    this.nomProfil = nomProfil;
    this.quotaMaxSurPlace = quotaMaxSurPlace;
    this.quotaMaxEmprunter = quotaMaxEmprunter;
    this.dureePret = dureePret;
    this.dureePenalite = dureePenalite;
}

public Integer getDureePenalite() {
    return dureePenalite;
}

public void setDureePenalite(Integer dureePenalite) {
    this.dureePenalite = dureePenalite;
}



    // Getters et Setters
    public Long getIdProfil() { return idProfil; }
    public void setIdProfil(Long idProfil) { this.idProfil = idProfil; }

    public String getNomProfil() { return nomProfil; }
    public void setNomProfil(String nomProfil) { this.nomProfil = nomProfil; }

    public Integer getQuotaMaxSurPlace() { return quotaMaxSurPlace; }
    public void setQuotaMaxSurPlace(Integer quotaMaxSurPlace) { this.quotaMaxSurPlace = quotaMaxSurPlace; }

    public Integer getQuotaMaxEmprunter() { return quotaMaxEmprunter; }
    public void setQuotaMaxEmprunter(Integer quotaMaxEmprunter) { this.quotaMaxEmprunter = quotaMaxEmprunter; }

    public Integer getDureePret() { return dureePret; }
    public void setDureePret(Integer dureePret) { this.dureePret = dureePret; }

    public List<Adherent> getAdherents() { return adherents; }
    public void setAdherents(List<Adherent> adherents) { this.adherents = adherents; }
}