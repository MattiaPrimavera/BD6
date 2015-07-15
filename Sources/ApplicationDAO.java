import java.sql.*;
import java.math.*;
import java.util.*;

public class ApplicationDAO extends DAO<Application>{
    public ApplicationDAO(Connection conn){
        super(conn);
    }
    public boolean delete(Application obj){
        return Requete.deleteFrom("application", obj.createHashTable());
    }
    public boolean update(Application obj){
        return Requete.update("application", obj.createHashTable());
    }

    //id, id_categorie, versio, prix, abonnements, num_telechargements, nom
    public Application find(int id){
        Application application = null;
        try{
            ResultSet result; //int id, int id_categorie, int version, int prix, boolean abonnement, int num_telechargements, String nom
            if((result = Requete.demander(this.connect, Requete.selectWhere("application", "id", Integer.toString(id))))!=null){
                application = new Application(result.getInt("id"), result.getString("nom"), result.getInt("prix"),
                        result.getBoolean("abonnement"), result.getInt("num_telechargements"), result.getInt("droits"),
                        result.getString("categorie"), result.getInt("mela"), result.getInt("version"), result.getInt("id_developpeur")
                    );
            }
            result.close();
            //else { System.out.println("ERR!!! Utilisateur n'existe pas dans la base ... "); }
        }catch(SQLException e){ e.printStackTrace(); }
        return application;
    }//fin find

    public boolean create(Application obj){
        if(this.find(obj.getId()) == null){
            return Requete.insertInto("application", obj.createHashTable());
        }
        else
            return false;
    }

    public ArrayList<Application> creerListeApplicationsDevel(Utilisateur user){
        ArrayList<Application> liste_applications_devel = new ArrayList<Application>();
        try{
            ResultSet result = Requete.demander(this.connect, Requete.selectWhere("application", "id_developpeur", Integer.toString(user.getId())));
            if(result.first())
                liste_applications_devel.add(new Application(result.getInt("id"), result.getString("nom"), result.getInt("prix"),
                        result.getBoolean("abonnement"), result.getInt("num_telechargements"), result.getInt("droits"),
                        result.getString("categorie"), result.getInt("mela"), result.getInt("version"), result.getInt("id_developpeur")));
            while(result.next()){
                liste_applications_devel.add(new Application(result.getInt("id"), result.getString("nom"), result.getInt("prix"),
                        result.getBoolean("abonnement"), result.getInt("num_telechargements"), result.getInt("droits"),
                        result.getString("categorie"), result.getInt("mela"), result.getInt("version"), result.getInt("id_developpeur")));
            }
            result.close();
        }catch(SQLException e){ e.printStackTrace(); }
        return liste_applications_devel;
    }//fin méthode


    public ArrayList<Application> creerListeApplications(Utilisateur user){
        ArrayList<Application> liste_applications = new ArrayList<Application>();
        String requete = "SELECT application.id, application.nom, prix, abonnement, num_telechargements, droits, categorie, mela, version, id_developpeur" +
                        " FROM application " +
                        "INNER JOIN liste_applications ON (application.id = id_application) where id_user = " + user.getId();
        try{
            ResultSet result = Requete.demander(this.connect, requete);
            if(result.first())
                liste_applications.add(new Application(result.getInt("id"), result.getString("nom"), result.getInt("prix"),
                        result.getBoolean("abonnement"), result.getInt("num_telechargements"), result.getInt("droits"),
                        result.getString("categorie"), result.getInt("mela"), result.getInt("version"), result.getInt("id_developpeur")));
            while(result.next()){
                liste_applications.add(new Application(result.getInt("id"), result.getString("nom"), result.getInt("prix"),
                        result.getBoolean("abonnement"), result.getInt("num_telechargements"), result.getInt("droits"),
                        result.getString("categorie"), result.getInt("mela"), result.getInt("version"), result.getInt("id_developpeur")));
            }
            result.close();
        }catch(SQLException e){ e.printStackTrace(); }

        return liste_applications;
    }//fin méthode

    //Permet à l'utilisateur d'inserer les info necessaire pour ajouter une appli dans la base
    //=> appelle la fonction create() qui s'occupe de la mise à jour effective de la base...
    public void ajouterApplication(Utilisateur user){
        String nom, categorie, abonnement_str;
        int id, prix, num_telechargements, droits, mela, version;
        boolean abonnement = false;
        Scanner sc = new Scanner(System.in);
        boolean reponse = false;
        String continuer = "";
        while(reponse != true){
            System.out.println("\nSELECTIONNER...");
            System.out.print("Nom Application: ");
            nom = sc.nextLine();
            System.out.print("Categorie: ");
            categorie = sc.nextLine();
            while(true){
                try{
                    System.out.print("Prix: ");
                    prix = Integer.parseInt(sc.nextLine());
                    System.out.print("Num_Telech: ");
                    num_telechargements = Integer.parseInt(sc.nextLine());
                    System.out.print("Droits: ");
                    droits = Integer.parseInt(sc.nextLine());
                    System.out.print("Mela: ");
                    mela = Integer.parseInt(sc.nextLine());
                    System.out.print("Version: ");
                    version = Integer.parseInt(sc.nextLine());
                }catch(NumberFormatException e){ e.printStackTrace(); continue; }
                break;
            }//fin while
            while(true){
                System.out.print("Abonnement: ");
                abonnement_str = sc.nextLine();
                if(abonnement_str.equals("oui")){
                    abonnement = true;
                    break;
                }
                else if(abonnement_str.equals("non")){
                    abonnement = false;
                    break;
                }
                else
                    continue;
            }
            int nouveau_id_app = 0;
            // id | nom | prix | abonnement | num_telechargements | droits | categorie | mela | version | id_developpeur

            try{
                ResultSet result = Requete.demander(this.connect, "select MAX(id_application) from liste_applications");
                if(result.first())
                    nouveau_id_app = result.getInt("max");
                result.close();
            }catch(SQLException e){ e.printStackTrace(); }
            nouveau_id_app++;
            Application application = new Application(nouveau_id_app, nom, prix, abonnement, num_telechargements, droits,
                                                    categorie, mela, version, user.getId());
            while(!continuer.equals("oui") && !continuer.equals("non")){
                System.out.print("CONFIRMER AJOUTE? : ");
                continuer = sc.nextLine();
            }
            if(continuer.equals("oui")){
                reponse = this.create(application);
                // => AGGIUNGI ALLA LISTA APPLICAZIONI PURE!
                break;
            }
            else if(continuer.equals("non"))
                break;
            else
                continue;
        }//fin while
        //controlli => settano var controllo = false
    }


    public void eliminerApplication(Utilisateur user){
        Scanner sc = new Scanner(System.in);
        Application app_actuel = null;
        boolean droit_effacer = false;
        boolean application_effacee = false;
        String str_application, reponse = "ciao";
        int id_application;
        while(!application_effacee){
            System.out.println("ELIMINATION APPLICATION....");
            while(true){
                System.out.print("SELECTIONNER ID ( -1 pour sortir) : ");
                sc = new Scanner(System.in);
                str_application = sc.nextLine();
                try{
                    id_application = Integer.parseInt(str_application);
                }catch(NumberFormatException e){
                    e.printStackTrace();
                    continue;
                }
                if(id_application == -1)
                    break;
                for(Application app : user.getListeApplications()){
                    if(app.getId() == id_application){
                        droit_effacer = true;
                    }
                }
                if(droit_effacer == true)
                    break;
            }//fin while
            if(id_application == -1)
                    break;
            while(!reponse.equals("non") && !reponse.equals("oui")){
                System.out.print("CONFIRMER? : ");
                reponse = sc.nextLine();
            }
            if(reponse.equals("oui")){
                String requete = "DELETE FROM liste_applications WHERE id_application = " + id_application + " AND id_user = " + user.getId();
                try{
                    Statement state = SdzConnection.getInstance().createStatement();
                    int nbMax = state.executeUpdate(requete);
                    System.out.println("nb mise a jour = " + nbMax);
                    state.close();
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                }
                application_effacee = true;
                ArrayList<Application> listeApplications = this.creerListeApplications(user);
                System.out.println(listeApplications.size() + "LUNGHEZZA ");
                user.setListeApplications(listeApplications);
            }//fin if
        }//fin while
    }
    //int id, String nom, int prix, boolean abonnement, int num_telechargements, int droits, String categorie, int mela, int version, int id_developpeur
    public void modificationInfoApplication(Application app){
        System.out.println("INSERER...");
        String nom, categorie;
        ArrayList<String> liste_categories = new ArrayList<String>();
        String[] array_categories = "info:utilitaire:autre:jeux".split(":");
        for(int i = 0; i<liste_categories.size(); i++){
            liste_categories.add(array_categories[i]);
        }
        int prix, droits, mela, version;
        Scanner sc = new Scanner(System.in);
        System.out.print("NOM APP: ");
        nom = sc.nextLine();
        while(true){
            System.out.print("CATEGORIE: ");
            System.out.print("Choisir la categorie entre: ");
            for(String tmp : liste_categories){
                System.out.print(tmp + ";");
            }
            System.out.println();
            categorie = sc.nextLine();
            if(liste_categories.contains(categorie))
                break;
            else
                System.out.println("Choix impossible!");
        }//fin while
        while(true){
            try{
                System.out.print("PRIX: ");
                prix = Integer.parseInt(sc.nextLine());
                System.out.print("DROITS: ");
                droits = Integer.parseInt(sc.nextLine());
                System.out.print("MELA: ");
                mela = Integer.parseInt(sc.nextLine());
                System.out.print("VERSION: ");
                version = Integer.parseInt(sc.nextLine());
                break;
            }catch(NumberFormatException e){ e.printStackTrace(); continue; }
        }
        Application new_app = app;
        app.setNom(nom);
        app.setCategorie(categorie);
        app.setPrix(prix);
        app.setDroits(droits);
        app.setMela(mela);
        app.setVersion(version);
        this.update(new_app);
    }//fin méthode modification
}//fin classe DAO<Peripherique>
