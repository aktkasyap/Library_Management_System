package com.library.utilities;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CurrDate {
	public static String getCurrDate() {
		return new SimpleDateFormat("dd/MMM/yyyy").format(new Date());
		
	}
	public static void main(String[] args) {
		
		String date=CurrDate.getCurrDate();
		System.out.println(date);
	}
}
