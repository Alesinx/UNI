import java.util.*;


public class Permiso 
{
    private static String BD_SERVER = "localhost";
    private static String BD_NAME = "GI1718";
    
	private String rolName;
	private String pantalla;
    private boolean acceso;
    private boolean modificacion;


    public static List<Permiso> ListaPermisosRol(String rolName)
    {
		// retorna todos los permisos de un rol
		ArrayList<Permiso> lista = new ArrayList<Permiso>();
		BD miBD = new BD(BD_SERVER,BD_NAME);
		
		for (Object[] tupla : miBD.Select("SELECT rolName,pantalla FROM tPermiso")) {
			lista.add(new Permiso((String)tupla[0],(String)tupla[1]));
		}
		return lista;
    }
    
    public Permiso(String r, String p)
    {
		// Crea el objeto cargando sus valores de la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	Object[] tupla = miBD.Select("SELECT * FROM tPermiso WHERE rolName='"+r+"' and pantalla='"+p+"';").get(0);
    	
    		rolName = (String)tupla[0];
    		pantalla = (String)tupla[1];
    		acceso = (Boolean)tupla[2];
    		modificacion = (Boolean)tupla[3];
    }

    public Permiso(String r, String p, boolean a, boolean m)
    {
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Insert("INSERT INTO tPermiso VALUES ('" + r + "', '" + p + "', " + (a ? 1: 0)+", " + (m ? 1: 0)+");");
    	rolName = r;
    	pantalla = p;
    	acceso = a;
    	modificacion = m;
    }
    
	public void setRolName(String value) 
	{
		// Actualiza el atributo en memoria y en la base de datos
		BD miBD = new BD(BD_SERVER,BD_NAME);
		miBD.Update("UPDATE tPermiso SET rolName = '" + value + "' WHERE rolName ='"+ this.rolName + "';");
		
		rolName = value;
	}

	public String getRolName() 
	{
		return rolName;
	}
    
    public String getPantalla() 
    {
    	return pantalla; 
    }
    
    public void setPantalla(String value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tPermiso SET pantalla = '" + value + "' WHERE pantalla ='"+ this.pantalla + "';");
    	
    	pantalla = value;
    }
    

    public boolean getAcceso() 
    { 
    	return acceso; 
    }
        
    public void setAcceso(boolean value) 
    { 
    	if (!acceso) throw new Error("Acceso denegado.");
    	
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tPermiso SET acceso = " + (value?1:0) + " WHERE rolName = '"+ this.rolName + "';");
    	
    	acceso = value;
    }

    
    public boolean getModificacion() 
    { 
    	return modificacion; 
    }
    
    public void setModificacion(boolean value) 
    { 
    	if (!modificacion) throw new Error("Modificacion denegada.");
    	
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tPermiso SET modificacion = " + (value?1:0) + " WHERE rolName = '"+ this.rolName + "';");
    	
    	modificacion = value;
    }


}
