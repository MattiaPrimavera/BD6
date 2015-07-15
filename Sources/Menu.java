import java.sql.*;
import java.math.*;
import java.util.*;
public abstract class Menu{
    //Fonction Qui gère la totalité de l'interaction avec l'utilisateur de notre programme => Affichage de tous les menu => ça permet de choisir des actiones
    public static void affiche(Utilisateur user, UtilisateurDAO utilisateurDAO, ApplicationDAO applicationDAO,
                               PeripheriqueDAO peripheriqueDAO, SystemeExploitationDAO systemeDAO, InfoPayementDAO infoPayementDAO){
        while(true){
            int choix = -1;
            //on affiche un menu qui diffère selon le type d'utilisateur
            switch(user.getType()){
                case 0:
                    choix = 4;
                    Menu.client();
                    System.out.println("--------------------------------\n0.\tSortir\n");
                    break;
                case 1:
                    choix = 6;
                    Menu.developpeur();
                    System.out.println("--------------------------------\n0.\tSortir\n");
                    break;
                case 2:
                    choix = 10;
                    Menu.gerante();
                    System.out.println("--------------------------------\n0.\tSortir\n");
                    break;
                default:
                    break;
            }
            //Après avoir affiché un Menu de "choix" optiones plus "Sortir", on fait le switch en se servant de la fonction choisir(choix)
            //Pour etre sure que l'utilisateur va pouvoir choisir seulements une des optiones prévues.
            switch(Menu.choisir(choix)){
                case 1:
                    //1. Informations Personnelles (Client)
                    while(true){
                        infoPersonnelles(user);
                        System.out.println("LISTE ACTIONS ---------------");
                        System.out.println("1.\tModifier");
                        System.out.println("2.\tInfos Payement");
                        System.out.println("0.\tMenu Precedent\n");
                        switch(Menu.choisir(2)){
                            case 0: break;
                            case 1:
                                utilisateurDAO.modificationInfosPersonnelles(user);
                                break;
                            case 2:
                                infoPayement(user, utilisateurDAO);
                                switch(choix = Menu.choisir(1)){
                                    case 0: break;
                                    case 1: infoPayementDAO.modificationInfoPayement(user);
                                }
                                break;
                        }
                        if(choix == 0)
                            break;
                    }//fin while
                    break;
                case 2:
                    //2. Mes Peripheriques (Client)
                    Scanner sc = new Scanner(System.in);
                    int id_peripherique = 0;
                    String reponse = "asd";
                    String str_peripherique = "";
                    boolean peripherique_effacee = false;
                    String liste_options_peripheriques = "Liste Ajouter Eliminer";
                    String [] listeOptionsMesPeripheriques = liste_options_peripheriques.split(" ");
                    Hashtable<String,String> listeLignesTable;
                    while(true){
                        choix = 0;
                        Menu.genere(listeOptionsMesPeripheriques ,1, "MES-PERIPHERIQUES");
                        System.out.println("--------------------------------\n0.\tMenu Precedent\n");
                        switch(choix = Menu.choisir(3)){
                            case 0: break;
                            case 1:
                                System.out.println("\n------LISTE PERIPHERIQUES--------");
                                //System.out.println("id_user,\tnom,\tid_se,\tnom_fabriquant,\tid_periph");
                                ArrayList<Peripherique> listeMesPeripheriques = user.getListePeripheriques();
                                Hashtable<String,String> ht3 = listeMesPeripheriques.get(0).createHashTable();
                                Requete.afficheIntestationTable(ht3);
                                //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix\t id_dev\n");
                                for(Peripherique peripherique : listeMesPeripheriques){
                                    //application.affiche();
                                    listeLignesTable = peripherique.createHashTable();
                                    Requete.afficheTable(listeLignesTable);
                                }
                                Requete.afficheFinTable(ht3);
                                System.out.println("\n");
                                break;
                            case 2:
                                System.out.println("\n--------AJOUTER--------");
                                peripheriqueDAO.ajouterPeripherique(user, systemeDAO.ajouterSysteme());
                                break;
                            case 3:
                                systemeDAO.delete(systemeDAO.find(peripheriqueDAO.eliminerPeripherique(user)));
                                break;
                        }//fin switch
                        if(choix == 0)
                            break;
                    }//fin while repetition menu Mes Peripheriques
                    break;
                case 3:
                    ArrayList<Application> liste_filtree = new ArrayList<Application>();
                    String categories = "info utilitaire jeux autre";
                    String[] ensemble_categories = categories.split(" ");
                    ArrayList<String> liste_categories = new ArrayList<String>();
                    for(int i = 0; i<ensemble_categories.length; i++){
                        liste_categories.add(ensemble_categories[i]);
                    }
                    String categorie = "", mot_cle = "";
                    sc = new Scanner(System.in);
                    //3. Recherche d'une application (Client)
                    System.out.println("\n-------Recherche Applications-------");
                    System.out.println("SELECTIONNER...");
                    do{
                        System.out.print("categorie: ");
                        categorie = sc.nextLine();
                        System.out.print("mot-cle: ");
                        mot_cle = sc.nextLine();
                        System.out.println();
                    }while(!liste_categories.contains(categorie));

                    try{
                        ResultSet result = null;
                        if(mot_cle.equals(""))
                            result = Requete.demander(utilisateurDAO.getConnection(), Requete.selectWhere("application", "categorie", categorie));
                        else
                            result = Requete.demander(utilisateurDAO.getConnection(),
                                "select *, mot_cle.type from application inner join mot_cle ON (application.id =  mot_cle.id_application) where mot_cle.type = " + mot_cle + " AND categorie = " + categorie);
                        if(result.first())
                        //int id, int type, String mail, String mot_de_passe, int num_install, String nom, String prenom
                            liste_filtree.add(new Application(result.getInt("id"), result.getString("nom"), result.getInt("prix"),
                                result.getBoolean("abonnement"), result.getInt("num_telechargements"), result.getInt("droits"),
                                result.getString("categorie"), result.getInt("mela"), result.getInt("version"), result.getInt("id_developpeur")));
                        while(result.next()){
                            liste_filtree.add(new Application(result.getInt("id"), result.getString("nom"), result.getInt("prix"),
                                result.getBoolean("abonnement"), result.getInt("num_telechargements"), result.getInt("droits"),
                                result.getString("categorie"), result.getInt("mela"), result.getInt("version"), result.getInt("id_developpeur")));
                        }
                        Requete.afficheIntestationTable(liste_filtree.get(0).createHashTable());
                        //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix\t id_dev\n");
                        for(Application application : liste_filtree){
                            //application.affiche();
                            Requete.afficheTable(application.createHashTable());
                        }
                    }catch(SQLException e){ e.printStackTrace(); }
                    Requete.afficheFinTable(liste_filtree.get(0).createHashTable());
                    System.out.println("\n");
                    break;
                case 4:
                    //4. Liste Mes Application (Client)
                    System.out.println("\n------LISTE MES APPLICATIONS--------");
                    //1       true    jeux    5       Sed nec metus   4       107     9       107
                    //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix");
                    ArrayList<Application> listeApplications = user.getListeApplications();
                    Hashtable<String,String> ht2 = listeApplications.get(0).createHashTable();
                    Requete.afficheIntestationTable(ht2);
                    //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix\t id_dev\n");
                    for(Application application : listeApplications){
                        //application.affiche();
                        listeLignesTable = application.createHashTable();
                        Requete.afficheTable(listeLignesTable);
                    }
                    Requete.afficheFinTable(ht2);
                    System.out.println("\n1.\tDesinstaller");
                    System.out.println("0.\tMenu Precedent");
                    switch(Menu.choisir(1)){
                        case 1:
                            applicationDAO.eliminerApplication(user);
                            break;
                        case 0:
                            break;
                    }
                    break;
                case 5:
                    String liste_options_devel = "Lister Ajouter Mettre_a_Jour";
                    String [] liste_options_dev = liste_options_devel.split(" ");
                    Menu.genere(liste_options_dev, 1, "APPLICATIONS DEVELOPPEES");
                    System.out.println("--------------------------------\n0.\tMenu Precedent\n");
                    switch(Menu.choisir(3)){
                        case 1:
                            System.out.println("\n-----LISTE APPLICATIONS DEVELOPPEES-----");
                            ArrayList<Application> listeApplicationsDevel = null;
                            if(user.getListeApplicationsDevel() != null)
                                 listeApplicationsDevel = user.getListeApplicationsDevel();
                            else{
                                System.out.println("\nVOUS N'AVEZ PAS DEVELOPPE' DES APPLICATIONS POUR L'INSTANT... ");
                                break;
                            }
                            Hashtable<String,String> ht = listeApplicationsDevel.get(0).createHashTable();
                            Requete.afficheIntestationTable(ht);
                            //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix\t id_dev\n");
                            for(Application application : listeApplicationsDevel){
                                //application.affiche();
                                listeLignesTable = application.createHashTable();
                                Requete.afficheTable(listeLignesTable);
                            }
                            Requete.afficheFinTable(ht);
                            System.out.println("\n");
                            break;
                        case 2:
                            System.out.println("------AJOUTER UNE APPLICATION------");
                            applicationDAO.ajouterApplication(user);
                            break;
                        case 3:
                            System.out.println("---------METTRE A' JOUR----------");

                            break;
                        case 0:
                            break;
                        default:
                            break;
                    }//fin switch
                    break;
                case 6:
                    if(user.getListeApplications() == null){
                        System.out.println("\nVOUS N'AVEZ DEVELOPPE' AUCUNE APPLICATION POUR L'INSTANT\n");
                        break;
                    }
                    try{
                        while(true){
                            Menu.genere("Nombre Applis Par Type Peripherique:Application qui vendent le mieux:Notes Moyennes Applis:Profit Total:Profit Applis:FeedBack".split(":"),1,"STATISTIQUES DEVELOPPEUR");
                            System.out.println("--------------------------------\n0.\tMenu Precedent\n");
                            switch(choix = Menu.choisir(6)){
                                case 1:
                                    System.out.println("-------Nombre Applis Par Type Peripherique-------");
                                    Requete.extractionGenerale(utilisateurDAO.getConnection(), "select nom_peripherique, count(v_per_app.id_application) from v_per_app, application where id_developpeur = " + user.getId() + " group by nom_peripherique, application.id_developpeur  order by count DESC limit 10");
                                    break;
                                case 2:
                                    System.out.println("-------Application qui vendent le mieux-------");
                                    Requete.extractionGenerale(utilisateurDAO.getConnection(), "select id, nom, num_telechargements*prix as \"profit\" from application where id_developpeur = " + user.getId() +" order by profit DESC limit 10");
                                    break;
                                case 3:
                                    System.out.println("-------Notes Moyennes Applis-------");
                                    Requete.extractionGenerale(utilisateurDAO.getConnection(), "select id_application, avg, id_developpeur from avg_elstar_app INNER JOIN application on (id_application = application.id) where id_developpeur = " + user.getId());
                                    break;
                                case 4:
                                    System.out.println("-------Profit Total-------");
                                    Requete.extractionGenerale(utilisateurDAO.getConnection(), "select id_developpeur, SUM(num_telechargements*prix) as \"profit total\" from application where id_developpeur = " + user.getId() + " group by id_developpeur");
                                    break;
                                case 5:
                                    System.out.println("-------Profit Applis-------");
                                    Requete.extractionGenerale(utilisateurDAO.getConnection(), "select id, nom, prix, num_telechargements, num_telechargements*prix as \"profit devel\" from application where id_developpeur = " + user.getId() + " group by id_developpeur, application.id order by \"profit devel\" DESC");
                                    break;
                                case 6:
                                    System.out.println("-------FeedBack-------");
                                    Requete.extractionGenerale(utilisateurDAO.getConnection(), "select id_developpeur, AVG(avg) as \"FeedBack\" from avg_app_dev where id_developpeur = " + user.getId() + " group by id_developpeur");
                                    break;
                                case 0:
                                    break;
                            }//switch
                            if(choix == 0)
                                break;
                        }//fin while
                    }catch(NullPointerException e){ System.out.println("\nAUCUN RESULTAT TROUVE'\n"); }
                    break;
                case 7:
                    System.out.println("\n------MEUILLEURS VENTES-------");
                    Requete.extractionGenerale(utilisateurDAO.getConnection(), "select id, id_developpeur, prix, nom, categorie, num_telechargements*prix as \"profit\" from application order by profit desc limit 15");
                    break;
                case 8:
                    choix = -1;
                    while(true){
                        Menu.genere("Peripheriques Applications".split(" "), 1, "STATISTIQUES");
                        System.out.println("--------------------------------\n0.\tMenu Precedent\n");
                        switch(Menu.choisir(2)){
                            case 1:
                                choix = -1;
                                while(true){
                                    Menu.genere("Numéro Peripheriques:Fabriquant plus Populaires:Peripherique plus populaire".split(":"), 1, "STAT PERIPHERIQUES");
                                    System.out.println("--------------------------------\n0.\tMenu Precedent\n");
                                    ResultSet result = null;
                                    try{
                                        switch(choix = Menu.choisir(3)){
                                            case 0:
                                                break;
                                            case 1:
                                                System.out.println("----------NUMERO PERIPHERIQUES---------");
                                                result = Requete.demander(utilisateurDAO.getConnection(), "SELECT COUNT(id) FROM peripherique");
                                                if(result.first())
                                                    System.out.println("NUMERO PERIPHERIQUES = " + result.getInt("count"));
                                                break;
                                            case 2:
                                                System.out.println("----------FABRIQUANT PLUS POPULAIRE---------");
                                                Requete.extractionGenerale(utilisateurDAO.getConnection(), "select nom_fabriquant, COUNT(nom_fabriquant) from peripherique GROUP BY nom_fabriquant order by count DESC");
                                                break;
                                            case 3:
                                                System.out.println("----------PERIPHERIQUES PLUS POPULAIRES---------");
                                                Requete.extractionGenerale(utilisateurDAO.getConnection(), "select nom, COUNT(nom) from peripherique GROUP BY nom order by count DESC limit 15");
                                                break;
                                        }
                                    }catch(SQLException e){ e.printStackTrace(); }
                                    if(choix == 0)
                                        break;
                                }//fin while
                                break;
                            case 2:
                                break;
                            case 0:
                                break;
                        }//fin switch
                        if(choix == 0)
                            break;
                    }//fin while
                    break;
                case 9:
                    String liste_options = "Clients Developpeurs Gerants";
                    String[] liste_ops = liste_options.split(" ");
                    Menu.genere(liste_ops, 1, "LISTE UTILISATEURS");
                    System.out.println("--------------------------------\n0.\tMenu Precedent\n");
                    ArrayList<Utilisateur> liste_users = null;
                    switch(Menu.choisir(3)){
                        case 1:
                            liste_users = new ArrayList<Utilisateur>();
                            listeLignesTable = user.createHashTable();
                            try{
                                ResultSet result = Requete.demander(utilisateurDAO.getConnection(), Requete.selectWhere("utilisateur", "type", "0"));
                                if(result.first())
                                //int id, int type, String mail, String mot_de_passe, int num_install, String nom, String prenom
                                    liste_users.add(new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
                                        result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom")));
                                while(result.next()){
                                    liste_users.add(new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
                                        result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom")));
                                }
                                Requete.afficheIntestationTable(listeLignesTable);
                                //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix\t id_dev\n");
                                for(Utilisateur utilisateur : liste_users){
                                    //application.affiche();
                                    Requete.afficheTable(utilisateur.createHashTable());
                                }
                            }catch(SQLException e){ e.printStackTrace(); }
                            Requete.afficheFinTable(listeLignesTable);
                            System.out.println("\n");
                            break;
                        case 2:
                            liste_users = new ArrayList<Utilisateur>();
                            listeLignesTable = user.createHashTable();
                            try{
                                ResultSet result = Requete.demander(utilisateurDAO.getConnection(), Requete.selectWhere("utilisateur", "type", "1"));
                                if(result.first())
                                //int id, int type, String mail, String mot_de_passe, int num_install, String nom, String prenom
                                    liste_users.add(new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
                                        result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom")));
                                while(result.next()){
                                    liste_users.add(new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
                                        result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom")));
                                }
                                Requete.afficheIntestationTable(listeLignesTable);
                                //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix\t id_dev\n");
                                for(Utilisateur utilisateur : liste_users){
                                    //application.affiche();
                                    Requete.afficheTable(utilisateur.createHashTable());
                                }
                            }catch(SQLException e){ e.printStackTrace(); }
                            Requete.afficheFinTable(listeLignesTable);
                            System.out.println("\n");

                            String [] liste_options_92 = {"Radier", "Meuilleur_Developpeur"};
                            Menu.genere(liste_options_92, 1, "OPERATIONS DISPONIBLES");
                            System.out.println("--------------------------------\n0.\tMenu Precedent\fn");
                            switch(Menu.choisir(2)){
                                case 1:
                                    sc = new Scanner(System.in);
                                    int id_choisi = 0;
                                    while(true){
                                        System.out.println("RADIER UN DEVELOPPEUR...\nSELECTIONNER ID : ");
                                        try{
                                            id_choisi = Integer.parseInt(sc.nextLine());
                                        }
                                        catch(NumberFormatException e){ e.printStackTrace(); break; }
                                    }
                                    try{
                                        Statement state = SdzConnection.getInstance().createStatement();
                                        int nbMax = state.executeUpdate("DELETE FROM utilisateur WHERE id = " + id_choisi);
                                        System.out.println("nb mise a jour = " + nbMax);
                                        state.close();
                                    }
                                    catch(SQLException e)
                                    {
                                        e.printStackTrace();
                                    }
                                case 2:
                                    String[] liste_options_922 = {"Nombre App Developees", "Meilleur Feedback", "Nombre Telechargements", "Meuilleur Profit"};
                                    while(true){
                                        Menu.genere(liste_options_922, 1, "MEUILLEUR DEVELOPPEUR");
                                        System.out.println("--------------------------------\n0.\tMenu Precedent\n");
                                        int arriere = -1;
                                        switch(Menu.choisir(4)){
                                            case 1:
                                                System.out.println("-----MEILLEUR POUR NOMBRE APPS DEVELOPPEES----");
                                                Requete.extractionGenerale(utilisateurDAO.getConnection(), "select * from num_app_developpee order by count DESC limit 10");
                                                break;
                                            case 2:
                                                System.out.println("----------MEILLEUR FEEDBACK--------");
                                                Requete.extractionGenerale(utilisateurDAO.getConnection(),"select id_developpeur, AVG(avg) from avg_app_dev GROUP BY id_developpeur order by avg DESC");
                                                break;
                                            case 3:
                                                System.out.println("\n------MEILLEUR POUR NOMBRE TELECHARGEMENTS-----");
                                                Requete.extractionGenerale(utilisateurDAO.getConnection(),"select distinct id_developpeur, id, nom,  prix, num_telechargements from application order by num_telechargements DESC limit 15");
                                                System.out.println();
                                                break;
                                            case 4:
                                                System.out.println("----MEUILLEUR POUR PROFIT------");
                                                Requete.extractionGenerale(utilisateurDAO.getConnection(),"select * from profit_dev limit 10");
                                                break;
                                            case 0:
                                                arriere = 0;
                                                break;
                                        }//fin switch
                                        if(arriere == 0)
                                            break;
                                    }//fin while qui introduit le switch juste avant ...
                                case 0:
                                    break;
                            }//fin switch menu radier developpeur ou meuilleur developpeur
                            break;
                        case 3:
                            liste_users = new ArrayList<Utilisateur>();
                            listeLignesTable = user.createHashTable();
                            try{
                                ResultSet result = Requete.demander(utilisateurDAO.getConnection(), Requete.selectWhere("utilisateur", "type", "2"));
                                if(result.first())
                                //int id, int type, String mail, String mot_de_passe, int num_install, String nom, String prenom
                                    liste_users.add(new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
                                        result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom")));
                                while(result.next()){
                                    liste_users.add(new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
                                        result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom")));
                                }
                                Requete.afficheIntestationTable(listeLignesTable);
                                //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix\t id_dev\n");
                                for(Utilisateur utilisateur : liste_users){
                                    //application.affiche();
                                    Requete.afficheTable(utilisateur.createHashTable());
                                }
                            }catch(SQLException e){ e.printStackTrace(); }
                            Requete.afficheFinTable(listeLignesTable);
                            System.out.println("\n");
                            break;
                        case 0:
                            break;
                    }//fin switch Menu Affichage Utilisateurs (Gerant)
                    break; //case 9 termine ici
                case 10:
                    int profit = 0;
                    try{
                        ResultSet result = Requete.demander(utilisateurDAO.getConnection(),
                            "select SUM(num_telechargements*mela/80)/100*30 AS \"profit\" from application limit 10");
                        if(result.first())
                            profit = result.getInt("profit");
                        System.out.println("\n----------------------------------------\nPROFIT GERANTES = " + profit+ " euros \n----------------------------------------");
                    }catch(SQLException e){ e.printStackTrace(); }
                    break;
                case 0:
                    //Sortie Du Programme (Dernière Option => existant pour tous les type d'utilisateurs)
                    System.exit(0);
                    break;
                default:
                    break;
                }//fin switch
        }//fin while
    }//fin méthode

    //Fonction qui boucle jusqu'à on n'a pas inseré un intier entre 0 et index_fin (inclu)
    public static int choisir(int index_fin){
        int choix = -1;
        String tmp = null;
        Scanner sc = new Scanner(System.in);
        while(!((choix >= 0) && (choix <= index_fin))){
            System.out.print("Choix: ");
            tmp = sc.nextLine();
            try{
                choix = Integer.parseInt(tmp);
            }catch(NumberFormatException e){ e.printStackTrace(); }
        }//fin while
        return choix;
    }//fin méthode choisir

    //Fonction qui genere le menu du client à travers de la fonction genere()
    public static void client(){
        String[] listeOptionsClient = {"Info Personnelles", "Mes Peripheriques",
        "Recherche Application", "Liste Applications"};
        genere(listeOptionsClient, 1, "CLIENT");
    }
    //Fonction qui genere le menu du developpeur à travers "genere()"
    public static void developpeur(){
        String[] listeOptionsDeveloppeur = {"Applications Developpees",
            "Statistiques"};
        client();
        genere(listeOptionsDeveloppeur, 5, "DEVELOPPEUR");
    }
    //Fonction qui genere le menu du gerante à travers "genere()"
    public static void gerante(){
        String[] listeOptionsGerante = {"Meilleurs Ventes", "Statistiques",
            "Liste Utilisateurs", "Profit"};
        developpeur();
        genere(listeOptionsGerante, 7, "GERANTE");
    }

    //Fonction generation menu automatique
    private static void genere(String [] liste_options, int index_debut, String type){
        System.out.println("------------"+type+"-----------");
        int index = index_debut;
        for(String tmp : liste_options){
            System.out.println(index + ".\t" + tmp);
            index++;
        }
    }//fin methode

    //Fonction utilisée pour la création du sous-menu "Info Personnelles" (Visible à tous les types d'utilisateurs)
    public static void infoPersonnelles(Utilisateur user){
        System.out.println("----------------------INFOS PERSONNELLES-----------------------");
        Requete.afficheIntestationTable(user.createHashTable());
        Requete.afficheTable(user.createHashTable());
        Requete.afficheFinTable(user.createHashTable());
    }

    public static void infoPayement(Utilisateur user, UtilisateurDAO utilisateurDAO){
        String requete = "SELECT * from info_payement Where id_user = " + user.getId();
        InfoPayement info = null;
        ResultSet result = null;
        try{
            result = Requete.demander(utilisateurDAO.getConnection(), requete);
            if(result.first()){
                info = new InfoPayement(result.getInt("id"), result.getLong("num_compte"), result.getString("type"), result.getInt("id_user"));
            }
        }catch(SQLException e){ e.printStackTrace(); }
        System.out.println("----------------------INFOS PAYEMENT-----------------------");
        Requete.afficheIntestationTable(info.createHashTable());
        Requete.afficheTable(info.createHashTable());
        Requete.afficheFinTable(info.createHashTable());
        System.out.println("\nLISTE ACTIONS ---------------");
        System.out.println("1.\tModifier");
        System.out.println("0.\tMenu Precedent\n");
    }


}//fin classe Menu
