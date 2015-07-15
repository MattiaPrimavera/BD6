import java.sql.Connection;

public abstract class DAO<T>{
    protected Connection connect = null;
    //ça serait utilisé avec la classe SdzConnection dont la méthode getInstance() nous retourne un objet Connection!
    //La connexion à la BDD sera effectué seulement une fois pendant l'exécution du programme!
    public DAO(Connection conn){
        this.connect = conn;
    }
    public abstract boolean create(T obj);
    public abstract boolean delete(T obj);
    public abstract boolean update(T obj);
    public abstract T find(int id);
    //public abstract T find(String type);
}
