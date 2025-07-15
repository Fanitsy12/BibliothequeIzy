package itu.repositories;

import itu.models.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
  boolean existsByExemplaireLivre_IdExemplaireLivreAndDateDebutReservationBetween(
        Long idExemplaire, LocalDate debut, LocalDate fin
    );
@Query("SELECT COUNT(r) FROM Reservation r WHERE EXTRACT(YEAR FROM r.dateReservation) = :annee AND EXTRACT(MONTH FROM r.dateReservation) = :mois")
long countReservationsByMoisAndAnnee(@Param("mois") int mois, @Param("annee") int annee);



}
