package itu.models;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "Users") // le nom est entre guillemets car c’est un mot réservé en SQL
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iduser")
    private Long idUser;

    @Column(nullable = false, length = 100)
    private String nom;

    @Column(length = 100)
    private String prenom;

    @Column(nullable = false, length = 255)
    private String mdp;

    @Column(nullable = false, unique = true, length = 255)
    private String email;

    @Column(name = "datenaissance")
    private LocalDate dateNaissance;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_profil", nullable = false)
    private Profil profil;

    // Getters & Setters
    public Long getIdUser() { return idUser; }
    public void setIdUser(Long idUser) { this.idUser = idUser; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getMdp() { return mdp; }
    public void setMdp(String mdp) { this.mdp = mdp; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }

    public Profil getProfil() { return profil; }
    public void setProfil(Profil profil) { this.profil = profil; }
}
