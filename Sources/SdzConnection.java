import java.sql.*;
import java.math.*;

//Classe qui gère la connexion à la base de données qui a lieu seulement une fois!
public class SdzConnection{
	private static String url = "jdbc:postgresql://localhost:5432/store";
	private static String user = "sultano";
	private static String passwd = "brenti12";
	private static Connection connect;

	public static Connection getInstance(){
		if(connect == null){
			try{
				connect = DriverManager.getConnection(url, user, passwd);
			}catch(SQLException e){ e.printStackTrace(); }
		}
		return connect;
	}//fin méthode getInstance

}//fine classe
