public class MotCle{
	private String type;
	private int id_categorie;
	private int id;

	public MotCle(){}
	public MotCle(String type, int id_categorie, int id){
		this.id_categorie = id_categorie;
		this.type = type;
	}
	//getters
	public int getIdCategorie(){ return this.id_categorie; }
	public int getId(){ return this.id; }
	public String getType(){ return this.type; }
	//setters
	public void setIdCategorie(int id_categorie){ this.id_categorie = id_categorie; }
	public void setId(int id){ this.id = id; }
	public void setType(String type){ this.type = type; }

	public void afficher(){
		System.out.println("ID = " + this.id + "\nID_CATEGORIE = "+this.id_categorie +"\nTYPE = "+ this.type);
	}
}