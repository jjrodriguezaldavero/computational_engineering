/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

public class Test{
    private String instanceName;
    private double maxTime; // Tiempo computacional
    private int maxIter; // Máximo número de iteraciones
    private boolean geomSelect; // Seleccionar distribución geométrica
    private double beta; // Parámetro de la distribución geométrica
    private int seed; // Semilla para el generador de números aleatorios
    private int popSize; // Tamaño de la población
    private double mutationRate; // % de genes en un cromosoma que mutarán
    private double crossoverRate; // % de soluciones que se recombinarán
    private int numEliteSols; // # de soluciones élite en una población
   
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