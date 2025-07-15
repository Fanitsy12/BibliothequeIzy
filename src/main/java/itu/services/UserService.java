package itu.services;

import itu.models.User;
import itu.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public Optional<User> login(String email, String mdp) {
        return userRepository.findByEmailAndMdp(email, mdp);
    }
}
