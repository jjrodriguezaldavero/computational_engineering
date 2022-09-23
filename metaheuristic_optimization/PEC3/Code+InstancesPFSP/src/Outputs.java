/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.io.IOException;
import java.io.PrintWriter;

public class Outputs{

    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/

	private Solution nehSol; // Solución con la heurística clásica
	private Solution ourBestSol; // Solución aplicando técnicas de aleatorización sesgada
	
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
    
    public Outputs(Solution neh, Solution obs){
    	nehSol = neh;
    	ourBestSol = obs;}
    
    /*******************************************************************************
     * Getters 
     ******************************************************************************/

    public Solution getOurBestSol(){return ourBestSol;}
    
    public Solution getNehSol(){return nehSol;}

	/******************************************************************************* 
     * MÉTODO PÚBLICO sendToFile()
     * Guarda las soluciones en un documento
     ******************************************************************************/
    
    public void sendToFile(String filePath){
    	try{
    		PrintWriter out = new PrintWriter(filePath);
    	    out.println("***************************************************");
    	    out.println("*                     RESULTS                     *");
    	    out.println("***************************************************");    	        
    	    out.println("\r\n");
    	    out.println("--------------------------------------------");
            out.println("               NEH Solution                 ");
            out.println("--------------------------------------------");
            out.println(nehSol.toString(true));    	    
            out.println("\r\n");
    	    out.println("--------------------------------------------");
            out.println("Our best solution (provided by the SS-GNEH) ");
            out.println("--------------------------------------------");
            out.println(ourBestSol.toString(true));    	        
    	    out.close();}
    	catch (IOException exception){ 
    		System.out.println("Error processing outputs file: " + exception);}}
}