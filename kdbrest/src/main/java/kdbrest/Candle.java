package kdbrest;

import java.sql.Timestamp;

public class Candle {

	private Timestamp timestamp;
	private String symbol;
	private double open;
	private double high;
	private double low;
	private double close;
	private int aVol;
	private long nQuotes;

	public Candle(){}
	/*
	Candle class to control json for candle data
	*/
	public Candle(Timestamp timestamp, String symbol, double open, double high, double low, double close, double aVol, long nQuotes) {
		this.timestamp = timestamp;
		this.symbol = symbol;
		this.open = open;
		this.high = high;
		this.low = low;
		this.close = close;
		this.aVol = (int) Math.round(aVol);
		this.nQuotes = nQuotes;
	}

	public Timestamp getTime() {
		return this.timestamp;
	}

	public String getSymbol() {
		return this.symbol;
	}

	public double getOpen() {
		return this.open;
	}

	public double getHigh() {
		return this.high;
	}

	public double getLow() {
		return this.low;
	}

	public double getClose() {
		return this.close;
	}

	public double getaVol() {
		return this.aVol;
	}

	public long getnQuotes() {
		return this.nQuotes;
	}

	public void setTime(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public void setOpen(double open) {
		this.open = open;
	}

	public void setHigh(double high) {
		this.high = high;
	}

	public void setLow(double low) {
		this.low = low;
	}

	public void setClose(double close) {
		this.close = close;
	}

	public void setaVol(double aVol) {
		this.aVol = (int) Math.round(aVol);
	}

	public void setnQuotes(long nQuotes) {
		this.nQuotes = nQuotes;
	}

	public String toString() {
    return "Candle{" + "timestamp:" + this.timestamp.toString() + ", symbol:" + this.symbol
						+ ", open:" + String.valueOf(this.open) + ", high:" + String.valueOf(this.high)
						+ ", low:" + String.valueOf(this.low) + ", close:" + String.valueOf(this.close)
						+ ", aVol" + String.valueOf(this.aVol) + ", nQuotes" + String.valueOf(this.nQuotes) + '}';
	}
}
