package itu.models;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "abonnement")
public class Abonnement {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idabonnement")
    private Long idAbonnement;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idadherent", nullable = false)
    private Adherent adherent;
    
    @Column(name = "datedebut", nullable = false)
    private LocalDate dateDebut = LocalDate.now();
    
    @Column(name = "datefin", nullable = false)
    private LocalDate dateFin;
    
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal montant;
    
    // Constructeurs
    public Abonnement() {}
    
    public Abonnement(Adherent adherent, BigDecimal montant, LocalDate dateFin) {
        this.adherent = adherent;
        this.montant = montant;
        this.dateFin = dateFin;
    }
    
    // Getters et Setters
    public Long getIdAbonnement() { return idAbonnement; }
    public void setIdAbonnement(Long idAbonnement) { this.idAbonnement = idAbonnement; }
    
    public Adherent getAdherent() { return adherent; }
    public void setAdherent(Adherent adherent) { this.adherent = adherent; }
    
    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }
    
    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }
    
    public BigDecimal getMontant() { return montant; }
    public void setMontant(BigDecimal montant) { this.montant = montant; }
    
    // Méthode utilitaire
    public boolean isActif() {
        LocalDate today = LocalDate.now();
        return !today.isBefore(dateDebut) && !today.isAfter(dateFin);
    }
}