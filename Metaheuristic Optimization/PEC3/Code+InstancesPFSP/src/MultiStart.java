/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.util.Arrays;

public class MultiStart{
	
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/
	
	private Test aTest;
	private Inputs inputs;
    private Outputs output;
    private int nJobs;     
	private Job[] effList;
    private Solution nehSol;
	private RandNEHT nehtAlg;
    private LocalSearch locSearch;
	long startTime;

	/******************************************************************************* 
     * Constructor
     ******************************************************************************/

    public MultiStart(Test test, Inputs inputData){
    	aTest = test;
    	inputs = inputData;
    	effList = createEffList();
        nJobs = inputs.getNumberOfJobs();
    	nehtAlg = new RandNEHT(aTest, inputs);
        locSearch = new LocalSearch(aTest, inputs);
    	startTime = ElapsedTime.systemTime();
    	nehSol = nehtAlg.solve(effList, false);
    	nehSol.setTime(ElapsedTime.calcElapsed(startTime, ElapsedTime.systemTime()));}

    /*******************************************************************************
     * Getter 
     ******************************************************************************/ 

    public Outputs getOutput() {
        return output;}

    /*******************************************************************************
     * MÉTODO PÚBLICO run()
     * Calcula una solución con la heurística NEH (versión aleatorizada) y intenta mejorarla
     * aplicando un local search 
     ******************************************************************************/

    public void run(){
        Solution aSol;
    	startTime = ElapsedTime.systemTime();
    	double elapsed = 0.0;
        do{
           aSol = nehtAlg.solve(effList, true);
        }while(aSol.getCosts() > nehSol.getCosts());
        elapsed = ElapsedTime.calcElapsed(startTime, ElapsedTime.systemTime());
        aSol.setTime(elapsed);
        int nRuns = 0;
    	double maxTime = 0.010 * inputs.getNumberOfJobs() * inputs.getNumberOfMachines();
        while(elapsed < maxTime){
            Solution expSol = aSol.clone();
            // Incluir localSearch aquí
            expSol.setCosts(expSol.calcTotalCosts(nJobs));
            elapsed = ElapsedTime.calcElapsed(startTime, ElapsedTime.systemTime());
            if(expSol.getCosts() < aSol.getCosts()){
                aSol = expSol;
                aSol.setTime(elapsed);}            
            nRuns++;}
        System.out.println(aTest.getInstanceName() + " " + nehSol.getCosts() + " " + aSol.getCosts() + " " + aSol.getTime() + " " + nRuns);
    	output = new Outputs(nehSol, aSol);}

    /*******************************************************************************
     * MÉTODO PRIVADO createEffList()
     * Ordena los trabajos de acuerdo con el tiempo total de procesamiento
     ******************************************************************************/

    private Job[] createEffList(){
    	Job[] array = inputs.getJobs();
    	Arrays.sort(array);
        return array;}}