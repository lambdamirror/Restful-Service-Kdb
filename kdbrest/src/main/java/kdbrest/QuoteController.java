package kdbrest;

import kdbrest.c;
import kdbrest.Quote;
import kdbrest.c.KException;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicLong;
import java.io.IOException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class QuoteController {

	private final AtomicLong counter = new AtomicLong();

	@GetMapping("/quotes")
	List<Quote> getQuotes( @RequestParam(required=true) String symbol, @RequestParam(required=true) String startTime,
													@RequestParam(required=true) String endTime ) throws KException,IOException {
		List<Quote> response = new ArrayList<>();
		c qConnection = null;
		try {
		  qConnection = new c("localhost",2100,"admin:password");
		  char[] qStart = startTime.toCharArray();
		  char[] qEnd = endTime.toCharArray();
		  Object[] a = {qConnection.cs("getQuotes"),symbol,qStart,qEnd};
			try {
				c.Flip result = (c.Flip) qConnection.k(a);
        //Retrieve value name and data
        final String[] columnNames = result.x;
			  final java.sql.Timestamp[] timeData = (java.sql.Timestamp[]) result.y[0];
			  final String[] symData = (String[]) result.y[1];
			  final double[] bidData = (double[]) result.y[2];
			  final double[] askData = (double[]) result.y[3];
			  final double[] bsizeData = (double[]) result.y[4];
			  final double[] asizeData = (double[]) result.y[5];

			  int rows = timeData.length;
			  for (int i = 0; i < rows; i++){
			    Quote quoteObj = new Quote(timeData[i], symData[i], bidData[i], askData[i], bsizeData[i], asizeData[i]);
					response.add(quoteObj);
		  	}
				result = null;
			}catch(Exception e){
        // e.printStackTrace();
      }
		}catch(Exception e){
			// e.printStackTrace();
		}finally{
			try{if(qConnection!=null)qConnection.close();}catch(java.io.IOException e){}
		}
		System.gc();
		return response;
	}
}
