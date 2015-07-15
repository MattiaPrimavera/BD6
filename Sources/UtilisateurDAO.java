import java.sql.*;
import java.math.*;
import java.util.*;
public class UtilisateurDAO extends DAO<Utilisateur>{

	public UtilisateurDAO(Connection conn){
		super(conn);
		//A la connexion à la base à travers de ce classe DAO, on va remplir
		//la liste des utilisateurs connus.
		//listUtilisateurs = this.chargeListeUtilisateurs();
	}

	public boolean delete(Utilisateur obj){
		return Requete.deleteFrom("utilisateur", obj.createHashTable());
	}
	public boolean update(Utilisateur obj){
		return Requete.update("utilisateur", obj.createHashTable());
	}

	public Utilisateur find(int id){
		Utilisateur utilisateur = null;
		try{
			ResultSet result;
			if((result = Requete.demander(this.connect, Requete.selectWhere("utilisateur", "id", Integer.toString(id))))!=null){
				utilisateur = new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
					result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom"));
			}
			result.close();
			//else { System.out.println("ERR!!! Utilisateur n'existe pas dans la base ... "); }
		}catch(SQLException e){ e.printStackTrace(); }
		return utilisateur;
	}//fin find

	public Utilisateur find(String mail){
		Utilisateur utilisateur = null;
		try{
			ResultSet result;
			if((result = Requete.demander(this.connect, Requete.selectWhere("utilisateur", "mail", mail)))!=null) {
				utilisateur = new Utilisateur(result.getInt("id"), result.getInt("type"), result.getString("mail"),
					result.getString("mot_de_passe"), result.getInt("num_install"), result.getString("nom"), result.getString("prenom"));
			}
			result.close();
			//else { System.out.println("ERR!!! Utilisateur n'existe pas dans la base ... "); }
		}catch(SQLException e){ e.printStackTrace(); }
		return utilisateur;
	}

	public boolean create(Utilisateur obj){
		if(this.find(obj.getMail()) == null){
			return Requete.insertInto("utilisateur", obj.createHashTable());
		}
		else
			return false;
	}

	public Connection getConnection(){ return this.connect; }

	public void chargeDonneesUtilisateur(ApplicationDAO applicationDAO, PeripheriqueDAO peripheriqueDAO, Utilisateur user){
		user.setListePeripheriques(peripheriqueDAO.creerListePeripheriques(user));
		user.setListeApplications(applicationDAO.creerListeApplications(user));
		if(user.getType() == 1){
			user.setListeApplicationsDevel(applicationDAO.creerListeApplications(user));
		}
		/*for(Peripherique i : user.getListePeripheriques()){
			i.affiche();
		}*/
	}//fin méthode

	public Utilisateur login(){
		String mail = "", passwd ="";
		boolean login_ok = false;
		Scanner sc = new Scanner(System.in);
		Utilisateur utilisateur = null;
		while(!login_ok){
			System.out.println("-----PINEAPPLE STORE-----");
			System.out.print("MAIL: ");
			mail = sc.nextLine();
			//Si il y a un utilisateur avec la mail inseré par l'user actuel dans la base de données ...
			if((utilisateur = this.find(mail)) != null){
				sc = new Scanner(System.in);
				System.out.print("MOT_DE_PASSE: ");
				passwd = sc.nextLine();
				//On verifie alors si les mots de passe correspondent ... Si la reponse est affirmative => on renvoye l'objet utilisateur qui represente l'user actuel
				if(utilisateur.getMotDePasse().equals(passwd)){
					System.out.println();
					System.out.println("CONNEXION EFFECTUÉE.....");
					System.out.println("Bienvenu Utilisateur " + utilisateur.getNom() + "\n");
					login_ok = true;
				}
				else{
					System.out.println("ERR MOT DE PASSE! ");
					continue;
				}
			}//fin if
			else{
				System.out.println("ERR MAIL! ");
				continue;
			}
		}//fin while
		//System.out.println("RITORNIAMO L?OGGETTO");
		return utilisateur;
	}//fin methode

	public void modificationInfosPersonnelles(Utilisateur user){
		System.out.println("INSERER...");
		String mail, mot_de_passe, nom, prenom;
		Scanner sc = new Scanner(System.in);
		System.out.print("MAIL: ");
		mail = sc.nextLine();
		System.out.print("NOM: ");
		nom = sc.nextLine();
		System.out.print("PRENOM: ");
		prenom = sc.nextLine();
		System.out.print("MOT DE PASSE: ");
		mot_de_passe = sc.nextLine();
		Utilisateur new_user = user;
		new_user.setMotDePasse(mot_de_passe);
		new_user.setMail(mail);
		new_user.setPrenom(prenom);
		new_user.setNom(nom);
		this.update(new_user);
	}//fin méthode modification


		//Verification de la présence de l'adresse Mail dans la liste utilisateurs




}//fin classe DAO<Utilisateur>

	//charge dans le tab qui fait partie de l'objet UtilisateurDAO la liste des utilisateurs qui sont dans la Base.
/*	public ArrayList<Utilisateur> chargeListeUtilisateurs(){
		ArrayList<Utilisateur> listUtilisateurs = new ArrayList<Utilisateur>();
		try{
			ResultSet result = this.connect.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY
			).executeQuery(
				Requete.selectAll("utilisateur")
			);
			while(result.next())
				listUtilisateurs.add(new Utilisateur(result.getInt("id"), result.getInt("mela"), result.getString("type"), result.getString("mail"),
					result.getString("mot_de_passe"), result.getInt("num_install"), result.getInt("id_compte")));

		}//fin try
		catch(SQLException e){
			e.printStackTrace();
		}//fin catch
		return listUtilisateurs;
	}
*/
