/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.util.ArrayList;
import java.util.Locale;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class TestsPlanner{
	
    /*******************************************************************************
    * Variables de instancia 
    ******************************************************************************/
	
	private String testsFilePath;
	private ArrayList<Test> list;
	
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
    
    public TestsPlanner(String path){
    	testsFilePath = path;
    	list = new ArrayList<Test>();}
	    
    /*******************************************************************************
     * MÉTODO PÚBLICO getTestsList()
     ******************************************************************************/
	
    public ArrayList<Test> getTestsList(){
    	try{
        	FileReader reader = new FileReader(testsFilePath);
            Scanner in = new Scanner(reader);
            in.useLocale(Locale.US);
            while(in.hasNextLine()){	
            	String s = in.next();
            	if(s.charAt(0) == '#'){
            		in.nextLine();}
            	else{
            		String instance = s; 
                	String distribution = in.next();
                	float beta1 = in.nextFloat();
                    float beta2 = in.nextFloat();
                    int seed = in.nextInt();
                    Test aTest = new Test(instance, distribution, beta1, beta2, seed);
            		list.add(aTest);}}
            in.close();}
        catch (IOException exception){ 
          	System.out.println("Error processing tests file: " + exception);}
    	return list;}}