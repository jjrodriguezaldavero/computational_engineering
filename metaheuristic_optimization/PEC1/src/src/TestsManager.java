/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
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
                    int maxIter = in.nextInt(); // Máximo número de iteraciones
                    boolean geomSelect = in.nextBoolean(); // Seleccionar distribución geométrica
                    double beta = in.nextDouble(); // Parámetro de la distribución geométrica
                    int seed = in.nextInt(); // Semilla para el generador de números aleatorios
                    int size = in.nextInt(); // Tamaño de la población
                    double mRate = in.nextDouble(); // % de genes en un cromosoma que mutarán
                    double cRate = in.nextDouble(); // % de soluciones que se recombinarán
                    int elite = in.nextInt(); // # de soluciones élite en una población
                    Test aTest = new Test(instanceName, maxTime, maxIter, geomSelect, 
                            beta, seed, size, mRate, cRate, elite);
                    list.add(aTest);}}
            in.close();}
        catch (IOException exception){
            System.out.println("Error processing tests file: " + exception);}
        return list;}}