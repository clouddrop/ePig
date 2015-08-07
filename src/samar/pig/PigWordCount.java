package samar.pig;

import java.io.IOException;

import org.apache.pig.ExecType;
import org.apache.pig.PigServer;
import org.apache.pig.backend.executionengine.ExecException;

/**

 * A = load 'mytext' using TextLoader(); 
 * B = foreach A generate flatten(tokenize($0)); 
 * C = group B by $1; 
 * D = foreach Cgenerate flatten(group), COUNT(B.$0); 
 * store D into 'myoutput';
 * 
 * @author samar
 * 
 */
public class PigWordCount {
	public static void main(String[] args) throws ExecException {

		PigServer pigServer = new PigServer(ExecType.LOCAL);

		try {
			runMyQuery(pigServer, "myinput.txt");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void runMyQuery(PigServer pigServer, String inputFile) throws IOException {
		pigServer.registerQuery("A = load '" + inputFile + "' ;");
		pigServer.registerQuery("B = foreach A generate flatten(tokenize($0));");
		pigServer.registerQuery("C = group B by $1;");
		pigServer.registerQuery("D = foreach C generate flatten(group), COUNT(B.$0);");

		pigServer.store("D", "myoutput");
	}
}