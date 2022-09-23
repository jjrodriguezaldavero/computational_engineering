/**********************************************************************************
* Implementaci�n de un algoritmo Multi-Start para resolver el PFSP. 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
**********************************************************************************/

public class Job implements Comparable<Job>{
	
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/
	
	private int id; // Identificaci�n del trabajo
	private int[] processingTimes; // Array con el tiempo de procesamiento de cada m�quina 
	private int totalProcessingTime; // Tiempo total de procesamiento
        
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
  
    public Job(int order, int nMachines){
    	id = order + 1;
    	processingTimes = new int[nMachines];
    	totalProcessingTime = 0;}
	
    /*******************************************************************************
     * Getters y Setters 
     ******************************************************************************/
   
    public int getId(){return id;}
    
    public int getProcessingTime(int machine){return processingTimes[machine];}
    
    public int getTotalProcessingTime(){return totalProcessingTime;}
    
    public void setId(int jobId){id = jobId;}
         
    public void setProcessingTime(int machine, int time){
        processingTimes[machine] = time;}
    
    public void setTotalProcessingTime(int time){
        totalProcessingTime = time;}
    
    /*******************************************************************************
     * M�TODO P�BLICO compareTo()
     * Ordena los trabajos en funci�n del tiempo total de procesamiento, 
     * de m�s a menos. Empates ordenados de manera aleatoria. 
     ******************************************************************************/
    
    public int compareTo(Job otherJob){
    	Job other = otherJob;
    	int s1 = this.totalProcessingTime;
    	int s2 = other.totalProcessingTime;
    	int value;
    	if(s1 > s2) value = -1;
    	else if(s1 < s2) value = 1;
    	else if(s1 == s2 && Math.random() > 0.5 )
    		value = -1; 
    	else value = 1;
    	return value;}
    
    /*******************************************************************************
     * M�TODO P�BLICO toString()
     ******************************************************************************/
        
    public String toString(){
        String s = "";
        s = s.concat("\n Job Id: " + this.id + " ");
        s = s.concat("\n Job Total Time: " + this.totalProcessingTime + " ");
        return s;}
}