/**********************************************************************************
* Implementaci�n de un algoritmo Multi-Start para resolver el PFSP. 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
**********************************************************************************/

public class Inputs{
	
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/

	private int nJobs; // N�mero de trabajos
	private int nMachines; // N�mero de m�quinas
	private Job[] jobs; // Array de trabajos
	
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
    
    public Inputs(int nJobsInProblem, int nMachinesInProblem){
    	nJobs = nJobsInProblem;
    	nMachines = nMachinesInProblem;
    	jobs = new Job[nJobs];
    	for( int i = 0; i < nJobs; i++)
    		jobs[i] = new Job(i, nMachines);}
    
    /*******************************************************************************
     * Getters 
     ******************************************************************************/
    
    public int getNumberOfJobs(){return nJobs;}
    
    public int getNumberOfMachines(){return nMachines;}
    
    public Job[] getJobs(){return jobs;}

    /*******************************************************************************
     * M�TODO P�BLICO clone()
     ******************************************************************************/

    @Override
    public Inputs clone(){
        Inputs in = new Inputs(nJobs,nMachines);
        for(int i = 0; i< nJobs; i++){
            for(int j = 0; j< nMachines; j++){
                in.jobs[i].setProcessingTime(j, this.jobs[i].getProcessingTime(j));}
            in.jobs[i].setTotalProcessingTime(this.jobs[i].getTotalProcessingTime());}
        return in;}    
}