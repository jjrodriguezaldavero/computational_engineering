/**********************************************************************************
* Implementación de un algoritmo Multi-Start para resolver el PFSP. 
*
* Máster en Ingeniería Computacional y Matemática
* Optimización Combinatoria
**********************************************************************************/

public class ElapsedTime{	
	
	/******************************************************************************* 
     * Constructor
     ******************************************************************************/
	
	public ElapsedTime(){}
	
	/******************************************************************************* 
     * MÉTODO PÚBLICO systemTime()
     * Devuelve el tiempo en nanosegundos
     ******************************************************************************/
	
	public static long systemTime(){
		long time = System.nanoTime();
		return time;}
	
	/******************************************************************************* 
     * MÉTODO PÚBLICO calcElapsed()
     * Devuelve el tiempo en segundos entre dos valores
     ******************************************************************************/
	
	public static double calcElapsed(long start, long end){
		double elapsed = (end - start) / 1.0e+9;	
		return elapsed;}
		
	/******************************************************************************* 
     * MÉTODO PÚBLICO calcElapsedHMS()
     * Devuelve un string describiendo el número de horas, minutos y segundos
     * entre dos momentos
     ******************************************************************************/
	
	public static String calcElapsedHMS(long start, long end){
		String s = "";
		double elapsed = (end - start) / 1.0e+9;
		s = s + calcHMS((int) Math.round(elapsed));
		return s;}

	/******************************************************************************* 
     * MÉTODO PÚBLICO calcHMS()
     * Dado un número de segundos, devuelve un string que describe el número de 
     * horas, minutos y segundos
     ******************************************************************************/

	public static String calcHMS(int timeInSeconds){
		String s = "";		
		int hours, minutes, seconds;
		hours = timeInSeconds / 3600;
		timeInSeconds = timeInSeconds - (hours * 3600);
		minutes = timeInSeconds / 60;
		timeInSeconds = timeInSeconds - (minutes * 60);
		seconds = timeInSeconds;		
		s = s + hours + "h " + minutes + "m " + seconds + "s";		
		return s;}	
}