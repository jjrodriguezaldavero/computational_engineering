/**********************************************************************************
* Implementaci�n de un algoritmo Multi-Start para resolver el PFSP. 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
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
     * M�TODO P�BLICO calcPositionsArray()
     * Genera un secuencia de valores de acuerdo con una distribuci�n y los correspondientes par�metros 
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
     * M�TODO P�BLICO getRandomPosition()
     * Genera un valor de acuerdo con una distribuci�n y los correspondientes par�metros 
     ******************************************************************************/
    
    public int getRandomPosition(int n, String dist){
        Random rng = aTest.getRandom();
    	int pos = 0;
    	char distribution = dist.charAt(0);
    	if(distribution == 't'||distribution == 'T'){ // Distribuci�n Triangular
    		pos = (int) (n * (1 - Math.sqrt(rng.nextDouble())));}
    	else if(distribution == 'g' || distribution == 'G'){ // Distribuci�n Geom�trica
            double beta = rng.nextDouble() * (aTest.getBeta2() - aTest.getBeta1()) + aTest.getBeta1(); // Calcula un valor aleatorio entre los dos dados
    		pos = (int) ( Math.log(rng.nextDouble()) / Math.log(1 - beta) );
    		pos = pos % n;}
    	else{ // Distribuci�n Uniforme            
            pos = (int) (n * rng.nextDouble());}
    	return pos;}    
}