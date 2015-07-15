import java.sql.*;
import java.math.*;
import java.util.*;
public class PeripheriqueDAO extends DAO<Peripherique>{
    public PeripheriqueDAO(Connection conn){
        super(conn);
    }
    public boolean delete(Peripherique obj){
        return Requete.deleteFrom("peripherique", obj.createHashTable());
    }
    public boolean update(Peripherique obj){
        return Requete.update("peripherique", obj.createHashTable());
    }

    public Peripherique find(int id){
        Peripherique peripherique = null;
        try{
            ResultSet result = Requete.demander(this.connect, Requete.selectWhere("peripherique", "id", Integer.toString(id)));
            if(result.first()){
                peripherique = new Peripherique(result.getInt("id"), result.getString("nom"), result.getInt("id_se"),
                    result.getString("nom_fabriquant"), result.getInt("id_user"));
            } //id | nom  | id_se | nom_fabriquant | id_user
            //else { System.out.println("ERR!!! Utilisateur n'existe pas dans la base ... "); }
        }catch(SQLException e){ e.printStackTrace(); }
        return peripherique;
    }//fin find

    public boolean create(Peripherique obj){
        return Requete.insertInto("peripherique", obj.createHashTable());
    }

    public void ajouterPeripherique(Utilisateur user, int id_se){
        String nom, nom_fabriquant;
        Scanner sc = new Scanner(System.in);
        boolean reponse = false;
        while(reponse != true){
            System.out.println("\nSELECTIONNER...");
            System.out.print("Nom Peripherique: ");
            nom = sc.nextLine();
            System.out.print("Nom Fabriquant: ");
            nom_fabriquant = sc.nextLine(); //int id, String nom, int id_se, String nom_fabriquant, int id_user
            int nouveau_id_peripherique = 0;
            try{
                ResultSet result = Requete.demander(this.connect, "SELECT MAX(id) FROM peripherique");
                if(result.first())
                    nouveau_id_peripherique = result.getInt("max");
                result.close();
            }catch(SQLException e){ e.printStackTrace(); }
            nouveau_id_peripherique++;
            Peripherique peripherique = new Peripherique(nouveau_id_peripherique, nom, id_se, nom_fabriquant, user.getId());
            reponse = this.create(peripherique);
            ArrayList<Peripherique> liste_peripheriques = user.getListePeripheriques();
            liste_peripheriques.add(peripherique);
            user.setListePeripheriques(liste_peripheriques);
        }//fin while
        //controlli => settano var controllo = false
    }

    public int eliminerPeripherique(Utilisateur user){
        Scanner sc = new Scanner(System.in);
        Peripherique per_actuel = null;
        boolean droit_effacer = false;
        boolean peripherique_effacee = false;
        String str_peripherique, reponse = "ciao";
        int id_peripherique;
        while(!peripherique_effacee){
            System.out.println("EFFACER PERIPHERIQUE....");
            while(true){
                System.out.print("SELECTIONNER ID: ");
                sc = new Scanner(System.in);
                str_peripherique = sc.nextLine();
                try{
                    id_peripherique = Integer.parseInt(str_peripherique);
                }catch(NumberFormatException e){
                    e.printStackTrace();
                    continue;
                }
                for(Peripherique per : user.getListePeripheriques()){
                    if(per.getId() == id_peripherique){
                        droit_effacer = true;
                    }
                }
                if(droit_effacer == true)
                    break;
            }//fin while

            while(!reponse.equals("non") && !reponse.equals("oui")){
                System.out.print("CONFIRMER? : ");
                reponse = sc.nextLine();
            }
            if(reponse.equals("oui")){
                per_actuel = this.find(id_peripherique);
                this.delete(per_actuel);
                peripherique_effacee = true;
                ArrayList<Peripherique> listePeripheriques = this.creerListePeripheriques(user);
                System.out.println(listePeripheriques.size() + "LUNGHEZZA ");
                user.setListePeripheriques(listePeripheriques);
            }//fin if
        }//fin while
        return per_actuel.getIdSe();
    }

    public ArrayList<Peripherique> creerListePeripheriques(Utilisateur user){
        ArrayList<Peripherique> liste_peripheriques = new ArrayList<Peripherique>();
        try{
            String requete = "select peripherique.id, peripherique.nom, id_se, nom_fabriquant, ";
            requete += "id_user from peripherique inner JOIN utilisateur ON (utilisateur.id = peripherique.id_user) where id_user = ";
            requete += user.getId();
            ResultSet result = Requete.demander(this.connect, requete);
            while(result.next()){  //id | nom  | id_se | nom_fabriquant | id_user
                liste_peripheriques.add(new Peripherique(result.getInt("id"), result.getString("nom"), result.getInt("id_se"),
                        result.getString("nom_fabriquant"), result.getInt("id_user")));
            }//fin while
            result.close();
        }catch(SQLException e){ e.printStackTrace(); }
        return liste_peripheriques;
    }//fin méthode
}//fin classe DAO<Peripherique>
