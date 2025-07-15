package itu.models;

import jakarta.persistence.*;

@Entity
@Table(name = "pret_prolongement")
public class PretProlongement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idprolongement")
    private Long idProlongement;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idpret", nullable = false)
    private Pret pret;

    @Column(name = "jour_prolongement", nullable = false)
    private Integer jourProlongement;

    @Column(name = "est_valide", nullable = false)
    private Boolean estValide = false;

    // Constructeurs
    public PretProlongement() {}

    public PretProlongement(Pret pret, Integer jourProlongement) {
        this.pret = pret;
        this.jourProlongement = jourProlongement;
        this.estValide = false;
    }

    // Getters et Setters
    public Long getIdProlongement() {
        return idProlongement;
    }

    public void setIdProlongement(Long idProlongement) {
        this.idProlongement = idProlongement;
    }

    public Pret getPret() {
        return pret;
    }

    public void setPret(Pret pret) {
        this.pret = pret;
    }

    public Integer getJourProlongement() {
        return jourProlongement;
    }

    public void setJourProlongement(Integer jourProlongement) {
        this.jourProlongement = jourProlongement;
    }

    public Boolean getEstValide() {
        return estValide;
    }

    public void setEstValide(Boolean estValide) {
        this.estValide = estValide;
    }
}
