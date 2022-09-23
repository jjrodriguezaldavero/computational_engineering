/**********************************************************************************
* Implementaci�n de un algoritmo Multi-Start para resolver el PFSP. 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
**********************************************************************************/

public class Solution{
    
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/
	
    private static int nInstances = 0;
    private int id; 
    private int costs; // Costes = tiempo de procesamiento final
    private int nJobs;
    private Job[] jobs;
    private int nMachines; 
    private double time; // Tiempo computacional en segundos 
    
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
    
    public Solution(int nJobsInProblem, int nMachinesInProblem){
        nInstances++;
        id = nInstances;
        costs = 0;
        nJobs = nJobsInProblem;
        jobs = new Job[nJobs];
        nMachines = nMachinesInProblem;
        time = 0;}
	
    /*******************************************************************************
     * Getters y Setters 
     ******************************************************************************/ 
    
    public int getId(){return id;}
    
    public int getCosts(){return costs;}
    
    public Job[] getJobs(){return jobs;}

    public double getTime(){return time;}
    
    public int getNJobs(){return nJobs;}
    
    public int getNMachines(){return nMachines;}
    
    public void setCosts(int c){costs = c;}
    
    public void setTime(double t){time = t;}

    /*******************************************************************************
     * M�TODO P�BLICO clone()
     ******************************************************************************/
    
    @Override
    public Solution clone(){
		Solution bSol = new Solution(nJobs, nMachines);
		for( int i = 0; i < nJobs; i++ ){
			bSol.getJobs()[i] = jobs[i];}
		bSol.setCosts(this.getCosts());
        bSol.setTime(this.getTime());
		return bSol;}
    
	/******************************************************************************* 
     * M�TODO P�BLICO calcTotalCosts()
     * Calcula el tiempo de procesamiento final 
     ******************************************************************************/ 
    
    public int calcTotalCosts(int nUsedJobs){
    	// nUsedJobs = n�mero de trabajos en la soluci�n parcial
    	int[][] tcosts = new int[nUsedJobs][nMachines];
    	for(int column = 0; column < nMachines; column++)
    		for(int row = 0; row < nUsedJobs; row++){
    			if(column == 0 && row == 0)
    				tcosts[0][0] = jobs[0].getProcessingTime(0);
    			else if(column == 0)
    				tcosts[row][0] = tcosts[row - 1][0] + jobs[row].getProcessingTime(0);
    			else if(row == 0)
    				tcosts[0][column] = tcosts[0][column - 1] + jobs[0].getProcessingTime(column);
    			else{
    				int max = Math.max(tcosts[row - 1][column],	tcosts[row][column - 1]);
    				tcosts[row][column] =  max + jobs[row].getProcessingTime(column);}}   	
        return tcosts[nUsedJobs - 1][nMachines - 1];}
    
	/******************************************************************************* 
     * M�TODO P�BLICO improveByShiftingJobToLeft()
     * Implementa el procedimiento de desplazamiento a la izquierda para encontrar una secuencia de trabajos mejor.
     * k es la posici�n de un trabajo desde la derecha.
     * Utiliza las aceleraciones de Taillard (matrices) para hacerlo de manera m�s r�pida.
     * 
     * Taillard, E., 1990. Some efficient heuristic methods for the flow shop sequencing problem. 
     * European Journal of Operational Research 47, 65-74.  
     ******************************************************************************/ 
   
    public void improveByShiftingJobToLeft(int k){
    	int bestPosition = k;
       	int minMakespan = Integer.MAX_VALUE;
       	int newMakespan = Integer.MAX_VALUE;       	
       	int[][] eMatrix = null;
        int[][] qMatrix = null;
        int[][] fMatrix = null;
        int maxSum = 0;
        int newSum = 0;           	
        eMatrix = calcEMatrix(k);
        qMatrix = calcQMatrix(k);
        fMatrix = calcFMatrix(k, eMatrix);           	
        // Calcula la mejor posici�n (entre 0 y k) y el makespan m�nimo
        for(int i = k; i >= 0; i--){
        	maxSum = 0;
           	for(int j = 0; j < nMachines; j++){
           		newSum = fMatrix[i][j] + qMatrix[i][j];
           		if(newSum > maxSum)
           			maxSum = newSum;}
           	newMakespan = maxSum;
           	if(newMakespan <= minMakespan){		
           		minMakespan = newMakespan;
       			bestPosition = i;}}   	       	
        // Actualiza la soluci�n
        if(bestPosition < k){ // Si i == k no hace nada
            Job auxJob = jobs[k];
            for( int i = k; i > bestPosition; i-- )
            	jobs[i] = jobs[i - 1];
            jobs[bestPosition] = auxJob;}
        this.setCosts(minMakespan);}
	
	/******************************************************************************* 
     * M�TODO PRIVADO calcEMatrix()
     * M�todo auxiliar 
     ******************************************************************************/  

	private int[][] calcEMatrix(int k){
		int[][] e = new int[k][nMachines];		
		for(int i = 0; i < k; i++){
			for(int j = 0; j < nMachines; j++){
				if(i == 0 && j == 0)
    				e[0][0] = jobs[0].getProcessingTime(0);
    			else if(j == 0)
    				e[i][0] = e[i-1][0] + jobs[i].getProcessingTime(0);
    			else if(i == 0)
    				e[0][j] = e[0][j-1] + jobs[0].getProcessingTime(j);
    			else{
    				int max = Math.max(e[i-1][j], e[i][j-1]);
    				e[i][j] =  max + jobs[i].getProcessingTime(j);}}}
		return e;}
	
	/******************************************************************************* 
     * M�TODO PRIVADO calcQMatrix()
     * M�todo auxiliar 
     ******************************************************************************/ 

	private int[][] calcQMatrix(int k){
		int[][] q = new int[k + 1][nMachines];		
		for(int i = k; i >= 0; i--){
			for(int j = nMachines - 1; j >= 0; j--){
				if(i == k)
					q[k][j] = 0;
				else if(i == k - 1 && j == nMachines - 1)
    				q[k-1][nMachines-1] = jobs[k-1].getProcessingTime(nMachines-1);
    			else if(j == nMachines - 1)
    				q[i][nMachines-1] = q[i+1][nMachines-1] + 
    					jobs[i].getProcessingTime(nMachines - 1);
    			else if(i == k - 1)
    				q[k-1][j] = q[k-1][j+1] + jobs[k-1].getProcessingTime(j);
    			else{
    				int max = Math.max(q[i + 1][j], q[i][j + 1]);
    				q[i][j] =  max + jobs[i].getProcessingTime(j);}}}
		return q;}
	
	/******************************************************************************* 
     * M�TODO PRIVADO calcFMatrix()
     * M�todo auxiliar 
     ******************************************************************************/ 

	private int[][] calcFMatrix(int k, int[][] e){
		int[][] f = new int[k + 1][nMachines];	
		for(int i = 0; i <= k; i++){
			for(int j = 0; j < nMachines; j++){
				if(i == 0 && j == 0)
    				f[0][0] = jobs[k].getProcessingTime(0);
    			else if(j == 0)
    				f[i][0] = e[i-1][0] + jobs[k].getProcessingTime(0);
    			else if(i == 0)
    				f[0][j] = f[0][j-1] + jobs[k].getProcessingTime(j);
    			else{
    				int max = Math.max(e[i-1][j], f[i][j-1]);
    				f[i][j] =  max + jobs[k].getProcessingTime(j);}}}
		return f;}
    
    /*******************************************************************************
     * M�TODO P�BLICO toString()
     ******************************************************************************/
    
    public String toString(boolean printDetails){
    	String s = "";
    	s = s.concat("\r\n");
        s = s.concat("Sol ID : " + this.id + "\r\n");
        s = s.concat("Sol costs: " + this.costs + "\r\n");
        double time = this.time;
        int timeInt = (int) Math.round(time);
        s = s.concat("Sol time: " + ElapsedTime.calcHMS(timeInt) + "(" + time  + " sec.)");
        s = s.concat("\r\n");
        if(printDetails){
        	s = s.concat("List of jobs: \r\n");
            for(int i = 0; i < jobs.length; i++)
                s = s.concat("" + jobs[i].getId() + "\r\n");}	
        return s;}
}