import java.util.*;
public class Utilisateur{
    private int id, num_install, type;
    private String mail, mot_de_passe, nom, prenom;
    private ArrayList<Peripherique> listePeripheriques = new ArrayList<Peripherique>();
    private ArrayList<Application> listeApplications = new ArrayList<Application>();
    private ArrayList<Application> listeApplicationsDevel = null;

    public Utilisateur(){}
    public Utilisateur(
        int id, int type, String mail,
        String mot_de_passe, int num_install, String nom, String prenom
                      )
    {
        this.id = id;
        this.type = type;
        this.nom = nom;
        this.prenom = prenom;
        this.mail = mail;
        this.mot_de_passe = mot_de_passe;
        this.num_install = num_install;
    }
    public Hashtable<String,String> createHashTable(){
        Hashtable<String,String> ht = new Hashtable<String,String>();
        ht.put("id", Integer.toString(this.id));
        ht.put("type", Integer.toString(this.type));
        ht.put("mail", this.mail);
        ht.put("prenom", this.prenom);
        ht.put("nom", this.nom);
        ht.put("mot_de_passe", this.mot_de_passe);
        ht.put("num_install", Integer.toString(num_install));

        return ht;
    }
    //getters
    public int getId(){ return this.id; }
    public int getNumInstall() { return this.num_install; }
    public int getType(){ return this.type; }
    public String getMail(){ return this.mail; }
    public String getMotDePasse(){ return this.mot_de_passe; }
    public String getNom(){ return this.nom; }
    public String getPrenom(){ return this.prenom; }
    public ArrayList<Peripherique> getListePeripheriques(){ return this.listePeripheriques; }
    public ArrayList<Application> getListeApplications(){ return this.listeApplications; }
    public ArrayList<Application> getListeApplicationsDevel(){ return this.listeApplicationsDevel; }
    //setters
    public void setId(int id){ this.id = id; }
    public void setNumInstall(int num_install) { this.num_install = num_install; }
    public void setType(int type){ this.type = type; }
    public void setMail(String mail){ this.mail = mail; }
    public void setMotDePasse(String mot_de_passe){ this.mot_de_passe = mot_de_passe; }
    public void setNom(String nom){this.nom = nom; }
    public void setPrenom(String prenom){this.prenom = prenom; }
    public void setListePeripheriques(ArrayList<Peripherique> listePeripheriques){ this.listePeripheriques = listePeripheriques; }
    public void setListeApplications(ArrayList<Application> listeApplications){ this.listeApplications = listeApplications; }
    public void setListeApplicationsDevel(ArrayList<Application> listeApplicationsDevel){ this.listeApplicationsDevel = listeApplicationsDevel; }
    public void affiche(){
        Hashtable<String,String> parametres = this.createHashTable();
        Enumeration<String> keys = parametres.keys();
        Enumeration<String> values = parametres.elements();
        while(keys.hasMoreElements()){
            System.out.print(keys.nextElement() + " = " + values.nextElement());
        }//fin while
    }//méthode affiche

}//Fin classe Utilisateur
