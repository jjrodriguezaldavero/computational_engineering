/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.util.Random;

public class Test{

    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/

	private String instanceName; 
	private String distribution;
	private float beta1, beta2;
	private int seed;
    private Random rng;

	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
    
    public Test(String name, String d, float b1, float b2, int s){
    	instanceName = name;
    	distribution = d;
    	beta1 = b1;
    	beta2 = b2;
    	seed = s;}
	
    /*******************************************************************************
     * Getters y Setters
     ******************************************************************************/
    
    public String getInstanceName(){return instanceName;}
    
    public String getDistribution(){return distribution;}
    
    public float getBeta1(){return beta1;}
    
    public float getBeta2(){return beta2;}
    
    public int getSeed(){return seed;}

    public Random getRandom(){return rng;}

    public void setRandom(Random rng){this.rng = rng;}

    /*******************************************************************************
     * MÉTODO PÚBLICO clone()
     ******************************************************************************/

    @Override
    public Test clone(){
        Test t = new Test(instanceName, distribution, beta1, beta2, seed);
        t.setRandom(rng);        
        return t;}
}