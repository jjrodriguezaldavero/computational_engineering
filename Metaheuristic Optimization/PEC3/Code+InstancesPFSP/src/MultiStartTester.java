/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.io.File;
import java.util.ArrayList;
import java.util.Random;

public class MultiStartTester{
	
    /*******************************************************************************
     * MÉTODO PÚBLICO main()
     ******************************************************************************/
	
	public static void main(String[] args){	
		System.out.println("* Starting *");
		long programStart = ElapsedTime.systemTime();
        String testsFilePath = "test" + File.separator + "tests2run.txt";
		TestsPlanner planner = new TestsPlanner(testsFilePath);
		ArrayList<Test> testsList = planner.getTestsList();
		int nTests = testsList.size();
		for(int k = 0; k < nTests; k++){
			Test aTest = testsList.get(k);
			System.out.println("\n# Test " + (k + 1) + " of " + nTests);
			long testStart = ElapsedTime.systemTime();
			String folder;
			if(aTest.getInstanceName().charAt(0) == 't') folder = "taillard";
			else folder = "watson";
			String inputsFilePath = "inputs" + File.separator + folder + File.separator + aTest.getInstanceName() + "_inputs.txt";
			InputsManager inMngr = new InputsManager(inputsFilePath);
			Inputs aInputs = inMngr.getInputs();
			Random rng = new Random(aTest.getSeed());
			aTest.setRandom(rng);
            MultiStart msAlgorithm = new MultiStart(aTest, aInputs);
            msAlgorithm.run();
            Outputs output = msAlgorithm.getOutput();
			String outputsFilePath = "outputs" + File.separator +
			aTest.getInstanceName() + "_" + aTest.getSeed() + "_outputs.txt";
			output.sendToFile(outputsFilePath);
			long testEnd = ElapsedTime.systemTime();
			System.out.println("Elapsed time for this test = " + ElapsedTime.calcElapsedHMS(testStart, testEnd)+"\n");}
		System.out.println("\n*  End, check outputs files *");
		long programEnd = ElapsedTime.systemTime();
		System.out.println("Total elapsed time = " + ElapsedTime.calcElapsedHMS(programStart, programEnd));}
}