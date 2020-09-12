package kdbrest;

import java.sql.Timestamp;

public class Quote {

	private Timestamp timestamp;
	private String symbol;
	private double bid;
	private double ask;
	private double bsize;
	private double asize;

	public Quote(){}
	/*
	Quote class to control json for quote data
	*/
	public Quote(Timestamp timestamp, String symbol, double bid, double ask, double bsize, double asize) {
		this.timestamp = timestamp;
		this.symbol = symbol;
		this.bid = bid;
		this.ask = ask;
		this.bsize = bsize;
		this.asize = asize;
	}

	public Timestamp getTime() {
		return this.timestamp;
	}

	public String getSymbol() {
		return this.symbol;
	}

	public double getBid() {
		return this.bid;
	}

	public double getAsk() {
		return this.ask;
	}

	public double getBsize() {
		return this.bsize;
	}

	public double getAsize() {
		return this.asize;
	}

	public void setTime(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public void setBid(double bid) {
		this.bid = bid;
	}

	public void setAsk(double ask) {
		this.ask = ask;
	}

	public void setBsize(double bsize) {
		this.bsize = bsize;
	}

	public void setAsize(double asize) {
		this.asize = asize;
	}

	public String toString() {
    return "Quote{" + "timestamp:" + this.timestamp.toString() + ", symbol:" + this.symbol
						+ ", bid:" + String.valueOf(this.bid) + ", ask:" + String.valueOf(this.ask)
						+ ", bsize:" + String.valueOf(this.bsize) + ", asize:" + String.valueOf(this.asize) + '}';
	}
}
