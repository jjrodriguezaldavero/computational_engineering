/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.io.IOException;
import java.io.PrintWriter;

public class Outputs{
    private Solution ourBestSol;
    
    public Outputs(){ourBestSol = null;}

    public void setOBSol(Solution obSol){ourBestSol = obSol;}
    public Solution getOBSol(){return ourBestSol;}

    public void printToFile(String outFile){
        try{ 
            PrintWriter out = new PrintWriter(outFile);
            out.println("***************************************************");
            out.println("*                      OUTPUTS                    *");
            out.println("***************************************************");
            out.println("\r\n");
            out.println("--------------------------------------------");
            out.println("\r\n OUR BEST SOLUTION:\r\n");
            out.println("--------------------------------------------");
            out.println(ourBestSol.toString() + "\r\n");
            out.close();
        }catch (IOException exception){ 
            System.out.println("Error processing output file: " + exception);}}}