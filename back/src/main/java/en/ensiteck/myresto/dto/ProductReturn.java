package en.ensiteck.myresto.dto;

import com.fasterxml.jackson.annotation.JsonView;
import jakarta.persistence.*;

public record ProductReturn(
        @JsonView({Card.class,Command.class})
        Long id,
        @JsonView({Card.class,Command.class})
        String name,
        @JsonView({Card.class,Command.class})
        double price,
        @JsonView(Command.class)
        Long quantity,
        @JsonView({Card.class,Command.class})
        Byte[] image) {

    public ProductReturn(Long id,
                         String name,
                         double price,
                         Byte[] image){
        this(id,name,price,0L,image);
    }
    public static ProductReturn fromEntity(en.ensiteck.myresto.entity.Product product){
        return new ProductReturn(product.getId(),product.getName(),product.getPrice(),product.getImage());
    }
}

