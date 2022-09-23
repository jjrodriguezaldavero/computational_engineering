/**********************************************************************************
* Implementaci�n de un algoritmo gen�tico - Vector Matching Problem 
*
* M�ster en Ingenier�a Computacional y Matem�tica
* Optimizaci�n Combinatoria
**********************************************************************************/

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class TestsManager{
    public static ArrayList<Test> getTestsList(String testsFilePath){
        ArrayList<Test> list = new ArrayList<>();
        try{
            FileReader reader = new FileReader(testsFilePath);
            Scanner in = new Scanner(reader);
            while(in.hasNextLine()){
                String s = in.next();
                if(s.charAt(0) == '#') in.nextLine();
                else{
                    String instanceName = s;
                    double maxTime = in.nextDouble(); // Tiempo computacional
                    int maxIter = in.nextInt(); // M�ximo n�mero de iteraciones
                    boolean geomSelect = in.nextBoolean(); // Seleccionar distribuci�n geom�trica
                    double beta = in.nextDouble(); // Par�metro de la distribuci�n geom�trica
                    int seed = in.nextInt(); // Semilla para el generador de n�meros aleatorios
                    int size = in.nextInt(); // Tama�o de la poblaci�n
                    double mRate = in.nextDouble(); // % de genes en un cromosoma que mutar�n
                    double cRate = in.nextDouble(); // % de soluciones que se recombinar�n
                    int elite = in.nextInt(); // # de soluciones �lite en una poblaci�n
                    Test aTest = new Test(instanceName, maxTime, maxIter, geomSelect, 
                            beta, seed, size, mRate, cRate, elite);
                    list.add(aTest);}}
            in.close();}
        catch (IOException exception){
            System.out.println("Error processing tests file: " + exception);}
        return list;}}