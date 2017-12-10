import java.util.*;


public class Cancion 
{
    private static String BD_SERVER = "localhost";
    private static String BD_NAME = "GI1718";
    
    private int ID_CANCION;
    private String nombre;
    private int ID_GRUPO;
    

	public static List<Cancion> ListaCanciones()
	{
		ArrayList<Cancion> lista = new ArrayList<Cancion>(); 
		// Retorna una lista con todos los objetos de la clase almacenados en la base de datos
		BD baseDatos = new BD(BD_SERVER, BD_NAME);
		for(Object[] elemento : baseDatos.Select("SELECT * FROM tCancion;")){
			lista.add( new Cancion( Integer.parseInt(elemento[0].toString()) ) );
		}

		return lista;
	}
	
	public static List<Cancion> ListaCancionesGrupo(int id_grupo)
	{
		ArrayList<Cancion> lista = new ArrayList<Cancion>(); 
		// Retorna una lista con todas las canciones de un grupo
		BD baseDatos = new BD(BD_SERVER, BD_NAME);
		for(Object[] elemento : baseDatos.Select("SELECT * FROM tCancion WHERE ID_Grupo = "+id_grupo+";")){
			lista.add( new Cancion( Integer.parseInt(elemento[0].toString()) ) );
		}

		return lista;
	}
	
    public Cancion(int id)
    {
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
		// Crea el objeto cargando sus valores de la base de datos
    	ID_CANCION = id;
    	nombre = baseDatos.Select("SELECT nombre FROM tCancion WHERE ID_CANCION = "+id+";").toString();
    	ID_GRUPO = Integer.parseInt(baseDatos.Select("SELECT ID_GRUPO FROM tCancion WHERE ID_CANCION = "+id+";").toString());

    }
    
    public Cancion(String name, String grupo)
    {
		// Crea el objeto y lo inserta en la base de datos
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	
    	nombre = name;
    	ID_GRUPO =  Grupo.ID_GRUPO(grupo);
    	//insercion
    	baseDatos.Insert("INSERT INTO tCancion (NOMBRE, ID_Grupo) VALUES ("+nombre+","+ID_GRUPO+");");
    	//recuperamos su clave
    	ID_CANCION = Integer.parseInt(baseDatos.Select("SELECT ID_Cancion FROM tCancion WHERE NOMBRE = "+name+";").toString());
    	
    }
	
    public int getID_CANCION() 
    { 
    	return ID_CANCION; 
    }
        
    public String getNombre() 
    { 
    	return nombre; 
    }
    
    public int getID_GRUPO() 
    { 
    	return ID_GRUPO; 
    }
    
    public String getGRUPO() 
    { 
    	// Retorna el nombre del grupo que toca esta cancion
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	String result = baseDatos.Select("SELECT NOMBRE FROM tGrupo WHERE ID_Grupo = "+ID_GRUPO+";").toString();
    	return result;
    }
    
    public void setNombre(String value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	nombre = value;
    	baseDatos.Update("UPDATE tCancion SET NOMBRE = "+value+" WHERE ID_CANCION = "+ID_CANCION+" ;");
    	
    }

    public void setID_GRUPO(int value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	ID_GRUPO = value;
    	baseDatos.Update("UPDATE tCancion SET ID_Grupo = "+value+" WHERE ID_CANCION = "+ID_CANCION+" ;");
    	

    }
    
    public void setGRUPO(String value) 
    {
		// Actualiza el grupo que toca esta cancion dado su nombre
    	this.setID_GRUPO(Grupo.ID_GRUPO(value));
    }

    public void BorrarCancion() 
    {
		// Actualiza el grupo que toca esta cancion dado su nombre
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	baseDatos.Delete("DELETE FROM tCancion WHERE ID_CANCION = "+ID_CANCION);

    }
    
}
