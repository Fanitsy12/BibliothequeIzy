package itu.repositories;

import itu.models.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Pageable;


import java.util.List;
import java.util.Optional;

public interface AdherentRepository extends JpaRepository<Adherent, Long> {
    
    @Query("SELECT DISTINCT a FROM Adherent a " +
           "LEFT JOIN FETCH a.profil " +
           "ORDER BY a.nom, a.prenom")
    List<Adherent> findAllWithProfil();

    @Query("SELECT DISTINCT a FROM Adherent a " +
           "LEFT JOIN FETCH a.profil " +
           "LEFT JOIN FETCH a.prets p " +
           "LEFT JOIN FETCH p.exemplaireLivre ex " +
           "LEFT JOIN FETCH ex.livre " +
           "WHERE a.idAdherent = :id")
    Adherent findByIdWithDetails(@Param("id") Long id);

    @Query("SELECT DISTINCT a FROM Adherent a " +
           "LEFT JOIN FETCH a.profil " +
           "LEFT JOIN FETCH a.prets p " +
           "LEFT JOIN FETCH p.exemplaireLivre ex " +
           "LEFT JOIN FETCH ex.livre " +
           "ORDER BY a.nom, a.prenom")
    List<Adherent> findAllWithCurrentPrets();

    @Query("SELECT DISTINCT a FROM Adherent a " +
           "JOIN a.prets p " +
           "WHERE p.dateRendu IS NULL " +
           "ORDER BY a.nom, a.prenom")
    List<Adherent> findAdherentsWithEmpruntsEnCours();

    @Query("SELECT DISTINCT a FROM Adherent a " +
           "JOIN a.prets p " +
           "WHERE p.dateRendu IS NULL " +
           "AND p.dateRenduPrevue < CURRENT_TIMESTAMP " +
           "ORDER BY a.nom, a.prenom")
    List<Adherent> findAdherentsWithEmpruntsEnRetard();

    List<Adherent> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);
    
    List<Adherent> findByProfilIdProfil(Long profilId);

    @Query("SELECT COUNT(DISTINCT a) FROM Adherent a " +
           "WHERE EXISTS (SELECT 1 FROM Pret p WHERE p.adherent = a AND p.dateRendu IS NULL)")
    long countAdherentsWithCurrentPrets();


    boolean existsByEmail(String email);

       Optional<Adherent> findByEmailAndMotDePasse(String email, String motDePasse);
@Query("SELECT COUNT(a) FROM Adherent a " +
       "WHERE EXTRACT(YEAR FROM a.dateInscription) = :annee " +
       "AND EXTRACT(MONTH FROM a.dateInscription) = :mois")
int countAdherentsInscrits(@Param("mois") int mois, @Param("annee") int annee);




}
