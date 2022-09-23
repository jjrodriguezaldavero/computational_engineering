/**********************************************************************************
* Implementaci�n de un algoritmo Multi-Start para resolver el PFSP. 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
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
     * M�TODO P�BLICO solve()
     * Resuelve la instancia con la heur�stica NEH
     ******************************************************************************/
    
	public Solution solve(Job[] effList, boolean useRandomSelection){	    	
		Solution currentSol = new Solution(nJobs, nMachines);
		if(!useRandomSelection) // Heur�stica cl�sica
			for(int i = 0; i < nJobs; i++)
                positions[i] = i;
		else{ // Versi�n aleatorizada
            Randomness random = new Randomness(aTest, inputs);
			positions = random.calcPositionsArray(aTest.getDistribution());}
		nextJob = effList[positions[0]]; 
		currentSol.getJobs()[0] = nextJob; // Inserta el primer trabajo en la soluci�n
		for(int i = 1; i < nJobs; i++) { // Completa la soluci�n con los otros trabajos
			nextJob = effList[positions[i]];
			currentSol.getJobs()[i] = nextJob;			
			currentSol.improveByShiftingJobToLeft(i);} // Intenta mejorar la soluci�n parcial
    	return currentSol;}	
}