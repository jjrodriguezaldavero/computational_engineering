/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.io.File;
import java.util.ArrayList;

public class Main{
    public static final String INPUTS_FOLDER = "inputs";
    public static final String OUTPUTS_FOLDER = "outputs";
    public static final String TESTS_FOLDER = "tests";
    public static final String INPUTS_FILE_SUFFIX = "_inputs.txt";
    public static final String OUTPUTS_FILE_SUFFIX = "_outputs.txt";
    public static final String TESTS_FILE = "tests2run.txt";

    public static void main(String[] args){ 
        System.out.println("****  WELCOME TO THIS PROGRAM  ****");
        long programStart = ElapsedTime.systemTime();        
        // 1. Obtiene la lista de tests
        String testsFilePath = TESTS_FOLDER + File.separator + TESTS_FILE;
        ArrayList<Test> testsList = TestsManager.getTestsList(testsFilePath);
        // 2. Para cada test en la lista
        int nTests = testsList.size();
        for(int k = 0; k < nTests; k++){
            Test aTest = testsList.get(k);
            System.out.println("\n# STARTING TEST " + (k + 1) + " OF " + nTests
                + ": " + aTest.getInstanceName().toString());
            // 2.1 Obtiene los inputs
            // "instanceName_inputs.txt" contains inputs data
            String inputsPath = INPUTS_FOLDER + File.separator +
                    aTest.getInstanceName() + INPUTS_FILE_SUFFIX;
            Inputs inputs = InputsManager.readInputs(inputsPath);
            // 2.2. Usa el algoritmo para resolver la instancia            
            GA alg = new GA(aTest, inputs);
            Solution obs = alg.solve();
            // 2.3. Guarda los resultados en el archivo "instanceName_seed_outputs.txt"
            String outputsFilePath = OUTPUTS_FOLDER + File.separator +
                   aTest.getInstanceName() + "_" + aTest.getSeed() + OUTPUTS_FILE_SUFFIX;
            Outputs out = new Outputs();
            out.setOBSol(obs);
            out.printToFile(outputsFilePath);}
        // 3. End
        System.out.println("\n****  END OF PROGRAM, CHECK OUTPUTS FILES  ****");
            long programEnd = ElapsedTime.systemTime();
            System.out.println("Total elapsed time = "
                + ElapsedTime.calcElapsedHMS(programStart, programEnd));}}