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
		BD miBD = new BD(BD_SERVER,BD_NAME);
					
		for(Object[] tupla: miBD.Select("SELECT ID_GRUPO FROM tGrupo;"))
		{
			lista.add(new Grupo((Integer)tupla[0]));
		}
		return lista;
	}
	
	public static int ID_GRUPO(String name)
	{
		BD miBD = new BD(BD_SERVER,BD_NAME);
		int id = -1;
		
		try
		{
			id = (Integer) miBD.SelectEscalar("SELECT ID_GRUPO FROM tGrupo WHERE NOMBRE = '" + name +"';");
		}
		catch (Exception ex)
		{
			id = -1; // No existe un grupo con ese nombre
		}
		
		return id;
	}
	
    public Grupo(int id)
    {
		// Crea el objeto cargando sus valores de la base de datos
      	BD miBD = new BD(BD_SERVER,BD_NAME);			
        Object[] tupla = miBD.Select("SELECT * FROM tGrupo WHERE ID_GRUPO="+id+";").get(0);
      		
        ID = (Integer)tupla[0];
        nombre = (String)tupla[1];
        
        canciones = null; // Postergamos la carga hasta que sea necesaria              
    }
    
    public Grupo(int id, String name)
    {
		// Crea el objeto y lo inserta en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);			
        miBD.Insert("INSERT INTO tGrupo VALUES (" + id + ", '" + name +"');");
        ID = id;
        nombre = name;         
        canciones = null; // Postergamos la carga hasta que sea necesaria              
    }
	
    public Grupo(String name)
    {
		// Crea el objeto y lo inserta en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);			
    	int idg = Grupo.ID_GRUPO(name);
    	if (idg!=-1)
    	{          	
            Object[] tupla = miBD.Select("SELECT * FROM tGrupo WHERE ID_GRUPO="+idg+";").get(0);
          		
            ID = (Integer)tupla[0];
            nombre = (String)tupla[1];
    	}
    	else
    	{    	
    		idg = 1 + ((Integer)miBD.SelectEscalar("SELECT MAX(ID_GRUPO) FROM tGrupo"));
	        miBD.Insert("INSERT INTO tGrupo VALUES (" + idg + ", '" + name +"');");
	        ID = idg;
	        nombre = name;                       
    	}
        canciones = null; // Postergamos la carga hasta que sea necesaria
    }
    
    public int getID() 
    { 
    	return ID; 
    }
        
    public void setID(int value) 
    { 
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tGrupo SET ID_GRUPO = " + value 
    			+ " WHERE ID_GRUPO ="+ this.ID + ";");
    	
    	ID = value;
    	
    }

    public String getNombre() 
    { 
    	return nombre; 
    }
    
    public void setNombre(String value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tGrupo SET NOMBRE = '" + value 
    			+ "' WHERE ID_GRUPO ="+ this.ID + ";");
    	
    	nombre = value;    	
    }

    public List<Cancion> getCanciones()
    { 
    	if (canciones == null) canciones = Cancion.ListaCancionesGrupo(ID);
    	
    	return canciones; 
    }
    
    public void setCanciones(List<Cancion> value)
    {
    	canciones = value;
    	// No actualizo la BD porque las canciones exiten y el atributo es una relación
    }
    
    public void borrarGrupo() 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Delete("DELETE FROM tGrupo WHERE ID_GRUPO ="+ this.ID + ";");
    	ID = -1;
    	nombre = null;
    	canciones = null;
    	
    	// Las canciones se borran por la restricción en cascada
    }
    
    public String toString()
    {
    	String res = this.nombre + "\n";
    	
    	for(Cancion c: this.getCanciones())
    	{
    		res+= ("\t" + c.getNombre() + "\n");
    	}
    	
    	return res;
    }
}
