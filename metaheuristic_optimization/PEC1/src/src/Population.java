/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.util.Random;

public class Population{
    private Solution[] sols; // población: array de soluciones
    private double fitness = 0.0; // max fitness <-> min cost
    private int nCrossovers = 0; // # crossovers
    
    public Population(int populationSize){
       sols = new Solution[populationSize];}
    
    public Population(int popSize, int chromLength){
        sols = new Solution[popSize];
        for(int i = 0; i < popSize; i++){
            Solution sol = new Solution(chromLength);
            sols[i] = sol;}}
    
    public Solution[] getSols(){return sols;}
    public int getNumberCrossovers(){return nCrossovers;}
    public double getFitness(){return fitness;}
    
    public void setFitness(double fit){fitness = fit;} 
    public void setSol(int i, Solution sol){sols[i] = sol;}
    public void setNumberCrossovers(int n){nCrossovers = n;}
    
    public void shuffle(){
    	Random rnd = new Random();
        for(int i = sols.length - 1; i > 0; i--){
            int index = rnd.nextInt(i + 1);
            Solution aux = sols[index];
            sols[index] = sols[i];
            sols[i] = aux;}}}