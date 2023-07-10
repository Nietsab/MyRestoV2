package en.ensiteck.myresto.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
@Entity
@Table
public class Command {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy = "command", cascade = CascadeType.ALL)
    private List<ProductQuantity> products;

    @ManyToOne
    private User user;

    @Enumerated(EnumType.STRING)
    private CommandStatus status;

    private Date date;

}
