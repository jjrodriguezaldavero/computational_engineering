/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

public class RandNEHT{ 
	
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/
     
    private Test aTest;
    private Inputs inputs;
    private int nJobs;
    private int nMachines;
    private int[] positions;
    private Job nextJob;
    
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
      
    public RandNEHT(Test test, Inputs inputData){     
    	aTest = test;
    	inputs = inputData;
    	nJobs = inputs.getNumberOfJobs();
    	nMachines = inputs.getNumberOfMachines();
    	positions = new int[nJobs];
        nextJob = null;}				
 	
	/******************************************************************************* 
     * MÉTODO PÚBLICO solve()
     * Resuelve la instancia con la heurística NEH
     ******************************************************************************/
    
	public Solution solve(Job[] effList, boolean useRandomSelection){	    	
		Solution currentSol = new Solution(nJobs, nMachines);
		if(!useRandomSelection) // Heurística clásica
			for(int i = 0; i < nJobs; i++)
                positions[i] = i;
		else{ // Versión aleatorizada
            Randomness random = new Randomness(aTest, inputs);
			positions = random.calcPositionsArray(aTest.getDistribution());}
		nextJob = effList[positions[0]]; 
		currentSol.getJobs()[0] = nextJob; // Inserta el primer trabajo en la solución
		for(int i = 1; i < nJobs; i++) { // Completa la solución con los otros trabajos
			nextJob = effList[positions[i]];
			currentSol.getJobs()[i] = nextJob;			
			currentSol.improveByShiftingJobToLeft(i);} // Intenta mejorar la solución parcial
    	return currentSol;}	
}