import java.util.*;
import java.sql.*;
import java.math.*;

public class InfoPayementDAO extends DAO<InfoPayement>{
    public InfoPayementDAO(Connection conn){
        super(conn);
    }
    public boolean delete(InfoPayement obj){
        return Requete.deleteFrom("info_payement", obj.createHashTable());
    }
    public boolean update(InfoPayement info){
        return Requete.update("info_payement", info.createHashTable());
    }

    public InfoPayement find(int id){
        InfoPayement info_trouvee = null;
        try{
        ResultSet result = Requete.demander(this.connect, Requete.selectWhere("info_payement", "id", Integer.toString(id)));
        if(result.first()){
            info_trouvee = new InfoPayement(result.getInt("id"), result.getLong("num_compte"), result.getString("type"), result.getInt("id_user"));
        }
        else{ System.out.println("ERR!!! INFO sur le PAYEMENT n'existe pas dans la base!!!"); return null;}
        }catch(SQLException e){ e.printStackTrace(); }
        return info_trouvee;
    }

    public boolean create(InfoPayement obj){
        return Requete.insertInto("info_payement", obj.createHashTable());
    }

    public void modificationInfoPayement(Utilisateur user){
        InfoPayement info_payement = info_payement = this.find(user.getId());
        System.out.println("INSERER...");
        String type = null;
        long num_compte = 0;
        Scanner sc = new Scanner(System.in);
        System.out.print("Type: ");
        type = sc.nextLine();
        while(true){
            System.out.print("Num Compte: ");
            try{
                num_compte = Long.parseLong(sc.nextLine());
                break;
            }catch(NumberFormatException e){e .printStackTrace(); continue; }
        }
        InfoPayement new_info = info_payement;
        new_info.setType(type);
        new_info.setNumCompte(num_compte);
        this.update(new_info);
    }


}//fin classe
