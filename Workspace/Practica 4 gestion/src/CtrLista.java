import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

public class CtrLista implements ListSelectionListener 
{

	private Usuario user;
	
	public CtrLista(Usuario u)
	{
		super();
		user = u;

	}
	public void valueChanged(ListSelectionEvent e) 
	{

	}

}
