package itu.models;

import jakarta.persistence.*;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;


@Entity
@Table(name = "typelivre")
public class TypeLivre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtypelivre")
    private Long idTypeLivre;

    @Column(nullable = false, length = 50, unique = true)
    private String type;

    @OneToMany(mappedBy = "typeLivre", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonBackReference
    private List<Livre> livres;


    // Constructeurs
    public TypeLivre() {}

    public TypeLivre(String type) {
        this.type = type;
    }

    // Getters et Setters
    public Long getIdTypeLivre() { return idTypeLivre; }
    public void setIdTypeLivre(Long idTypeLivre) { this.idTypeLivre = idTypeLivre; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public List<Livre> getLivres() { return livres; }
    public void setLivres(List<Livre> livres) { this.livres = livres; }
}
