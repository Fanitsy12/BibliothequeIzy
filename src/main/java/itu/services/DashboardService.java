package itu.services;

import itu.repositories.PretRepository;
import itu.repositories.ReservationRepository;
import itu.repositories.AdherentRepository;
import itu.repositories.PenaliteRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class DashboardService {

    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private PenaliteRepository penaliteRepository;

    public Map<String, Object> getStatistiquesMensuelles(int mois, int annee) {
        Map<String, Object> stats = new HashMap<>();


        stats.put("nbPrets", pretRepository.countPretsByMoisAndAnnee(mois, annee));


        stats.put("nbReservations", reservationRepository.countReservationsByMoisAndAnnee(mois, annee));


        stats.put("nbAdherents", adherentRepository.countAdherentsInscrits(mois, annee));


        stats.put("nbPenalites", penaliteRepository.countAdherentsPenalises(mois, annee));


        stats.put("topLivres", pretRepository.topLivresPretes(mois, annee));

        stats.put("topAdherents", pretRepository.topAdherentsParPret(mois, annee));

        return stats;
    }
}
