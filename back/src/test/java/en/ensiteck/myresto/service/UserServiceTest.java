package en.ensiteck.myresto.service;

import en.ensiteck.myresto.dto.User;
import en.ensiteck.myresto.exception.UserExisteException;
import en.ensiteck.myresto.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
@Transactional
class UserServiceTest {

    @Autowired
    UserService userService;

    @Autowired
    UserRepository userRepository;

    @Test
    void checkIfPasswordWasEncrypt() throws UserExisteException {
        var user = new User("userCreate","user","user","test","email","address");
        userService.createUser(user);
        var userBase = userRepository.findById("userCreate");
        assertThat(userBase).isNotEmpty().get().extracting("password").isNotEqualTo("test");
    }

    @Test
    void cantCreateExistingUser(){
        var user = new User("admin","user","user","test","email","address");
        assertThrows(UserExisteException.class,()->userService.createUser(user));
    }

}