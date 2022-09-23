/**********************************************************************************
* Implementación de un algoritmo genético - Vector Matching Problem 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

public class InputsManager{
    public static Inputs readInputs(String inputsFilePath){
        Inputs inputs = null;
        try{
            byte[] chrom = null;
            FileReader reader = new FileReader(inputsFilePath);
            Scanner in = new Scanner(reader);
            String s = null;
            while(in.hasNextLine()){
                s = in.next();
                if(s.charAt(0) == '#') in.nextLine();
                else{
                    chrom = new byte[s.length()];
                    for(int i = 0; i < s.length(); i++)
                        chrom[i] = Byte.parseByte(s.substring(i, i + 1));
                    break;}}
            inputs = new Inputs(chrom);
            in.close();}
        catch(IOException exception){
            System.out.println("Error processing inputs file: " + exception);}
        return inputs;}}