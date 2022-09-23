/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

public class Solution implements Comparable<Solution>{
    private byte[] chromosome; // cromosoma
    private double fitness = 0.0; // max fitness <-> min cost
    private int nMutations = 0; // # mutaciones
    
    public Solution(byte[] aChromosome){
    	chromosome = aChromosome;}
    
    public Solution(int chromLength){
    	chromosome = new byte[chromLength];
        for(int gene = 0; gene < chromLength; gene++){
        	if(0.5 < Math.random()) chromosome[gene] = 1;
            else chromosome[gene] = 0;}}
    
    public byte[] getChromosome(){return chromosome;}
    public double getFitness(){return fitness;}
    public int getNumberMutations(){return nMutations;}
    
    public void setGene(int i, byte gene){chromosome[i] = gene;}
    public void setFitness(double fit){fitness = fit;}
    public void setNumberMutations(int m){nMutations = m;}
    
    @Override
    public String toString(){
    	String output = "";
        for(int gene = 0; gene < chromosome.length; gene++)
            output += chromosome[gene];
        output += " solFit=" + fitness;
        return output;}

    @Override
    public int compareTo(Solution other){   
    	if(this.getFitness() > other.getFitness()) return -1;
        else if (this.getFitness() < other.getFitness()) return 1;
        return 0;}}