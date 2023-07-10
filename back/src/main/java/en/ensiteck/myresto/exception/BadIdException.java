package en.ensiteck.myresto.exception;

import java.util.List;

public class BadIdException extends Exception{

    List<String> ids;

    public BadIdException(List<String> ids){
        this.ids=ids;
    }

    public List<String> getIds() {
        return ids;
    }
}
