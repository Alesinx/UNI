import java.util.*;


public class Rol 
{
    private static String BD_SERVER = "localhost";
    private static String BD_NAME = "GI1718";
    
    private String rolName;
    private String rolDes;
    private boolean admin;
    private List<Permiso> permisos;

	public static List<Rol> ListaRoles()
	{
		ArrayList<Rol> lista = new ArrayList<Rol>(); 
		// Retorna una lista con todos los obejtos de la clase almacenados en la base de datos
		BD miBD = new BD(BD_SERVER,BD_NAME);
					
		for(Object[] tupla: miBD.Select("SELECT rolName FROM tRol;"))
		{
			lista.add(new Rol((String)tupla[0]));
		}
		return lista;
	}
	
    public Rol(String name)
    {
		// Crea el objeto cargando sus valores de la base de datos
      	BD miBD = new BD(BD_SERVER,BD_NAME);			
        Object[] tupla = miBD.Select("SELECT * FROM tRol WHERE rolName='"+name+"';").get(0);
      		
              rolName = (String)tupla[0];
              rolDes = (String)tupla[1];
              admin = (Boolean)tupla[2];
              permisos = Permiso.ListaPermisosRol(rolName);              
    }
    
    public Rol(String name, String des, boolean adm)
    {
		// Crea el objeto y lo inserta en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);			
        miBD.Insert("INSERT INTO tRol VALUES ('" + name + "', '" + des + "', " + (adm ? 1: 0)+");");
        rolName = name;
        rolDes = des;        
        admin = adm;
        permisos = new ArrayList<Permiso>();              
    }
	
    public String getRolName() 
    { 
    	return rolName; 
    }
        
    public void setRolName(String value) 
    { 
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tRol SET rolName = '" + value 
    			+ "' WHERE rolName ='"+ this.rolName + "';");
    	
    	rolName = value;
    	
    }

    public String getRolDes() 
    { 
    	return rolDes; 
    }
    
    public void setRolDes(String value) 
    {
		// Actualiza el atributo en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tRol SET rolDes = '" + value 
    			+ "' WHERE rolName ='"+ this.rolName + "';");
    	
    	rolDes = value;    	
    }

    public boolean getAdmin()
    { 
    	return admin; 
    }
    
    public void setAdmin(boolean value)
    {
    	throw new Error("Un Rol no puede concederse permisos de administración a sí mismo.");
    }
    public void setAdmin(Rol other, boolean value)
    {
    	if (!admin) throw new Error("Rol sin permiso para establecer administradores.");

		// Actualiza el atributo admin de other en memoria y en la base de datos
    	BD miBD = new BD(BD_SERVER,BD_NAME);
    	miBD.Update("UPDATE tRol SET admin = " + (value?1:0) 
    			+ " WHERE rolName ='"+ other.getRolName() + "';");
    	
    	other.admin = value;
    }

    
    public boolean Acceso(String pantalla)
    {
        for (Permiso p : permisos)
        {
        	if (p.getPantalla().compareToIgnoreCase(pantalla)==0) 
        		return p.getAcceso();
        }
        return false;
    }

    public boolean Modificacion(String pantalla)
    {
        for (Permiso p : permisos)
        {
            if (p.getPantalla().compareToIgnoreCase(pantalla)==0) 
            	return p.getModificacion();
        }
        return false;
    }

    public void AddPermiso(Permiso p)
    {
        if (!permisos.contains(p))
        {
            permisos.add(p);
        }
    }
    
}
