import java.util.*;
public class Application{ //id id_categorie, versio, prix, abonnements, num_telechargementss
	private int id, id_developpeur, droits, version, prix, num_telechargements, mela;
	private boolean abonnement;
	private String nom, categorie;

	public Application(){}
	public Application(
		int id, String nom, int prix, boolean abonnement, int num_telechargements, int droits, String categorie, int mela, int version, int id_developpeur
					)
	{
		this.id_developpeur = id_developpeur;
		this.mela = mela;
		this.id = id;
		this.categorie = categorie;
		this.version = version;
		this.prix = prix;
		this.abonnement = abonnement;
		this.nom = nom;
		this.droits = droits;
		this.num_telechargements = num_telechargements;
	}
	public Hashtable<String,String> createHashTable(){
		String abonnementS = null;
		if(abonnement)
			abonnementS = "true";
		else
			abonnementS = "false";
		Hashtable<String,String> ht = new Hashtable<String,String>();
		ht.put("id", Integer.toString(this.id));
		ht.put("nom", this.nom);
		ht.put("prix", Integer.toString(this.prix));
		ht.put("abonnement", abonnementS);
		ht.put("num_telechargements", Integer.toString(num_telechargements));
		ht.put("droits", Integer.toString(this.droits));
		ht.put("categorie", this.categorie);
		ht.put("mela", Integer.toString(this.mela));
		ht.put("version", Integer.toString(this.version));
		ht.put("id_developpeur", Integer.toString(this.version));
		return ht;
	}
	//getters
	public int getIdDeveloppeur(){ return this.id_developpeur; }
	public int getMela(){ return this.mela; }
	public int getId(){ return this.id; }
	public String getCategorie(){ return this.categorie; }
	public String getNom(){ return this.nom; }
	public int getPrix(){ return this.prix; }
	public int getVersion(){ return this.version; }
	public int getNumTelechargements(){ return this.num_telechargements; }
	public boolean getAbonnement(){ return this.abonnement; }
	public int getDroits(){ return this.droits; }
	//setters
	public void setIdDeveloppeur(int id){ this.id = id; }
	public void setId(int id){ this.id = id; }
	public void setCategorie(String categorie){ this.categorie = categorie; }
	public void setNom(String nom){ this.nom = nom; }
	public void setPrix(int prix){ this.prix = prix; }
	public void setVersion(int version){ this.version = version; }
	public void setNumTelechargements(int num_telechargements){ this.num_telechargements = num_telechargements; }
	public void setDroits(int droits){ this.droits = droits; }
	public void setMela(int mela){this.mela = mela; }


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
