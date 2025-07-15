
package itu.models;

import jakarta.persistence.*;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.temporal.ChronoUnit;


@Entity
@Table(name = "pret")
public class Pret {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpret")
    private Long idPret;

    @Column(name = "typepret", nullable = false, length = 20)
    private String typePret;

    @Column(name = "date_emprunt", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateEmprunt;

    @Column(name = "date_rendu")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateRendu;

    @Column(name = "date_rendu_prevue", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateRenduPrevue;

    @Column(name = "is_prolonged")
    private Boolean isProlonged = false;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idadherent", nullable = false)
    private Adherent adherent;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "idexemplairelivre", nullable = false)
    private ExemplaireLivre exemplaireLivre;

    public Pret() {}

    public Pret(String typePret, LocalDate dateEmprunt, LocalDate dateRenduPrevue,
                Adherent adherent, ExemplaireLivre exemplaireLivre) {
        this.typePret = typePret;
        this.dateEmprunt = dateEmprunt;
        this.dateRenduPrevue = dateRenduPrevue;
        this.adherent = adherent;
        this.exemplaireLivre = exemplaireLivre;
    }

    // Getters / Setters
    public Long getIdPret() { return idPret; }
    public void setIdPret(Long idPret) { this.idPret = idPret; }

    public String getTypePret() { return typePret; }
    public void setTypePret(String typePret) { this.typePret = typePret; }

    public LocalDate getDateEmprunt() { return dateEmprunt; }
    public void setDateEmprunt(LocalDate dateEmprunt) { this.dateEmprunt = dateEmprunt; }

    public LocalDate getDateRendu() { return dateRendu; }
    public void setDateRendu(LocalDate dateRendu) { this.dateRendu = dateRendu; }

    public LocalDate getDateRenduPrevue() { return dateRenduPrevue; }
    public void setDateRenduPrevue(LocalDate dateRenduPrevue) { this.dateRenduPrevue = dateRenduPrevue; }

    public Boolean getIsProlonged() { return isProlonged; }
    public void setIsProlonged(Boolean isProlonged) { this.isProlonged = isProlonged; }

    public Adherent getAdherent() { return adherent; }
    public void setAdherent(Adherent adherent) { this.adherent = adherent; }

    public ExemplaireLivre getExemplaireLivre() { return exemplaireLivre; }
    public void setExemplaireLivre(ExemplaireLivre exemplaireLivre) { this.exemplaireLivre = exemplaireLivre; }

    // Méthodes utilitaires
    public boolean isEnCours() {
        return dateRendu == null;
    }

    public boolean isEnRetard() {
        return isEnCours() && LocalDate.now().isAfter(dateRenduPrevue);
    }

    public long getJoursDeRetard() {
        if (!isEnRetard()) return 0;
        return ChronoUnit.DAYS.between(dateRenduPrevue, LocalDate.now());
    }

    public long getJoursRestants() {
        if (!isEnCours()) return 0;
        if (isEnRetard()) return -getJoursDeRetard();
        return ChronoUnit.DAYS.between(LocalDate.now(), dateRenduPrevue);
    }

    public String getStatusPret() {
        if (!isEnCours()) return "Rendu";
        if (isEnRetard()) return "En retard";
        if (getJoursRestants() <= 2) return "À rendre bientôt";
        return "En cours";
    }
}
