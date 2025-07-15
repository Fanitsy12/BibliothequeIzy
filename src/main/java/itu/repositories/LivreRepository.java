package itu.repositories;

import itu.models.Livre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Pageable;


import java.util.List;
import java.util.Optional;

public interface LivreRepository extends JpaRepository<Livre, Long> {
 @Query("SELECT l FROM Livre l LEFT JOIN FETCH l.exemplaires")
List<Livre> findAllWithExemplaires();   

@Query("SELECT DISTINCT l FROM Livre l LEFT JOIN FETCH l.categories WHERE " +
       "(:titre IS NULL OR LOWER(l.titre) LIKE LOWER('%' || CAST(:titre AS text) || '%')) " +
       "AND (:auteur IS NULL OR LOWER(l.auteur) LIKE LOWER('%' || CAST(:auteur AS text) || '%')) " +
       "AND (:annee IS NULL OR EXTRACT(YEAR FROM l.dateEdition) = :annee) " +
       "AND (:typeId IS NULL OR l.typeLivre.id = :typeId)")
List<Livre> rechercherLivres(
    @Param("titre") String titre,
    @Param("auteur") String auteur,
    @Param("annee") Integer annee,
    @Param("typeId") Long typeId
);

  @Query("SELECT DISTINCT l FROM Livre l JOIN FETCH l.categories c WHERE c.id IN :categories")
List<Livre> rechercherLivresParCategories(@Param("categories") List<Long> categories);

@Query("SELECT p.exemplaireLivre.livre.titre, COUNT(p) as nb FROM Pret p WHERE FUNCTION('YEAR', p.dateEmprunt) = :annee AND FUNCTION('MONTH', p.dateEmprunt) = :mois GROUP BY p.exemplaireLivre.livre.titre ORDER BY nb DESC")
List<Object[]> topLivresPretes(@Param("mois") int mois, @Param("annee") int annee, Pageable pageable);

// Méthode pour récupérer un livre avec ses exemplaires (fetch join pour éviter le lazy loading)
    @Query("SELECT l FROM Livre l LEFT JOIN FETCH l.exemplaires WHERE l.idLivre = :id")
    Optional<Livre> findByIdWithExemplaires(@Param("id") Long id);


}
