package en.ensiteck.myresto.repository;

import en.ensiteck.myresto.entity.Command;
import en.ensiteck.myresto.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommandRepository extends JpaRepository<Command, Long> {

    List<Command> findByUser(User user);
}
