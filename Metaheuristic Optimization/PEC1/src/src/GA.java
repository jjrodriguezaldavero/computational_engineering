/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.util.Arrays;
import java.util.Random;

/* Basic definitions: 
 *  > Gene: information bit (typically 0-1, but they can also be real numbers)
 *  > Chromosome: a string of genes that represents a solution
 *  > Population: a set of candidate chromosomes
 *  > Crossover: two 'parent' chromosomes are combined to generate 'offsprings'
 *  > Mutation: genes in a chromosome are randomly altered
 */

public class GA{
    private Test aTest;
    private Inputs inputs; 
    private Random rng;
    private double maxTime;
    private int maxIter;
    private boolean geometricSelect;
    private double beta;
    private int populationSize;
    private double mutationRate;
    private double crossoverRate;
    private int numberOfEliteSols;
    private byte[] targetChrom;
    private int chromLength;
    private Population population;
    private Solution obs;
    
    GA(Test userTest, Inputs userInputs){
        aTest = userTest;
        inputs = userInputs;
        maxTime = aTest.getMaxTime();
        maxIter = aTest.getMaxIter();
        geometricSelect = aTest.getGeomSelect();
        beta = aTest.getBeta();
        rng = new Random();
        rng = new Random(aTest.getSeed());
        populationSize = aTest.getPopSize();
        mutationRate = aTest.getMutationRate();
        crossoverRate = aTest.getCrossoverRate();
        numberOfEliteSols = aTest.getNumEliteSols();
        targetChrom = inputs.getTargetChrom();
        chromLength = targetChrom.length; 
        population = new Population(populationSize, chromLength); 
        double popFitness = 0.0; // se utiliza en la roulette wheel selection
        for(Solution sol:population.getSols()){   
        	double solFitness = calcSolFitnessVMP(sol);
            sol.setFitness(solFitness); // se utiliza para ordenar soluciones
            popFitness += solFitness;}
        population.setFitness(popFitness);
        Arrays.sort(population.getSols());
        obs = population.getSols()[0];} // devuelve la mejor solución
    
   public Solution solve(){   
        double elapsed = 0.0;
        int iter = 0;
        long start = ElapsedTime.systemTime();
        while (iter < maxIter && elapsed < maxTime){
            System.out.println("OBS in " + iter + " generations: " + obs.toString()
                   + " nCross=" + population.getNumberCrossovers() + 
                     " nMut=" + obs.getNumberMutations());
            population = crossoverPopVMP(population);
            Arrays.sort(population.getSols());
            population = mutatePopVMP(population);
            Arrays.sort(population.getSols());
            obs = population.getSols()[0];
            iter++;
            elapsed = ElapsedTime.calcElapsed(start, ElapsedTime.systemTime());}
        System.out.println("OBS in " + iter + " generations: " + obs.toString()
                   + " nCross=" + population.getNumberCrossovers() + 
                     " nMut=" + obs.getNumberMutations());
        return obs;}
      
    private double calcSolFitnessVMP(Solution sol){
    	int correctGenes = 0;
        for (int i = 0; i < chromLength; i++){
           // Añade 1 punto si coinciden
            if(sol.getChromosome()[i] == targetChrom[i]) correctGenes += 1;}
        // Calcula solFitness como %
        double solFitness = (double)correctGenes / chromLength;
        return solFitness;}

    private Population crossoverPopVMP(Population aSortedPop){
    	Population newPop = new Population(populationSize);
        for(int i = 0; i < populationSize; i++){ 
            Solution parent1 = aSortedPop.getSols()[i]; 
            // Decide si se aplica crossover (Parent1 no puede ser una solución elite)
            if(i > numberOfEliteSols && crossoverRate > Math.random()){
                Solution parent2;
                if(geometricSelect == false)
                    parent2 = selectParentSRW(aSortedPop); // Roulette Wheel 
                else 
                    parent2 = selectParentGeom(aSortedPop, beta); // distribución geométrica
                Solution offspring = new Solution(chromLength);
                newPop.setNumberCrossovers(newPop.getNumberCrossovers() + 1);
                for(int j = 0; j < chromLength; j++){
                    // Utiliza 50% de los genes de parent1 y 50% de parent2
                    if(0.5 > Math.random()) offspring.setGene(j, parent1.getChromosome()[j]);
                    else offspring.setGene(j, parent2.getChromosome()[j]);}
                double offspringFit = calcSolFitnessVMP(offspring);
                offspring.setFitness(offspringFit);
                newPop.setFitness(newPop.getFitness() + offspringFit);
                newPop.setSol(i, offspring);}
            else{ // Añade parent1 a la nueva población
                newPop.setSol(i, parent1);
                newPop.setFitness(newPop.getFitness() + parent1.getFitness());}}
        return newPop;}

    private Population mutatePopVMP(Population aSortedPop){
        for(int i = 0; i < populationSize; i++){
        	// Evita si se trata de una solución élite
            if(i >= numberOfEliteSols){
                Solution sol = aSortedPop.getSols()[i];
                double solOldFit = sol.getFitness();
                for(int j = 0; j < chromLength; j++){   
                    if(mutationRate > Math.random()){
                        sol.setNumberMutations(sol.getNumberMutations() + 1);
                        byte newGene = 1;
                        if(sol.getChromosome()[j] == 1) newGene = 0;
                        sol.setGene(j, newGene);}}
                double solNewFit = calcSolFitnessVMP(sol);
                sol.setFitness(solNewFit);
                aSortedPop.setFitness(aSortedPop.getFitness() + solNewFit - solOldFit);}}
        return aSortedPop;}
    
    private Solution selectParentSRW(Population population){
    	Solution[] sols = population.getSols();
        double popFitness = population.getFitness();
        double rouletteWheelPosition = Math.random() * popFitness;
        double spinWheel = 0;
        for(Solution sol:sols){
           spinWheel += sol.getFitness();
            if(spinWheel >= rouletteWheelPosition) return sol;}
        return sols[population.getSols().length - 1];}
    
    private Solution selectParentGeom(Population population, double beta){
    	Solution[] sols = population.getSols();
        int index = (int) (Math.log(rng.nextDouble()) / Math.log(1 - beta));
        index = index % sols.length;
        return sols[index];}}