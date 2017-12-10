import javax.swing.JFrame;



public class principal 
{
	public static void main(String[] args) 
	{
		
		PanelMantenimientoUsuarios vista = new PanelMantenimientoUsuarios();		
		CtrlPanelMantenimientoUsuarios ctr = new CtrlPanelMantenimientoUsuarios(vista);		
		vista.controlador(ctr);
		
		JFrame ventana = new JFrame("Gestión Usuarios");
		ventana.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		ventana.setContentPane(vista);
		ventana.pack();
		ventana.setVisible(true);	
		
		
	}

}
