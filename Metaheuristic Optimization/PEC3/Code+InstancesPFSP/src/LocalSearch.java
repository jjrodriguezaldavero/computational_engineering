/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

public class LocalSearch{
    
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/
     
    private Test aTest;
    private Inputs inputs;
    private Randomness random;
    private int nJobs;
    
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
      
    public LocalSearch(Test test, Inputs inputData){     
    	aTest = test;
    	inputs = inputData;
        random = new Randomness(aTest, inputs);
    	nJobs = inputs.getNumberOfJobs();}				

	/******************************************************************************* 
     * Podéis utilizar esta clase para implementar vuestros procedimientos. 
     * La idea es que dada una solución (es decir, una secuencia de valores, por ejemplo: {1,2,3,5,4}), 
     * encontréis una similar con la que compararla.
     ******************************************************************************/
}