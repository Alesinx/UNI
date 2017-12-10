import java.util.*;

public class mainP3 {

	public static void main(String[] args) 
	{
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		usuarios.add(new Usuario("admin","admin"));
		usuarios.add(new Usuario("james","metallica"));
		usuarios.add(new Usuario("jose","jose"));
		usuarios.add(new Usuario("Megaforce Records","mega"));
		
		for(Usuario u: usuarios)
		{
			System.out.println("Probando con " + u.getNombre());
			Go2PantallaGrupos(u,"GRUPOS"); 
			Go2PantallaGrupos(u,"CANCIONES"); 
			System.out.println();
		}
		
		Grupo g = new Grupo("METALLICA");
		System.out.println(g);
	}
	
	public static void Go2PantallaGrupos(Usuario u, String pantalla)
	{
		if (!u.AccesoPantalla(pantalla)) return;
		System.out.println(u.getNombre()  + " en Pantalla " + pantalla );
		
		if (!u.ModificaPantalla(pantalla)) return;
		System.out.println(u.getNombre()  + " Puede Modificar en Pantalla " + pantalla);
	
	}
}
