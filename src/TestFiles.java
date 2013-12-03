import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


public class TestFiles {

	public static void main(String[] args) throws IOException {
//		validateCloseAll();
		violateCloseAll();
	}

	private static void validateCloseAll() throws IOException {
		File f = new File("test");
		FileWriter out = new FileWriter(f);
		FileReader in = new FileReader(f);
		BufferedReader buff = new BufferedReader(in);

		out.write("toto\n");
		out.close();
		System.out.println(buff.readLine());
		in.close();
		buff.close();
	}
	
	private static void violateCloseAll() throws IOException {
		File f = new File("test");
		FileWriter out = new FileWriter(f);
		FileReader in = new FileReader(f);
		BufferedReader buff = new BufferedReader(in);

		out.write("toto\n");
		out.flush();
		System.out.println(buff.readLine());
	}
	
}
