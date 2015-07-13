import java.sql.*;
import java.math.*;
public class MotCleDAO extends DAO<MotCle>{
	public MotCleDAO(Connection conn){
		super(conn);
	}
	public boolean delete(MotCle obj){
		return false;
	}
	public boolean update(MotCle obj){
		return false;
	}
	public MotCle find(int id){
		MotCle mot_cle = new MotCle();
		try{
			ResultSet result = this.connect.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY
			).executeQuery(
				"SELECT * FROM mot_cle WHERE id = " + id
			);
			if(result.first())
				mot_cle = new MotCle(result.getString("type"), result.getInt("id_categorie"), id);
		}//fin try
		catch(SQLException e){
			e.printStackTrace();
		}//fin catch
		return mot_cle;
	}

	public boolean create(MotCle obj){
		if(this.find(obj.getType()) == null)
			try{
				Statement state = SdzConnection.getInstance().createStatement();
				int nbMax = state.executeUpdate(
					"INSERT INTO mot_cle(id, categorie.id, type) VALUES("
						+ obj.getId() + ", "
						+ obj.getIdCategorie() + ", "
						+ obj.getType() + 
					")"
				);
				System.out.println("nb mise a jour = "+nbMax);
				return true;
			}catch(SQLException e){ e.printStackTrace(); }
		return false;
	}

	//Cherche la presence d'un mot-cle dedans la liste à partir de la String decrivant son type ;)
	//et retourne un objet MotCle qui vient d'etre crée (resultat de la recherche)
	public MotCle find(String type){
		MotCle mot_cle = new MotCle();
		try{
			ResultSet result = this.connect.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY
			).executeQuery(
				"SELECT * FROM mot_cle WHERE type = " + type
			);
			if(result.first())
				mot_cle = new MotCle(type, result.getInt("id_categorie"), result.getInt("id"));
		}//fin try
		catch(SQLException e){
			e.printStackTrace();
		}//fin catch
		return mot_cle;
	}//méthode find

}//fin classe DAO<MotCle>
