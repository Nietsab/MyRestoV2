package en.ensiteck.myresto.service;

import en.ensiteck.myresto.dto.Card;
import en.ensiteck.myresto.dto.ProductReturn;
import en.ensiteck.myresto.entity.ProductType;
import en.ensiteck.myresto.repository.ProductRepository;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;

@Service
public class CardService {

    private ProductRepository productRepository;
    public CardService(ProductRepository productRepository){
        this.productRepository = productRepository;
    }

    public Card getCard(){
        var product = productRepository.findAll();
        return new Card(product.stream().filter(product1 -> product1.getType() == ProductType.ENTRY).map(ProductReturn::fromEntity).collect(Collectors.toList()),
                product.stream().filter(product1 -> product1.getType() == ProductType.MAIN).map(ProductReturn::fromEntity).collect(Collectors.toList()),
                product.stream().filter(product1 -> product1.getType() == ProductType.DESSERT).map(ProductReturn::fromEntity).collect(Collectors.toList()),
                product.stream().filter(product1 -> product1.getType() == ProductType.DRINK).map(ProductReturn::fromEntity).collect(Collectors.toList())
        );
    }
}