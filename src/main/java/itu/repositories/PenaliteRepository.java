package itu.repositories;

import itu.models.Penalite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PenaliteRepository extends JpaRepository<Penalite, Long> {
    List<Penalite> findByAdherentIdAdherent(Long idAdherent);
    boolean existsByAdherent_IdAdherentAndLeveFalse(Long idAdherent);


@Query("SELECT COUNT(p) FROM Penalite p WHERE " +
       "EXTRACT(YEAR FROM p.dateDebutPenalite) = :annee AND " +
       "EXTRACT(MONTH FROM p.dateDebutPenalite) = :mois AND " +
       "p.leve = false")
int countAdherentsPenalises(@Param("mois") int mois, @Param("annee") int annee);


List<Penalite> findByAdherentIdAdherentAndLeveFalse(Long idAdherent);


}
