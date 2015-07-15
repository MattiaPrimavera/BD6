import java.util.*;
public class Peripherique{ //id_peripherique, nom, id_se, nom_fabriquant
    private int id, id_se, id_user;
    private String nom, nom_fabriquant;

    public Peripherique(){}
    public Peripherique(
        int id, String nom, int id_se, String nom_fabriquant, int id_user
                       )
    {
        this.id = id;
        this.id_se = id_se;
        this.nom = nom;
        this.nom_fabriquant = nom_fabriquant;
        this.id_user = id_user;
    }
    public Hashtable<String,String> createHashTable(){
        Hashtable<String,String> ht = new Hashtable<String,String>();
        ht.put("id", Integer.toString(this.id));
        ht.put("id_se", Integer.toString(this.id_se));
        ht.put("nom", this.nom);
        ht.put("nom_fabriquant", this.nom_fabriquant);
        ht.put("id_user", Integer.toString(this.id_user));
        return ht;
    }
    //getters
    public int getId(){ return this.id; }
    public int getIdSe(){ return this.id_se; }
    public String getNom(){ return this.nom; }
    public String getNomFabriquant(){ return this.nom_fabriquant; }
    public int getIdUser(){ return this.id_user; }
    //setters
    public void setId(int id){ this.id = id; }
    public void setIdSe(int id_se){ this.id_se = id_se; }
    public void setNom(String nom){ this.nom = nom; }
    public void setNomFabriquant(String nom_fabriquant){ this.nom_fabriquant = nom_fabriquant; }
    public void setIdUser(int id_user){ this.id_user = id_user; }

    public void affiche(){
        Hashtable<String,String> parametres = this.createHashTable();
        Enumeration<String> keys = parametres.keys();
        Enumeration<String> values = parametres.elements();
        while(values.hasMoreElements()){
            System.out.print(values.nextElement() + "\t");
        }
        System.out.println();
    }
}//Fin classe Utilisateur
