package itu.models;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonProperty;


@Entity
@Table(name = "livre")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idlivre")
    private Long idLivre;

    @Column(nullable = false, length = 255)
    private String titre;

    @Column(length = 255)
    private String auteur;

    @Column(name = "dateedition")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateEdition;


    @ManyToOne(fetch = FetchType.EAGER)
@JoinColumn(name = "idtypelivre")
@JsonManagedReference
private TypeLivre typeLivre;


    @Column(name = "restriction_age")
    private Integer restrictionAge;
    


    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "livrecategorie",
        joinColumns = @JoinColumn(name = "idlivre"),
        inverseJoinColumns = @JoinColumn(name = "idcatlivre")
    )
    @JsonIgnore
    private Set<CategorieLivre> categories = new HashSet<>();

    @OneToMany(mappedBy = "livre", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<ExemplaireLivre> exemplaires;

@JsonProperty("disponible")
public boolean isDisponible() {
    if (exemplaires == null) return false;
    return exemplaires.stream()
        .anyMatch(ex -> {
            String etat = ex.getEtat();
            return etat != null && (
                etat.equalsIgnoreCase("neuf") ||
                etat.equalsIgnoreCase("bon") ||
                etat.equalsIgnoreCase("moyen")
            );
        });
}


    // Constructeurs
    public Livre() {}

    public Livre(String titre, String auteur, Date dateEdition) {
        this.titre = titre;
        this.auteur = auteur;
        this.dateEdition = dateEdition;
      
    }

    // Getters et Setters
    public Long getIdLivre() { return idLivre; }
    public void setIdLivre(Long idLivre) { this.idLivre = idLivre; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getAuteur() { return auteur; }
    public void setAuteur(String auteur) { this.auteur = auteur; }

    public Date getDateEdition() { return dateEdition; }
    public void setDateEdition(Date dateEdition) { this.dateEdition = dateEdition; }

public Integer getRestrictionAge() {
        return restrictionAge;
    }

    // Setter
    public void setRestrictionAge(Integer restrictionAge) {
        this.restrictionAge = restrictionAge;
    }

    public TypeLivre getTypeLivre() { return typeLivre; }
    public void setTypeLivre(TypeLivre typeLivre) { this.typeLivre = typeLivre; }

    public Set<CategorieLivre> getCategories() { return categories; }
    public void setCategories(Set<CategorieLivre> categories) { this.categories = categories; }

    public List<ExemplaireLivre> getExemplaires() { return exemplaires; }
    public void setExemplaires(List<ExemplaireLivre> exemplaires) { this.exemplaires = exemplaires; }

   
    public long getNombreExemplairesDisponibles() {
        if (exemplaires == null) return 0;
        return exemplaires.stream()
            .filter(ex -> "bon".equals(ex.getEtat()) || "moyen".equals(ex.getEtat()))
            .count();
    }

    public Livre orElseThrow(Object object) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'orElseThrow'");
    }






}
