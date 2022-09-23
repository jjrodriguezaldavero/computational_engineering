/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.util.Random;

public class Randomness{
	
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/
    
    private Test aTest;
    private Inputs inputs;
    
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/

    public Randomness(Test test, Inputs inputData){     
    	aTest = test;
    	inputs = inputData;}

	/******************************************************************************* 
     * MÉTODO PÚBLICO calcPositionsArray()
     * Genera un secuencia de valores de acuerdo con una distribución y los correspondientes parámetros 
     ******************************************************************************/
    
    public int[] calcPositionsArray(String distribution){
        int nJobs = inputs.getNumberOfJobs();
    	int[] posArray = new int[nJobs];
    	int[] auxArray = new int[nJobs];
    	for(int i = 0; i < nJobs; i++) auxArray[i] = i;
    	for( int i = 0; i < nJobs; i++ ){
    		int pos = getRandomPosition(nJobs - i, distribution);
    		posArray[i] = auxArray[pos];
    		for( int j = pos; j < nJobs - i - 1; j++ )
    			auxArray[j] = auxArray[j + 1];}
    	return posArray;}

	/******************************************************************************* 
     * MÉTODO PÚBLICO getRandomPosition()
     * Genera un valor de acuerdo con una distribución y los correspondientes parámetros 
     ******************************************************************************/
    
    public int getRandomPosition(int n, String dist){
        Random rng = aTest.getRandom();
    	int pos = 0;
    	char distribution = dist.charAt(0);
    	if(distribution == 't'||distribution == 'T'){ // Distribución Triangular
    		pos = (int) (n * (1 - Math.sqrt(rng.nextDouble())));}
    	else if(distribution == 'g' || distribution == 'G'){ // Distribución Geométrica
            double beta = rng.nextDouble() * (aTest.getBeta2() - aTest.getBeta1()) + aTest.getBeta1(); // Calcula un valor aleatorio entre los dos dados
    		pos = (int) ( Math.log(rng.nextDouble()) / Math.log(1 - beta) );
    		pos = pos % n;}
    	else{ // Distribución Uniforme            
            pos = (int) (n * rng.nextDouble());}
    	return pos;}    
}