package itu.repositories;

import itu.models.PretProlongement;
import itu.models.Pret;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PretProlongementRepository extends JpaRepository<PretProlongement, Long> {
    List<PretProlongement> findByPret(Pret pret);
    List<PretProlongement> findByEstValideFalse(); // Pour la vue admin
}
