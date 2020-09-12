package kdbrest;

import kdbrest.c;
import kdbrest.Candle;
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
public class CandleController {

	private final AtomicLong counter = new AtomicLong();

	@GetMapping("/candles")
	List<Candle> getCandle( @RequestParam(required=true) String symbol, @RequestParam(required=true) String interval,
													@RequestParam(required=true) String pxType, @RequestParam(required=true) String startTime,
													@RequestParam(required=true) String endTime ) throws KException,IOException {
		List<Candle> response = new ArrayList<>();
		c qConnection = null;
		try {
		  qConnection = new c("localhost",2100,"admin:password");
		  Integer cInterval = Integer.parseInt(interval);
		  char[] cStart = startTime.toCharArray();
		  char[] cEnd = endTime.toCharArray();
		  Object[] a = {qConnection.cs("getQuoteCandles"),symbol,cInterval,pxType,cStart,cEnd};
			// Object[]
			try {
				c.Dict result=(c.Dict) qConnection.k(a);
			  c.Flip keys = (c.Flip) result.x;
			  //Retrieve keys name and data
			  final String[] keyNames = keys.x;
			  final java.sql.Timestamp[] keyData = (java.sql.Timestamp[]) keys.y[0];

			  c.Flip values = (c.Flip) result.y;
			  //Retrieve value name and data
			  final String[] valueNames = values.x;
			  final String[] symData = (String[]) values.y[0];
			  final double[] openData = (double[]) values.y[1];
			  final double[] highData = (double[]) values.y[2];
			  final double[] lowData = (double[]) values.y[3];
			  final double[] closeData = (double[]) values.y[4];
			  final double[] aVolData = (double[]) values.y[5];
			  final long[] nQData = (long[]) values.y[6];

			  int rows = keyData.length;
			  for (int i = 0; i < rows; i++){
			    Candle candleObj = new Candle(keyData[i], symData[i], openData[i], highData[i], lowData[i], closeData[i], aVolData[i], nQData[i]);
					response.add(candleObj);
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
