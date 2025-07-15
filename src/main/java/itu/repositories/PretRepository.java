package itu.repositories;

import itu.models.Pret;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Pageable;


import java.util.List;

public interface PretRepository extends JpaRepository<Pret, Long> {
    
   @Query("SELECT p FROM Pret p JOIN FETCH p.adherent JOIN FETCH p.exemplaireLivre el JOIN FETCH el.livre ")
List<Pret> findAllWithDetails();

    @Query("SELECT p FROM Pret p " +
           "LEFT JOIN FETCH p.adherent " +
           "LEFT JOIN FETCH p.exemplaireLivre ex " +
           "LEFT JOIN FETCH ex.livre " +
           "WHERE p.idPret = :id")
    Pret findByIdWithDetails(@Param("id") Long id);

    @Query("SELECT p FROM Pret p " +
           "LEFT JOIN FETCH p.adherent " +
           "LEFT JOIN FETCH p.exemplaireLivre ex " +
           "LEFT JOIN FETCH ex.livre " +
           "WHERE p.dateRendu IS NULL " +
           "ORDER BY p.dateRenduPrevue ASC")
    List<Pret> findEmpruntsEnCours();

    @Query("SELECT p FROM Pret p " +
           "LEFT JOIN FETCH p.adherent " +
           "LEFT JOIN FETCH p.exemplaireLivre ex " +
           "LEFT JOIN FETCH ex.livre " +
           "WHERE p.dateRendu IS NULL " +
           "AND p.dateRenduPrevue < CURRENT_TIMESTAMP " +
           "ORDER BY p.dateRenduPrevue ASC")
    List<Pret> findEmpruntsEnRetard();

    @Query("SELECT p FROM Pret p " +
           "LEFT JOIN FETCH p.exemplaireLivre ex " +
           "LEFT JOIN FETCH ex.livre " +
           "WHERE p.adherent.idAdherent = :adherentId " +
           "AND p.dateRendu IS NULL " +
           "ORDER BY p.dateEmprunt DESC")
    List<Pret> findEmpruntsEnCoursParAdherent(@Param("adherentId") Long adherentId);

    List<Pret> findByAdherentIdAdherentOrderByDateEmpruntDesc(Long adherentId);

    @Query("SELECT COUNT(p) FROM Pret p WHERE p.dateRendu IS NULL")
    long countEmpruntsEnCours();

    @Query("SELECT COUNT(p) FROM Pret p " +
           "WHERE p.dateRendu IS NULL " +
           "AND p.dateRenduPrevue < CURRENT_TIMESTAMP")
    long countEmpruntsEnRetard();

    @Query("SELECT COUNT(p) FROM Pret p " +
           "WHERE p.adherent.idAdherent = :adherentId " +
           "AND p.dateRendu IS NULL")
    long countEmpruntsEnCoursParAdherent(@Param("adherentId") Long adherentId);

    @Query("SELECT p FROM Pret p " +
           "LEFT JOIN FETCH p.adherent " +
           "LEFT JOIN FETCH p.exemplaireLivre ex " +
           "LEFT JOIN FETCH ex.livre " +
           "WHERE p.dateRendu IS NULL " +
           "AND p.dateRenduPrevue BETWEEN CURRENT_TIMESTAMP AND CURRENT_TIMESTAMP + 3 DAY " +
           "ORDER BY p.dateRenduPrevue ASC")
    List<Pret> findEmpruntsARendreBientot();

     List<Pret> findByAdherentIdAdherent(Long idAdherent);

@Query("SELECT COUNT(p) FROM Pret p WHERE EXTRACT(YEAR FROM p.dateEmprunt) = :annee AND EXTRACT(MONTH FROM p.dateEmprunt) = :mois")
long countPretsByMoisAndAnnee(@Param("mois") int mois, @Param("annee") int annee);


@Query(value = "SELECT a.nom, COUNT(p.idpret) " +
               "FROM pret p " +
               "JOIN adherent a ON p.idadherent = a.idadherent " +
               "WHERE EXTRACT(YEAR FROM p.date_emprunt) = :annee AND EXTRACT(MONTH FROM p.date_emprunt) = :mois " +
               "GROUP BY a.nom " +
               "ORDER BY COUNT(p.idpret) DESC " +
               "LIMIT 3", nativeQuery = true)
List<Object[]> topAdherentsParPret(@Param("mois") int mois, @Param("annee") int annee);


@Query(value = "SELECT l.titre, COUNT(p.idpret) " +
               "FROM pret p " +
               "JOIN exemplairelivre e ON p.idexemplairelivre = e.idexemplairelivre " +
               "JOIN livre l ON e.idlivre = l.idlivre " +
               "WHERE EXTRACT(YEAR FROM p.date_emprunt) = :annee AND EXTRACT(MONTH FROM p.date_emprunt) = :mois " +
               "GROUP BY l.titre " +
               "ORDER BY COUNT(p.idpret) DESC " +
               "LIMIT 3", nativeQuery = true)
List<Object[]> topLivresPretes(@Param("mois") int mois, @Param("annee") int annee);



}
