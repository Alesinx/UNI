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
		// Retorna una lista con todos los obejtos de la clase almacenados en la base de datos
		BD miBD = new BD(BD_SERVER,BD_NAME);
					
		for(Object[] tupla: miBD.Select("SELECT ID_CANCION FROM tCancion;"))
		{
			lista.add(new Cancion((Integer)tupla[0]));
		}
		return lista;
	}
	
	public static List<Cancion> ListaCancionesGrupo(int id_grupo)
	{
		ArrayList<Cancion> lista = new ArrayList<Cancion>(); 
		// Retorna una lista con todos los obejtos de la clase almacenados en la base de datos
		BD miBD = new BD(BD_SERVER,BD_NAME);
					
		for(Object[] tupla: miBD.Select("SELECT ID_CANCION FROM tCancion WHERE ID_GRUPO = "+ id_grupo +";"))
		{
			lista.add(new Cancion((Integer)tupla[0]));
		}
		return lista;
	}
	
    public Cancion(int id)
    {
		// Crea el objeto cargando sus valores de la base de datos
      	BD miBD = new BD(BD_SERVER,BD_NAME);			
        Object[] tupla = miBD.Select("SELECT * FROM tCancion WHERE ID_CANCION = "+ id +";").get(0);

		ID_CANCION = (Integer)tupla[0];
		nombre = (String)tupla[1];
		ID_GRUPO = (Integer)tupla[2]; 
    }
    
    public Cancion(String name, String grupo)
    {
		// Crea el objeto y lo inserta en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	
    	int idg = Grupo.ID_GRUPO(grupo);
    	if (idg==-1)
    	{
    		Grupo g = new Grupo(grupo);
    		idg = g.getID();
    	}
    	
        miBD.Insert("INSERT INTO tCancion VALUES (" + name + "', " + idg + ")+");
		ID_CANCION = ((Integer)miBD.SelectEscalar("SELECT MAX(ID_CANCION) FROM tCancion;"));
		nombre = name;
		ID_GRUPO = idg; 
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
    	Grupo g = new Grupo(ID_GRUPO);
    	
    	return g.getNombre();
    }
    
    public void setNombre(String value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tCancion SET NOMBRE = '" + value 
    			+ "' WHERE ID_CANCION ="+ this.ID_CANCION + ";");
    	
    	nombre = value;    	
    }

    public void setID_GRUPO(int value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tCancion SET ID_GRUPO = " + value 
    			+ " WHERE ID_CANCION ="+ this.ID_CANCION + ";");
    	
    	ID_GRUPO = value;    	
    }
    
    public void setGRUPO(String value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	int idg = Grupo.ID_GRUPO(value);
    	if (idg!=-1) setID_GRUPO(idg); 
    }
    
    public void BorrarCancion()
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Delete("DELETE FROM tCancion WHERE ID_CANCION ="+ this.ID_CANCION + ";");    	
		
    	ID_CANCION = -1;
		nombre = null;
		ID_GRUPO = -1; 
    }
    
}
