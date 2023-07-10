package en.ensiteck.myresto.service;

import en.ensiteck.myresto.dto.Command;
import en.ensiteck.myresto.dto.ProductPost;
import en.ensiteck.myresto.dto.ProductReturn;
import en.ensiteck.myresto.dto.UserReturn;
import en.ensiteck.myresto.entity.CommandStatus;
import en.ensiteck.myresto.entity.ProductQuantity;
import en.ensiteck.myresto.entity.User;
import en.ensiteck.myresto.exception.BadIdException;
import en.ensiteck.myresto.repository.CommandRepository;
import en.ensiteck.myresto.repository.ProductQuantityRepository;
import en.ensiteck.myresto.repository.ProductRepository;
import en.ensiteck.myresto.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CommandService {

    private final CommandRepository commandRepository;
    private final ProductRepository productRepository;
    private final ProductQuantityRepository productQuantityRepository;
    private final UserRepository userRepository;

    public CommandService(CommandRepository commandRepository,UserRepository userRepository,ProductRepository productRepository,ProductQuantityRepository productQuantityRepository){
        this.commandRepository = commandRepository;
        this.userRepository = userRepository;
        this.productRepository=productRepository;
        this.productQuantityRepository = productQuantityRepository;
    }

     @Transactional
    public void createCommand(String userName,List<ProductPost> command) throws BadIdException {
        var commandEntity = new en.ensiteck.myresto.entity.Command();
        commandEntity.setUser(getUser(userName));
        var products = productRepository.findAllById(command.stream().map(ProductPost::id).collect(Collectors.toList()));
        if (products.size() != command.size()){
            var missingId = command.stream().map(ProductPost::id).filter(id ->
                    products.stream()
                            .map(en.ensiteck.myresto.entity.Product::getId)
                            .noneMatch(product -> product.equals(id))
            ).map(Object::toString).collect(Collectors.toList());
            throw new BadIdException(missingId);
        }
        var quantityProduct = products.stream().map(product -> {
            var productPost = command.stream().filter(productCommand-> productCommand.id() == product.getId()).findFirst().get();
            var quantity = new ProductQuantity();
            quantity.setQuantity(productPost.quantity());
            quantity.setProduct(product);
            quantity.setCommand(commandEntity);
            return quantity;
        }).collect(Collectors.toList());
        productQuantityRepository.saveAll(quantityProduct);
        commandEntity.setProducts(quantityProduct);
        commandEntity.setStatus(CommandStatus.PREPARE);
        commandEntity.setDate(Calendar.getInstance().getTime());
        commandRepository.save(commandEntity);
    }

    public List<Command> getCommand(String userName){
        var user =getUser(userName);
        var commands = user.getAdmin() ? commandRepository.findAll() : commandRepository.findByUser(user);

        return commands.stream().map(command -> {
            var products = command.getProducts();
            return new Command(
                    command.getId(),
                    products.stream()
                            .map(product-> new ProductReturn(
                                    product.getProduct().getId(),
                                    product.getProduct().getName(),
                                    product.getProduct().getPrice(),
                                    product.getQuantity(),
                                    product.getProduct().getImage()
                            )).collect(Collectors.toList()),
                    new UserReturn(
                            command.getUser().getLogin(),
                            command.getUser().getFirstname(),
                            command.getUser().getLastname()
                    ),command.getStatus(),command.getDate());
        }).collect(Collectors.toList());
    }

    public void deleteCommand(Long id) throws BadIdException {
        var command = commandRepository.findById(id);
        if (command.isEmpty()){
            throw new BadIdException(List.of(id.toString()));
        }
        commandRepository.delete(command.get());
    }

    public void sendCommand(Long id) throws BadIdException {
        var commandOptional = commandRepository.findById(id);
        if (commandOptional.isEmpty()){
            throw new BadIdException(List.of(id.toString()));
        }
        var command=commandOptional.get();
        command.setStatus(CommandStatus.SEND);
        commandRepository.save(command);
    }

    private User getUser(String userName){
        var user = userRepository.findById(userName);
        if (user.isEmpty()){
            throw new RuntimeException("bad user");
        }
        return user.get();
    }

}
