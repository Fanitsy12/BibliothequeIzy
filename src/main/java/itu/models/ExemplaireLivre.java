// ExemplaireLivre.java
package itu.models;

import jakarta.persistence.*;
import java.util.Date;
import java.util.List;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "exemplairelivre")
public class ExemplaireLivre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idexemplairelivre")
    private Long idExemplaireLivre;

    @ManyToOne(fetch = FetchType.EAGER)
    @JsonBackReference // pour éviter la récursion infinie lors de la sérialisation JSON
    @JoinColumn(name = "idlivre", nullable = false)
    private Livre livre;


    @Column(name = "codebarre", length = 50, unique = true)
    private String codeBarre;

    @Column(name = "dateacquisition")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateAcquisition;

    @Column(length = 20)
    private String etat = "bon";

    @Column(name = "status")
private Integer status = 1;

    @OneToMany(mappedBy = "exemplaireLivre", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private List<Pret> prets;

    // Constructeurs
    public ExemplaireLivre() {}

    public ExemplaireLivre(Livre livre, String codeBarre, Date dateAcquisition, String etat) {
        this.livre = livre;
        this.codeBarre = codeBarre;
        this.dateAcquisition = dateAcquisition;
        this.etat = etat;
    }

    // Getters et Setters
    public Long getIdExemplaireLivre() { return idExemplaireLivre; }
    public void setIdExemplaireLivre(Long idExemplaireLivre) { this.idExemplaireLivre = idExemplaireLivre; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }

    public String getCodeBarre() { return codeBarre; }
    public void setCodeBarre(String codeBarre) { this.codeBarre = codeBarre; }

public Integer getStatus() { return status; }
public void setStatus(Integer status) { this.status = status; }

    public Date getDateAcquisition() { return dateAcquisition; }
    public void setDateAcquisition(Date dateAcquisition) { this.dateAcquisition = dateAcquisition; }

    public String getEtat() { return etat; }
    public void setEtat(String etat) { this.etat = etat; }

    public List<Pret> getPrets() { return prets; }
    public void setPrets(List<Pret> prets) { this.prets = prets; }

    // Méthodes utilitaires
@JsonIgnore
public boolean isDisponible() {
    return status == 1 &&
           etat != null &&
           (
               "neuf".equalsIgnoreCase(etat) ||
               "bon".equalsIgnoreCase(etat) ||
               "moyen".equalsIgnoreCase(etat)
           ) &&
           (prets == null || prets.stream().noneMatch(pret -> pret.getDateRendu() == null));
}




}