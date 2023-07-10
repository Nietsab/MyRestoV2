package en.ensiteck.myresto.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Data
@Entity
@Table(name = "user_resto")
public class User {

    @Id
    private String login;

    private String firstname;

    private String lastname;

    private String password;

    private String email;

    private String address;

    private Boolean admin;
}
