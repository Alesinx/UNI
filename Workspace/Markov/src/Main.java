import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Main {
	
	final static int TAM = 40;
	final static int cons = 20;
	final static int zero = 10^-6;
	
	public static void main(String[] args) {
		
		List<Integer> array = new ArrayList<Integer>(); 
		
		//Lectura fichero
		try {
			FileReader f = new FileReader("C:/Users/Alex/Documents/Universidad/3�/Criticos/datos.txt");
			BufferedReader b = new BufferedReader(f);
			
			String ant = b.readLine();
			String current = b.readLine();
			
			while(current !=null) {
				array.add(Integer.valueOf(current)-Integer.valueOf(ant));
				
				ant = current;
				current = b.readLine();
			}
			b.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int[][] markov = new int[TAM][TAM];
		int [] sumRow = new int [TAM];
		
		/*
		for (int i = 0; i < TAM; i++) {
			for (int j = 0; j < TAM; j++) {
				markov[i][j] = 0;
			}
		}
		*/
		
		Iterator<Integer> it = array.iterator();
		int fst = it.next(); //Fila
		int snd = it.next(); //Columna y valor
		for (int i = 0; i < array.size()-2; i++) {
			markov[cons-fst][cons-snd]++;
			
			fst = snd;
			snd = it.next();
		}
		
		for (int i = 0; i < TAM - 1; i++) {
			for (int j = 0; j < TAM - 1; j++) {
				if (markov[i][j] == 0) {
					markov[i][j] = zero;
				}
				sumRow[i] += markov[i][j];
			}
		}


		//calculo de probabilidades
		for (int i = 0; i < TAM - 1; i++) {
			for (int j = 0; j < TAM - 1; j++) {
				markov[i][j] = (markov[i][j] / sumRow[i]);
				
				/*
				if(markov[i][j] < probMin){
					probMin = markov[i][j];
				}
				*/
			}
		}

		//leer nuevos datos
			//comparar los valores con el minimo (probMin)
				//ventana de 5??
		int[] variaciones = new int[5];
		int probMin = 1;
		
		Iterator<Integer> iterator = array.iterator();
		
		for (int i = 0; i < variaciones.length; i++) { //Primera asignacion
			variaciones[i] = iterator.next();
		}
		
		for (int i = 0; i < variaciones.length-1; i++) { //Primer minimo
			probMin = probMin*markov[variaciones[i]][variaciones[i+1]];
		}
		
		int min = 1;
		while (iterator.hasNext()) {
			for(int i=0;i<variaciones.length - 1;i++) {
				variaciones[i] = variaciones[i+1];
			}
			variaciones[4] = iterator.next();
			
			for (int i = 0; i < variaciones.length-1; i++) {
				min = min*markov[variaciones[i]][variaciones[i+1]];
			}
			
			if(min < probMin) {
				probMin = min;
			}
		}
	//----------------------------------------------

		int[] temp = new int[6];
		int[] vars = new int[5];
	
		//Lectura fichero
		try {
			FileReader f = new FileReader("C:/Users/Alex/Documents/Universidad/3�/Criticos/datos.txt");
			BufferedReader b = new BufferedReader(f);
				
			String ant = b.readLine();
			String current = b.readLine();
			temp[0] = Integer.valueOf(ant);
			temp[1] = Integer.valueOf(current);
			
			for (int i = 0; i < vars.length - 1 ;i++) { //ERROR: int i = 0; i < vars.length ;i++

				vars[i] = Integer.valueOf(current)-Integer.valueOf(ant); 
				
				ant = current;
				current = b.readLine();
				temp[i+2] = temp[1] = Integer.valueOf(current); // guardando las temperaturas nuevas
			}

			int v = 1;
			for (int i = 0; i < vars.length-1; i++) { //Primer minimo
				v = v*markov[vars[i]][vars[i+1]];
			}
			
			while(current !=null) {
				for (int i = 0; i < vars.length - 2;i++) { // ERROR: for (int i = 0; i < vars.length-1;i++)
					vars[i] = vars[i+1];
				}
				vars[vars.length - 1] = Integer.valueOf(current)-Integer.valueOf(ant);
				
				ant = current;
				current = b.readLine();

				for(int i = 0; i < temp.length - 2; i++){ //desplazando los valores del array de temperaturas
					temp[i] = temp[i+1];
				}
				temp[temp.length - 1] = Integer.valueOf(current);
				
				min = 1;
				for (int i = 0; i < vars.length-1;i++) { //Calcula la probabilidad de la ventana actual
					min = min*markov[vars[i]][vars[i+1]];
				}
				
				if (min < probMin) { //Compara el valor de la probabilidad con el valor minimo obtenido en el entrenamiento, si es mas pequeño se trata de una anomalia
					System.out.println("Aqu� hemos detectado una anomalia: " + min + " < " + probMin);
					StringBuilder st = new StringBuilder();
					for (int i = 0;i < temp.length -1; i++){
						st.append("[" + temp[i] + " ] ");
					}
					System.out.println(st.toString()); //?
				}
			}
			b.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
