import java.util.*;
public class InfoPayement{
	private int id, id_user;
	private String type;
	private long num_compte;

	public InfoPayement(){}
	public InfoPayement(int id, long num_compte, String type, int id_user)
	{ 
		this.id_user = id_user;
		this.id = id;
		this.type = type; 
		this.num_compte = num_compte;
	}
	//getters
	public int getIdUser(){ return this.id_user; }
	public int getId(){ return this.id; }
	public long getNumCompte(){ return this.num_compte; }
	public String getType(){ return this.type; }
	//setters
	public void setIdUser(){ this.id_user = id_user; }
	public void setId(int id){ this.id = id; }
	public void setNumCompte(long num_compte){ this.num_compte = num_compte; }
	public void setType(String type){ this.type = type; }
	public void afficher(){
		System.out.println("id =" + this.id +"\n" +
						   "type = " + this.type +"\n" +
						   "num_compte = " + this.num_compte +
						   "id_user = " + this.id_user 
			);
	}//fin afficher

	public Hashtable<String,String> createHashTable(){
		Hashtable<String,String> ht = new Hashtable<String,String>();
		ht.put("id", Integer.toString(this.id));
		ht.put("num_compte", Long.toString(this.num_compte));
		ht.put("type", this.type);
		ht.put("id_user", Integer.toString(this.id_user));
		return ht;
	}

}//Fin classe Utilisateur