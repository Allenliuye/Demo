package tw.eeit138.groupone.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.opencsv.CSVReader;
import com.opencsv.CSVWriter;
import com.opencsv.exceptions.CsvException;

public class CSVLibrary {

	public static void main(String[] args) {
		CSVLibrary csvLibrary =  new CSVLibrary();
        csvLibrary.writeToCsv();
        csvLibrary.readCSVFile();
	}
	
	 public void writeToCsv(){
	        String csv = "data.csv";
	        try{
	            CSVWriter writer = new CSVWriter(new FileWriter(csv));
	            String [] record = "2,Virat,Kohli,India,30".split(",");
	            writer.writeNext(record);

	            writer.close();
	        }catch (IOException e) {
	            e.printStackTrace();
	        }

	    }
	    public void readCSVFile(){
	        CSVReader reader = null;
	        try {
	            reader = new CSVReader(new FileReader("data.csv"));
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        }

	        List<String[]> allRows = null;
	        try {
	            allRows = reader.readAll();
	        } catch (IOException e) {
	            e.printStackTrace();
	        } catch (CsvException e) {
	            e.printStackTrace();
	        }

	        for(String[] row : allRows){
	            System.out.println(Arrays.toString(row));
	        }
	    }

}
