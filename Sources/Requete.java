import java.sql.*;
import java.math.*;
import java.util.*;
public abstract class Requete{
	public static String selectAll(String nom_table){
		String requete = "SELECT * FROM " + nom_table;
		return requete;
	}//fin selectAll
	public static String selectWhere(String nom_table, String where, String value){
		String requete = "SELECT * FROM " + nom_table + " WHERE " + where + " = " + "\'" + value + "\'";
		return requete;
	}//fin selectId
	public static boolean deleteFrom(String nom_table, Hashtable<String,String> parametres){
		String requete = "DELETE FROM " + nom_table + " WHERE id = " + parametres.get("id");
		try{
			Statement state = SdzConnection.getInstance().createStatement();
			int nbMax = state.executeUpdate(requete);
			System.out.println("nb mise a jour = " + nbMax);
			state.close();
			return true;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}

	public static boolean update(String nom_table, Hashtable<String,String> parametres){
		Enumeration<String> keys = parametres.keys();
		Enumeration<String> values = parametres.elements();
		String requete = "UPDATE " + nom_table + " SET ";
		while(keys.hasMoreElements()){
			requete += keys.nextElement() + " = " + "\'"+values.nextElement()+"\'" + ", ";
		}//fin while
		requete = requete.substring(0, requete.length() - 2);
		requete += " WHERE id = " + parametres.get("id");
		try{
			Statement state = SdzConnection.getInstance().createStatement();
			int nbMax = state.executeUpdate(requete);
			System.out.println("nb mise a jour = " + nbMax);
			state.close();
			return true;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}

	public static boolean insertInto(String nom_table, Hashtable<String,String> parametres){
		Enumeration<String> keys = parametres.keys();
		Enumeration<String> values = parametres.elements();
		String requete = "INSERT INTO " + nom_table + "(";
		while(keys.hasMoreElements()){
			requete += keys.nextElement() + ", ";
		}
		requete = requete.substring(0, requete.length() - 2);
		requete += ") VALUES (";
		//System.out.println("A=  "+requete);
		while(values.hasMoreElements()){
			requete += "\'" + values.nextElement() + "\',";
		}
		requete = requete.substring(0, requete.length() -2);
		requete += "')";
		System.out.println("RIC = " + requete);
		try{
			Statement state = SdzConnection.getInstance().createStatement();
			int nbMax = state.executeUpdate(requete);
			System.out.println("nb mise a jour = " + nbMax);
			state.close();
			return true;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}//fin insertInto

	public static ResultSet demander(Connection connect, String requete){
		try{
			ResultSet result = connect.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY
			).executeQuery(
				requete
			);
			if(result.first())
				return result;
		}//fin try
		catch(SQLException e){
			e.printStackTrace();
			return null;
		}//fin catch
		return null;
	}//fin envoyerRequete


	public static void afficheIntestationTable(Hashtable<String,String> parametres){
		Enumeration<String> keys = parametres.keys();
		int num_colonnes = parametres.size();
		String ligne1 = "", ligne2 = "", nom_colonne = "", tmp = "";
		for(int i=0; i<num_colonnes; i++){
			if(keys.hasMoreElements()){
				tmp = keys.nextElement();
				if(tmp.length() > 15)
					tmp = tmp.substring(0,15);
			}//fin if
			ligne1 += String.format("%15s","+---------------");
			ligne2 += String.format("|%15s", tmp);
		}//fin for
		ligne1 += "+";
		ligne2 += "|";
		System.out.println(ligne1);
		System.out.println(ligne2);
		System.out.println(ligne1);
	}

	public static void afficheTable(Hashtable<String,String> parametres){
		Enumeration<String> values = parametres.elements();
		int num_values = parametres.size();
		String ligne = "";
		String tmp = "";
		for(int i = 0; i<num_values; i++){
			if(values.hasMoreElements()){
				tmp = values.nextElement();
				if(tmp.length() > 15)
					tmp = tmp.substring(0,15);
			}//fin if
			ligne += String.format("|%15s", tmp);
		}
		ligne += "|";
		System.out.println(ligne);
	}

	public static void afficheFinTable(Hashtable<String,String> parametres){
		Enumeration<String> keys = parametres.keys();
		int num_colonnes = parametres.size();
		String ligne = "";
		for(int i=0; i<num_colonnes; i++){
			ligne += String.format("%15s","+---------------");
		}//fin for
		ligne += "+";
		System.out.println(ligne);
	}

	public static void extractionGenerale(Connection conn, String requete){
		try{
			Hashtable<String,String> ht = new Hashtable<String,String>();
			ResultSet result = Requete.demander(conn, requete);
			ResultSetMetaData resultMeta = result.getMetaData();
			ArrayList<String> nom_colonnes = new ArrayList<String>();
			ArrayList<Hashtable<String,String>> liste_lignes = new ArrayList<Hashtable<String,String>>();
			for(int i = 1; i <= resultMeta.getColumnCount(); i++){
				nom_colonnes.add(resultMeta.getColumnName(i));
			}//fin for
			while(result.next()){
				ht = new Hashtable<String,String>();
				for(int i = 1; i <= resultMeta.getColumnCount(); i++){
					result.getString(nom_colonnes.get(i-1));
					ht.put(nom_colonnes.get(i-1), result.getString(nom_colonnes.get(i-1)));
				}//fin for
				liste_lignes.add(ht);
			}//fin while
			afficheIntestationTable(liste_lignes.get(0));
			for(int i = 1; i<liste_lignes.size(); i++){
					afficheTable(liste_lignes.get(i));
			}
			afficheFinTable(liste_lignes.get(0));
		}catch(SQLException e){ e.printStackTrace(); }


	}
}//Fin classe Requete
