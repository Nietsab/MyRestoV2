package en.ensiteck.myresto.security;

import en.ensiteck.myresto.repository.UserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class JpaUserDetailService implements UserDetailsService {

    private UserRepository userRepository;

    public JpaUserDetailService(UserRepository userRepository){
        this.userRepository=userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findById(username).map(SecurityUser::new).orElseThrow(()-> new UsernameNotFoundException(("Username not found: "+ username)));
    }
}
