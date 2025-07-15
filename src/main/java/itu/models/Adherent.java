package itu.models;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "adherent")
public class Adherent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idadherent")
    private Long idAdherent;

    @Column(nullable = false, length = 100)
    private String nom;

    @Column(length = 100)
    private String prenom;

    @Column(name = "datenaissance")
    private LocalDate dateNaissance;

    @Column(length = 100)
    private String email;

    @Column(name = "motdepasse", length = 10)
    private String motDePasse;

    @Column(name = "date_inscription", nullable = false)
    private LocalDate dateInscription = LocalDate.now();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_profil", nullable = false)
    private Profil profil;

        @OneToOne(mappedBy = "adherent", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private AdherentQuota quota;


    // Relations
    @OneToMany(mappedBy = "adherent", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Pret> prets;


    @OneToMany(mappedBy = "adherent", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Penalite> penalites;

    // Constructeurs
    public Adherent() {}

    public Adherent(String nom, String prenom, LocalDate dateNaissance, String email, 
                   String motDePasse, Profil profil) {
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
        this.email = email;
        this.motDePasse = motDePasse;
        this.profil = profil;
    }
   
    // Getters et Setters
    public Long getIdAdherent() { return idAdherent; }
    public void setIdAdherent(Long idAdherent) { this.idAdherent = idAdherent; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }

    public Profil getProfil() { return profil; }
    public void setProfil(Profil profil) { this.profil = profil; }

        public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    public LocalDate getDateInscription() { return dateInscription; }
    public void setDateInscription(LocalDate dateInscription) { this.dateInscription = dateInscription; }

    public List<Pret> getPrets() { return prets; }
    public void setPrets(List<Pret> prets) { this.prets = prets; }

    public List<Penalite> getPenalites() { return penalites; }
    public void setPenalites(List<Penalite> penalites) { this.penalites = penalites; }

    // Méthodes utilitaires
    public String getNomComplet() {
        return (prenom != null ? prenom + " " : "") + nom;
    }

    public long getNombreEmpruntsEnCours() {
        if (prets == null) return 0;
        return prets.stream()
            .filter(pret -> pret.getDateRendu() == null)
            .count();
    }

    public boolean peutEmprunter() {
        return getNombreEmpruntsEnCours() < profil.getQuotaMaxEmprunter();
    }
public AdherentQuota getQuota() {
    return quota;
}

public void setQuota(AdherentQuota quota) {
    this.quota = quota;
}

 
}
