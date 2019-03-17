package com.library.utilities;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Utility {
	private static String host = "localhost";
	private static final String MAIL_SERVER = "smtp.gmail.com";
	private static String uname = "guddusharma2508@gmail.com";
	private static String pwd = "sanjeetanand";

	public static boolean sendMail(String otp, String toEmail) {
		boolean flag = false;
		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtps.host", MAIL_SERVER);
			properties.put("mail.smtps.auth", "true");
			Session session = Session.getInstance(properties);
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(host));
			// msg.addRecipients(Message.RecipientType.TO, new InternetAddress(toSend));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			msg.setSubject("your OTP");
			msg.setText(otp);
			Transport tr = session.getTransport("smtps");
			tr.connect(MAIL_SERVER, uname, pwd);
			tr.sendMessage(msg, msg.getAllRecipients());
			tr.close();
			System.out.println("sending success");
			flag = true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return flag;
	}

	public static int getRandom() {
		return new Random().nextInt(99999);
	}

	public static void main(String[] args) {
		int r = getRandom();
		System.out.println("Random:" + r);
		System.out.println(new Utility().sendMail("" + r, "sanjeet.shannonitu25@gmail.com"));
	}
}