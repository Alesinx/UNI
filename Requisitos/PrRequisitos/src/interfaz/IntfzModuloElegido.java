package interfaz;

import java.awt.EventQueue;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import principal.*;

import javax.swing.JButton;
import javax.swing.JTable;
import javax.swing.JScrollPane;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JLabel;
import java.awt.Font;
import java.awt.Choice;
import javax.swing.SwingConstants;
import javax.swing.JTextField;

public class IntfzModuloElegido {

	private JFrame frame;
	//EL MODULO OBTENIDO
	private Modulo mod = new Modulo();
	private JTable tablaCurvas;
	private ArrayList<CurvaOriginal> listaDeCurvas; 		//curvas seleccionadas en la campa?a
	private ArrayList<CurvaOriginal> listaDeCurvasACorregir;//curvas seleccionadas para corregir

	JPanel panelCurva;
	JPanel panelCorreccion;

	private JTextField txtfAlpha;
	private JTextField txtfBetta;
	private JTextField txtfRs;
	private JTextField txtfKappa;

	/**
	 * Launch the application.
	 */
	public void newScreen(String nombreModulo) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					//inicializacion

					IntfzModuloElegido window = new IntfzModuloElegido(nombreModulo);
					window.frame.setVisible(true);
				} catch (Exception e) {
					JOptionPane.showMessageDialog(null, e.getMessage(), "Error!",JOptionPane.ERROR_MESSAGE);
				}
			}
		});
	}

	/**
	 * Create the application.
	 * @throws ClassNotFoundException 
	 */
	public IntfzModuloElegido( String nombreModulo) throws ClassNotFoundException {

		initialize(nombreModulo);
	}

	/**
	 * Initialize the contents of the frame.
	 * @throws ClassNotFoundException 
	 */
	private void initialize(String nombreModulo) throws ClassNotFoundException {
		frame = new JFrame();
		frame.setBounds(100, 100, 625, 373);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		mod = new Modulo(nombreModulo);
		listaDeCurvas = mod.getCurvas();
		listaDeCurvasACorregir = new ArrayList<CurvaOriginal>();
		
		frame.setTitle("Modulo :"+mod.getNombre());

		//CONSTRUCCION DE LA TABLA
		//DEJAMOS LOS CANALES PARA FUTURAS IMPLEMENTACIONES
		String[] columnName = {"N","Seleccionada","Isc(A)","Voc(V)",
				"Pmax(W)","IPmax(A)","VPmax(V)","FF(%)","idEnBD"};
		Object [] [] data= new Object [listaDeCurvas.size()] [columnName.length];//array de objetos
		int i = 0;					//indice sobre el que se monta las filas
		//volcamos los datos en las tablas
		for(curva c : listaDeCurvas) {
			CurvaOriginal co = (CurvaOriginal) c;
			data[i][0] = i+1;		//indice
			data[i][1] = new Boolean(false);	//este marco indica que curvas se han seleccionasdo
			data[i][2] = co.getIsc();			//Isc
			data[i][3] = co.getVoc();			//Voc
			data[i][4] = co.getPmax();			//Pmax
			data[i][5] = co.getIPmax();			//IPmax
			data[i][6] = co.getVPmax();			//VPmax
			data[i][7] = co.getFF();			//FF
			data[i][8] = co.getIdCurva();		//id en la base de datos, necesario para obtener las seleccionadas

		}
		
				//------PANEL CURVAS	
				panelCurva = new JPanel();
				panelCurva.setBounds(0, 0, 609, 339);
				frame.getContentPane().add(panelCurva);
				panelCurva.setLayout(null);
				tablaCurvas = new JTable(data,columnName);
				tablaCurvas.setBounds(20, 11, 414, 183);
				
				
						JScrollPane scrollPane = new JScrollPane(tablaCurvas);
						scrollPane.setBounds(20, 11, 579, 278);
						panelCurva.add(scrollPane);
						
								//-----BOTON CORREGIR
								JButton btnCorregir = new JButton("Corregir");
								btnCorregir.addActionListener(new ActionListener() {
									public void actionPerformed(ActionEvent e) {
										//obtener todas las curvas que se han seleccionado
										for(int i = 0; i < listaDeCurvas.size();i++) {
											if( data[i][1].equals(Boolean.TRUE)) {

												int id = (int) data[i][8];				//PODRIA DAR FALLO, REVISAR
												try {
													listaDeCurvasACorregir.add( new CurvaOriginal(id) );
												} catch (ClassNotFoundException e1) {
													e1.printStackTrace();
												}
											}
										}
										//Si no se selecciona ninguna
										if(listaDeCurvasACorregir.isEmpty()) {
											JOptionPane.showMessageDialog(null, "No se han seleccionado curvas", "Aviso",JOptionPane.WARNING_MESSAGE);
										}else {
											panelCurva.setVisible(false);
											panelCorreccion.setVisible(true);
										}
									}
								});
								btnCorregir.setBounds(510, 300, 89, 23);
								panelCurva.add(btnCorregir);
								
										


		//------PANEL CORRECCION
		panelCorreccion = new JPanel();
		panelCorreccion.setBounds(0, 0, 609, 334);
		frame.getContentPane().add(panelCorreccion);
		panelCorreccion.setLayout(null);

		JLabel lblSeleccionarElMtodo = new JLabel("Seleccionar el m\u00E9todo de correci\u00F3n");
		lblSeleccionarElMtodo.setHorizontalAlignment(SwingConstants.CENTER);
		lblSeleccionarElMtodo.setFont(new Font("Tahoma", Font.PLAIN, 20));
		lblSeleccionarElMtodo.setBounds(10, 11, 589, 54);
		panelCorreccion.add(lblSeleccionarElMtodo);

		JLabel lblMtodosDeCorrecin = new JLabel("M\u00E9todos de correci\u00F3n");
		lblMtodosDeCorrecin.setHorizontalAlignment(SwingConstants.CENTER);
		lblMtodosDeCorrecin.setBounds(10, 76, 250, 14);
		panelCorreccion.add(lblMtodosDeCorrecin);
		//-----seleccionador
		Choice choiceMetodo = new Choice();
		choiceMetodo.add("IEC60891 m?todo 1");
		choiceMetodo.setBounds(10, 96, 250, 20);
		panelCorreccion.add(choiceMetodo);

		JLabel lblAlpha = new JLabel("Alpha");
		lblAlpha.setHorizontalAlignment(SwingConstants.CENTER);
		lblAlpha.setBounds(10, 146, 46, 14);
		panelCorreccion.add(lblAlpha);

		JLabel lblBetta = new JLabel("Betta");
		lblBetta.setHorizontalAlignment(SwingConstants.CENTER);
		lblBetta.setBounds(10, 171, 46, 14);
		panelCorreccion.add(lblBetta);

		JLabel lblRs = new JLabel("Rs");
		lblRs.setHorizontalAlignment(SwingConstants.CENTER);
		lblRs.setBounds(10, 196, 46, 14);
		panelCorreccion.add(lblRs);

		JLabel lblKappa = new JLabel("Kappa");
		lblKappa.setHorizontalAlignment(SwingConstants.CENTER);
		lblKappa.setBounds(10, 221, 46, 14);
		panelCorreccion.add(lblKappa);

		txtfAlpha = new JTextField();
		txtfAlpha.setBounds(103, 143, 109, 20);
		txtfAlpha.setText(String.valueOf(mod.getAlfa()));	//valor por defecto del m?dulo
		panelCorreccion.add(txtfAlpha);
		txtfAlpha.setColumns(10);

		txtfBetta = new JTextField();
		txtfBetta.setBounds(103, 168, 109, 20);
		txtfBetta.setText(String.valueOf(mod.getBeta()));	//valor por defecto del m?dulo
		panelCorreccion.add(txtfBetta);
		txtfBetta.setColumns(10);

		txtfRs = new JTextField();
		txtfRs.setBounds(103, 193, 109, 20);
		panelCorreccion.add(txtfRs);
		txtfRs.setColumns(10);

		txtfKappa = new JTextField();
		txtfKappa.setBounds(103, 218, 109, 20);
		txtfKappa.setText(String.valueOf(mod.getKappa()));	//valor por defecto del m?dulo
		panelCorreccion.add(txtfKappa);
		txtfKappa.setColumns(10);

		JLabel lblMedidaAlpha = new JLabel("mA/\u00BAC");
		lblMedidaAlpha.setHorizontalAlignment(SwingConstants.RIGHT);
		lblMedidaAlpha.setBounds(214, 146, 46, 14);
		panelCorreccion.add(lblMedidaAlpha);

		JLabel lblMedidaBetta = new JLabel("mV/\u00BAC");
		lblMedidaBetta.setHorizontalAlignment(SwingConstants.RIGHT);
		lblMedidaBetta.setBounds(214, 171, 46, 14);
		panelCorreccion.add(lblMedidaBetta);

		JLabel lblMedidaRs = new JLabel("\u03A9");
		lblMedidaRs.setHorizontalAlignment(SwingConstants.RIGHT);
		lblMedidaRs.setBounds(214, 196, 46, 14);
		panelCorreccion.add(lblMedidaRs);

		JLabel lblMedidaKappa = new JLabel("m\u03A9/\u00BAC");
		lblMedidaKappa.setHorizontalAlignment(SwingConstants.RIGHT);
		lblMedidaKappa.setBounds(214, 221, 46, 14);
		panelCorreccion.add(lblMedidaKappa);
		//-----BOTON CORREGIR
		JButton btnCorregir_1 = new JButton("Corregir");
		btnCorregir_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {

					if(choiceMetodo.getSelectedItem().equals("IEC60891 m?todo 1")) {
						CurvaCorregida curva_corregida = new CurvaCorregida();
						//AQUI SE INVOCAR?A EL M?TODO PARA LLAMAR A LA CURVA
						IntfzCurvaCorregida cci = new IntfzCurvaCorregida();
						cci.newScreen(curva_corregida);
					}
				}catch(Exception ex) {
					JOptionPane.showMessageDialog(null, ex.getMessage(),"ERROR!",JOptionPane.ERROR_MESSAGE);
				}

			}
		});
		btnCorregir_1.setBounds(455, 144, 89, 68);
		panelCorreccion.add(btnCorregir_1);
		//------BOTON ATRAS
		JButton btnAtras_correccion = new JButton("Atr\u00E1s");
		btnAtras_correccion.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {

				panelCorreccion.setVisible(false);
				panelCurva.setVisible(true);
			}
		});
		btnAtras_correccion.setBounds(10, 300, 89, 23);
		panelCorreccion.add(btnAtras_correccion);
		//-----necesario para la inicializacion
		panelCurva.setVisible(true);
		panelCorreccion.setVisible(false);
	}
}
