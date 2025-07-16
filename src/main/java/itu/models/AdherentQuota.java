package itu.models;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.*;


@Entity
@Table(name = "adherent_quota")
public class AdherentQuota {

    @Id
    @Column(name = "id_adherent", nullable = false)
    private Long idAdherent;
    
    @Column(name = "quota_surplace", nullable = false)
    private Integer quotaSurplace = 0;
    
    @Column(name = "quota_emprunter", nullable = false)
    private Integer quotaEmprunter = 0;
    
    @OneToOne
    @JoinColumn(name = "id_adherent", referencedColumnName = "IdAdherent", insertable = false, updatable = false)
    @JsonBackReference
    private Adherent adherent;

    // Constructeur par défaut
    public AdherentQuota() {
    }

    // Constructeur avec paramètres
    public AdherentQuota(Long idAdherent,Integer quotaSurplace, Integer quotaEmprunter) {
        this.idAdherent = idAdherent;
        this.quotaSurplace = quotaSurplace;
        this.quotaEmprunter = quotaEmprunter;
    }

    // Getters et Setters
    public Long getIdAdherent() {
        return idAdherent;
    }

    public void setIdAdherent(Long idAdherent) {
        this.idAdherent = idAdherent;
    }

    public Integer getQuotaSurPlace() {
        return quotaSurplace;
    }

    public void setQuotaSurPlace(Integer quotaSurplace) {
        this.quotaSurplace = quotaSurplace;
    }

    public Integer getQuotaEmprunter() {
        return quotaEmprunter;
    }

    public void setQuotaEmprunter(Integer quotaEmprunter) {
        this.quotaEmprunter = quotaEmprunter;
    }

    public Adherent getAdherent() {
        return adherent;
    }

    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
        if (adherent != null) {
            this.idAdherent = adherent.getIdAdherent();
        }
    }
}