/**********************************************************************************
* Implementaci�n de un algoritmo gen�tico - Vector Matching Problem 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
**********************************************************************************/

public class Test{
    private String instanceName;
    private double maxTime; // Tiempo computacional
    private int maxIter; // M�ximo n�mero de iteraciones
    private boolean geomSelect; // Seleccionar distribuci�n geom�trica
    private double beta; // Par�metro de la distribuci�n geom�trica
    private int seed; // Semilla para el generador de n�meros aleatorios
    private int popSize; // Tama�o de la poblaci�n
    private double mutationRate; // % de genes en un cromosoma que mutar�n
    private double crossoverRate; // % de soluciones que se recombinar�n
    private int numEliteSols; // # de soluciones �lite en una poblaci�n
   
    public Test(String name, double time, int iter, boolean gS, double b, 
            int s, int size, double mRate, double cRate, int elite){
        instanceName = name;
        maxTime = time;
        maxIter = iter;
        geomSelect = gS;
        beta = b;
        seed = s;
        popSize = size;
        mutationRate = mRate;
        crossoverRate = cRate;
        numEliteSols = elite;}

    public String getInstanceName(){return instanceName;}
    public double getMaxTime(){return maxTime;}
    public int getMaxIter(){return maxIter;}
    public boolean getGeomSelect(){return geomSelect;}
    public double getBeta(){return beta;}
    public int getSeed(){return seed;}
    public int getPopSize(){return popSize;}
    public double getMutationRate(){return mutationRate;}
    public double getCrossoverRate(){return crossoverRate;}
    public int getNumEliteSols(){return numEliteSols;}}