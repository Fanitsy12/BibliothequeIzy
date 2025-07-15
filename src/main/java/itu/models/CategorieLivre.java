
package itu.models;

import jakarta.persistence.*;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.HashSet;

@Entity
@Table(name = "categorielivre")
public class CategorieLivre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcatlivre")
    private Long idCatLivre;

    @Column(nullable = false, length = 50, unique = true)
    private String categorie;

    @ManyToMany(mappedBy = "categories", fetch = FetchType.LAZY)
    @JsonBackReference
    private Set<Livre> livres = new HashSet<>();

    // Constructeurs
    public CategorieLivre() {}

    public CategorieLivre(String categorie) {
        this.categorie = categorie;
    }

    // Getters et Setters
    public Long getIdCatLivre() { return idCatLivre; }
    public void setIdCatLivre(Long idCatLivre) { this.idCatLivre = idCatLivre; }

    public String getCategorie() { return categorie; }
    public void setCategorie(String categorie) { this.categorie = categorie; }

    public Set<Livre> getLivres() { return livres; }
    public void setLivres(Set<Livre> livres) { this.livres = livres; }
}
