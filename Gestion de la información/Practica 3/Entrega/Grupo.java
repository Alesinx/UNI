import java.util.*;


public class Grupo 
{
    private static String BD_SERVER = "localhost";
    private static String BD_NAME = "GI1718";
    
    private int ID;
    private String nombre;
    
    private List<Cancion> canciones;

	public static List<Grupo> ListaGrupos()
	{
		ArrayList<Grupo> lista = new ArrayList<Grupo>(); 
		// Retorna una lista con todos los obejtos de la clase almacenados en la base de datos
		BD baseDatos = new BD(BD_SERVER, BD_NAME);
		for(Object[] elemento : baseDatos.Select("SELECT * FROM tGrupo;")){
			lista.add( new Grupo( Integer.parseInt(elemento[0].toString()) ) );
		}
		return lista;
	}
	
	public static int ID_GRUPO(String name)
	{
		// Retorna el ID de un grupo dado su nombre
		// Retorna -1 si no hay un grupo con dicho nombre (Falta esto)
		BD baseDatos = new BD(BD_SERVER, BD_NAME);
		String valorInt = baseDatos.Select("SELECT ID_Grupo FROM tGrupo WHERE NOMBRE = "+name+" ;").toString();
		int result = -1;
		if(valorInt != null) {
		result = Integer.parseInt( valorInt );
		}
		return result;
	}
	
    public Grupo(int id)
    {
		// Crea el objeto cargando sus valores de la base de datos
		// Postergamos la carga de las canciones hasta que sea necesaria   
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	ID = id;
    	nombre = baseDatos.Select("SELECT NAME FROM tGrupo WHERE ID_GRUPO = "+id+";").toString();
    	canciones = Cancion.ListaCancionesGrupo(ID);
    	
    }
    
    public Grupo(int id, String name)
    {
		// Crea el objeto y lo inserta en la base de datos
		// Postergamos la carga hasta que sea necesaria  
    	ID = id;
    	nombre = name;
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	baseDatos.Insert("INSERT INTO tGrupo VALUES ("+nombre+", "+ID+");");
    }
	
    public Grupo(String name)
    {
		// Crea el objeto y lo inserta en la base de datos
		// Asigna el ID automáticamente
		// Postergamos la carga hasta que sea necesaria
    	nombre = name;
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	baseDatos.Insert("INSERT INTO tGrupo VALUES ("+nombre+");");
    	ID = Integer.parseInt( baseDatos.Select("SELECT ID_GRUPO FROM tGrupo WHERE NOMBRE= "+name+";").toString() );
    }
    
    public int getID() 
    { 
    	return ID; 
    }
        
    public void setID(int value) 
    { 
		// Actualiza el atributo en memoria y en la base de datos
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	baseDatos.Update("UPDATE tGrupo SET ID_GRUPO = "+value+" WHERE ID_GRUPO = "+ID+" ;");
    	ID = value;

    }

    public String getNombre() 
    { 
    	return nombre; 
    }
    
    public void setNombre(String value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	baseDatos.Update("UPDATE tGrupo SET NOMBRE = "+value+" WHERE ID_GRUPO = "+ID+" ;");
    	nombre = value;
    }

    public List<Cancion> getCanciones()
    { 
		// Retorna la lista de canciones del grupo
    	return Cancion.ListaCancionesGrupo(ID); 
    }
    
    public void setCanciones(List<Cancion> value)
    {
    	canciones = value;
    	// No actualizo la BD porque las canciones exiten y el atributo es una relación
    }
    
    public void borrarGrupo() 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD baseDatos = new BD(BD_SERVER, BD_NAME);
    	baseDatos.Delete("DELETE FROM tGrupo WHERE ID_Grupo = "+ID+";");
    	nombre = null;
    	ID = -1;
    	canciones = null;
    		// Las canciones se borran por la restricción en cascada
    }
     
}
