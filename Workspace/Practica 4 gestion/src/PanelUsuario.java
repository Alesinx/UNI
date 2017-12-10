import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.*;

import javax.swing.*;

public class PanelUsuario extends JPanel implements ActionListener  
{
	private JLabel lUserName, lPwd,lRol;
	private JTextField tUserName, tPwd;
	private JList<String> tRol;
	private DefaultListModel <String>modeloRol;
	private JButton bOK,bCancel;
	private boolean nuevo;
	private Usuario user, mostrado;
	private JLabel pulsaciones;
	
	public PanelUsuario(Usuario user)
	{
		nuevo = true;
		this.user = user;
		setLayout(new GridLayout(8, 2));
		
		lUserName = new JLabel("Usuario");
		lPwd = new JLabel("Contraseña");
		lRol = new JLabel("Rol");
		
		tUserName= new JTextField(20);
		tPwd= new JTextField(20);
		tRol= new JList<String>();
		new JList<String>();
		modeloRol = new DefaultListModel<String>();
		new DefaultListModel<String>();
		tRol.setModel(modeloRol);
		bOK = new JButton("OK");
		bCancel = new JButton("CANCEL");
		
		pulsaciones = new JLabel();
		
		this.add(lUserName);
		this.add(tUserName);
		this.add(lPwd);
		this.add(tPwd);
		this.add(lRol);
		this.add(tRol);

		this.add(bOK);
		this.add(bCancel);
		
		this.add(new JLabel("Estado"));
		this.add(pulsaciones);
		
		bOK.addActionListener(this);
		bOK.setActionCommand("OK");
		
		bCancel.addActionListener(this);
		bCancel.setActionCommand("CANCEL");
		
		CargaRoles();
	}
	
	public void MostrarUsuario(Usuario u)
	{
		tUserName.setText(u.getNombre());
		tPwd.setText(u.getPassword());
		tRol.setSelectedValue(u.getRol().getRolName(), true);		
		
		nuevo = false;
		mostrado=u;
	}

	private void CargaRoles()
	{
		for(Rol r:Rol.ListaRoles())
		{
			modeloRol.addElement(r.getRolName());
		}
	}
	
	
	public void actionPerformed(ActionEvent e) 
	{
		String cmd = e.getActionCommand();
		try
		{
			if (cmd.equals("CANCEL"))
			{
				tUserName.setText("");
				tPwd.setText("");
				tRol.setSelectedValue("", true);							
				nuevo = true;
			}
			else if (cmd.equals("OK"))
			{
				if (nuevo)
				{
					nuevo = false;
				
					mostrado = new Usuario(tUserName.getText(), tPwd.getText(), 
						new Rol(tRol.getSelectedValue()));
				
				}
				else
				{
					if (!mostrado.getNombre().equalsIgnoreCase(tUserName.getText()))
						mostrado.setNombre(tUserName.getText());
					if (!mostrado.getPassword().equalsIgnoreCase(tPwd.getText())) 
						mostrado.setPassword(tPwd.getText());
					if (!mostrado.getRol().getRolName().equals(tRol.getSelectedValue()))
						user.ModiRol(mostrado, new Rol(tRol.getSelectedValue()));						
				}
				pulsaciones.setText("Operación Realizada");								
			}
		}
		catch(Exception ex)
		{
			pulsaciones.setText(ex.getMessage());
		}
		
	}
}
