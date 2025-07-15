package itu.models;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idReservation;

    @ManyToOne
    @JoinColumn(name = "idAdherent", nullable = false)
    private Adherent adherent;

    @ManyToOne
    @JoinColumn(name = "idLivre", nullable = false)
    private Livre livre;

    @ManyToOne
    @JoinColumn(name = "idExemplaireLivre")
    private ExemplaireLivre exemplaireLivre;

    @Column(name = "date_reservation")
    private LocalDate dateReservation;

    @Column(name = "date_debut_reservation")
    private LocalDate dateDebutReservation;


    @Column(name = "date_fin_reservation")
    private LocalDate dateFinReservation;

    @Column(name = "isApproved")
private Boolean isApproved = false;

    // Getters and Setters

    public Long getIdReservation() {
        return idReservation;
    }

    public void setIdReservation(Long idReservation) {
        this.idReservation = idReservation;
    }

    public Adherent getAdherent() {
        return adherent;
    }

    public void setAdherent(Adherent adherent) {
        this.adherent = adherent;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    public ExemplaireLivre getExemplaireLivre() {
        return exemplaireLivre;
    }

    public void setExemplaireLivre(ExemplaireLivre exemplaireLivre) {
        this.exemplaireLivre = exemplaireLivre;
    }

    public LocalDate getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(LocalDate dateReservation) {
        this.dateReservation = dateReservation;
    }

    public LocalDate getDateDebutReservation() {
        return dateDebutReservation;
    }



    public void setDateDebutReservation(LocalDate dateDebutReservation) {
        this.dateDebutReservation = dateDebutReservation;
    }

     public LocalDate getDateFinReservation() {
        return dateFinReservation;
    }



    public void setDateFinReservation(LocalDate dateFinReservation) {
        this.dateFinReservation = dateFinReservation;
    }



    public Boolean getIsApproved() {
    return isApproved;
}

public void setIsApproved(Boolean isApproved) {
    this.isApproved = isApproved;
}

}
