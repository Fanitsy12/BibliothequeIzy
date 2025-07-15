package itu.repositories;

import itu.models.Abonnement;
import itu.models.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

import java.time.LocalDate;

public interface AbonnementRepository extends JpaRepository<Abonnement, Long> {
   List<Abonnement> findByAdherentIdAdherent(Long idAdherent);

boolean existsByAdherentIdAdherentAndDateFinAfter(Long idAdherent, LocalDate date);


 @Query("SELECT CASE WHEN COUNT(a) > 0 THEN true ELSE false END FROM Abonnement a WHERE " +
       "a.adherent = :adherent AND " +
       "((a.dateDebut BETWEEN :debut AND :fin) OR " +
       "(a.dateFin BETWEEN :debut AND :fin) OR " +
       "(:debut BETWEEN a.dateDebut AND a.dateFin) OR " +
       "(:fin BETWEEN a.dateDebut AND a.dateFin))")
boolean existsByAdherentAndDates(
        @Param("adherent") Adherent adherent,
        @Param("debut") LocalDate debut,
        @Param("fin") LocalDate fin);

 @Query("SELECT CASE WHEN COUNT(a) > 0 THEN true ELSE false END FROM Abonnement a " +
       "WHERE a.adherent = :adherent AND :datePret BETWEEN a.dateDebut AND a.dateFin")
boolean isAbonneAlaDate(
        @Param("adherent") Adherent adherent,
        @Param("datePret") LocalDate datePret);   
        
        Abonnement findTopByAdherentOrderByDateFinDesc(Adherent adherent);


}