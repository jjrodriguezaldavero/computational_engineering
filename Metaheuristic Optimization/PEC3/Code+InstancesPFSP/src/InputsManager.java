/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class InputsManager{

    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/

	private String filePath; // path del archivo de inputs
	private Inputs inputs; 
	
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
    
    public InputsManager(String inputsFilePath){
    	filePath = inputsFilePath;}
    
    /*******************************************************************************
     * MÉTODO PÚBLICO getInputs()
     * Lee, guarda y devuelve inputs
     ******************************************************************************/
    
    public Inputs getInputs(){
    	try{
        	FileReader reader = new FileReader(filePath);
            Scanner in = new Scanner(reader);
            in.nextLine(); // Salta la primera línea
            int nJobs = in.nextInt();
            int nMachines = in.nextInt();
            inputs = new Inputs(nJobs, nMachines);           
            in.nextLine(); 
            in.nextLine(); 
            for(int i = 0; i < nJobs; i++){
            	Job iJob = inputs.getJobs()[i];
            	int totalTime = 0;
            	int time = 0;
            	for(int j = 0; j < nMachines; j++){
                    time = in.nextInt();
                    iJob.setProcessingTime(j, time);
                    totalTime = totalTime + time;}
            	iJob.setTotalProcessingTime(totalTime);}
            in.close();}
        catch (IOException exception){ 
          	System.out.println("Error processing inputs file: " + exception);}
    	return inputs;}    
}