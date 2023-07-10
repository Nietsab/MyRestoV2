package en.ensiteck.myresto.service;

import en.ensiteck.myresto.dto.User;
import en.ensiteck.myresto.exception.UserExisteException;
import en.ensiteck.myresto.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder){
        this.userRepository=userRepository;
        this.passwordEncoder=passwordEncoder;
    }

    public void createUser(User user) throws UserExisteException {
        var userEntity = new en.ensiteck.myresto.entity.User();
        if (userRepository.findById(user.login()).isPresent()){
            throw new UserExisteException();
        }
        userEntity.setLogin(user.login());
        userEntity.setPassword(passwordEncoder.encode(user.password()));
        userEntity.setLastname(user.lastname());
        userEntity.setFirstname(user.firstname());
        userEntity.setAdmin(false);
        userEntity.setEmail(user.email());
        userEntity.setAddress(user.address());
        userRepository.save(userEntity);
    }

}
