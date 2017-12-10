import java.awt.event.ActionListener;

import javax.swing.event.ListSelectionListener;

public interface I_PanelMantenimientoUsuarios 
{
	String LOGIN = "LOGIN";    
    String USUARIOS = "USUARIOS";
    
	// Estabelce el controlador de las acciones de los botones
    public void controlador(ActionListener ctrl);
	public void controladorLista(ListSelectionListener ctrLista);
    public void MostrarUsuarios(java.util.List<Usuario> lista);
    public void limpiar(); 
	public void mensaje(String msg); 
	public void alerta(String msg); 
	public String getUser();
	public String getPwd();
	public void desactivaBotones();
	public void ActivarUsuarios();
}
