package itu.models;

import jakarta.persistence.*;
import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "Penalite")
public class Penalite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idPenalite;

    @ManyToOne
    @JoinColumn(name = "IdAdherent", nullable = false)
    @JsonBackReference
    private Adherent adherent;

    @ManyToOne
    @JoinColumn(name = "IdPret")
    private Pret pret;

    @Column(name = "DateDebutPenalite", nullable = false)
    private LocalDate dateDebutPenalite = LocalDate.now();

    @Column(name = "DatelevePenalite", nullable = false)
    private LocalDate datelevePenalite = LocalDate.now();

    @Column(name = "Leve")
    private Boolean leve = false;


    // Getters & Setters

    public Long getIdPenalite() {
        return idPenalite;
    }

    public void setIdPenalite(Long idPenalite) {
        this.idPenalite = idPenalite;
    }

    public Adherent getAdherent() {
        return adherent;
    }

    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }

    public Pret getPret() {
        return pret;
    }

    public void setPret(Pret pret) {
        this.pret = pret;
    }

    public LocalDate getDateDebutPenalite() {
        return dateDebutPenalite;
    }

    public void setDateDebutPenalite(LocalDate dateDebutPenalite) {
        this.dateDebutPenalite = dateDebutPenalite;
    }

    public LocalDate getDatelevePenalite() {
        return datelevePenalite;
    }

    public void setDatelevePenalite(LocalDate datelevePenalite) {
        this.datelevePenalite = datelevePenalite;
    }
      public Boolean getLeve() {
        return leve;
    }

    public void setLeve(Boolean leve) {
        this.leve=leve;
    }


}
