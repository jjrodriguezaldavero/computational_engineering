/**********************************************************************************
* Implementaci�n de un algoritmo Multi-Start para resolver el PFSP. 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
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
     * Pod�is utilizar esta clase para implementar vuestros procedimientos. 
     * La idea es que dada una soluci�n (es decir, una secuencia de valores, por ejemplo: {1,2,3,5,4}), 
     * encontr�is una similar con la que compararla.
     ******************************************************************************/
}