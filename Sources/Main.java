import java.util.*;

public class Main{
    public static void main(String [] args){
        UtilisateurDAO utilisateurDAO = null;
        ApplicationDAO applicationDAO = null;
        SystemeExploitationDAO systemeDAO = null;
        PeripheriqueDAO peripheriqueDAO = null;
        InfoPayementDAO infoPayementDAO = null;
        //Charger les drivers pour interagir avec la Base
        try{
            Class.forName("org.postgresql.Driver");
            applicationDAO = new ApplicationDAO(SdzConnection.getInstance());
            peripheriqueDAO = new PeripheriqueDAO(SdzConnection.getInstance());
            systemeDAO = new SystemeExploitationDAO(SdzConnection.getInstance());
            infoPayementDAO = new InfoPayementDAO(SdzConnection.getInstance());
            utilisateurDAO = new UtilisateurDAO(SdzConnection.getInstance()); //Carichiamo gli utenti in una lista per poter effettuare il login
        }catch(Exception e){ e.printStackTrace(); }
        Utilisateur user_actuel = utilisateurDAO.login();
        utilisateurDAO.chargeDonneesUtilisateur(applicationDAO, peripheriqueDAO, user_actuel);
        Menu.affiche(user_actuel, utilisateurDAO, applicationDAO, peripheriqueDAO, systemeDAO, infoPayementDAO);
         //System.out.println("IL MIO FOTTUTISSIMO ID E' = " + user_actuel.getType());
        //System.out.println("\n------LISTE MES APPLICATIONS--------");
        //                    1  true    jeux    5    Sed nec metus  4    107      9      107
        //System.out.println("id,\tabonn,\tcateg,\tversion,\tnom,\tdroits,\ttelech,\tmela,\tprix");

        //user_actuel.afficher();
        //InfoPayement info1 = infoPayementDAO.find(1);
        //info1.afficher();
        //info1.setType("balotelli");
        //infoPayementDAO.update(info1);

    }//Fin Main
}//Fin Classe Main
