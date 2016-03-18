/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

import com.cgc.bean.DataBeanSendMail;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeBodyPart;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7palmx
 */
public class SendMail {

    private String from;
    private String to;
    private String subject;
    private String text;
    private DataBeanSendMail objreturn;

    public SendMail(String from, String to, String subject, String text) {
        this.from = from;
        this.to = to;
        this.subject = subject;
        this.text = text;
    }

    public void send(String email_server, String email_port) throws Exception {
        /*
         * กำหนดค่าในการส่ง Mail
         */
        ThaiUtil objthai = new ThaiUtil();
        Properties props = new Properties();
        // กำหนด charset ของอีเมล
        props.setProperty("mail.mime.charset", "UTF-8");
        // ปกติ java mail จะไม่ encode ชื่อไฟล์ ต้องสั่งให้ encode ก่อน
        props.setProperty("mail.mime.encodefilename", "true");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", email_server);
        props.put("mail.smtp.port", email_port);

        System.out.println("email_server = " + email_server);
        System.out.println("email_port = " + email_port);

        Session mailSession = Session.getDefaultInstance(props);
        //MimeMessage msg = new MimeMessage(mailSession);
        MimeMessage Message = new MimeMessage(mailSession);
        InternetAddress fromAddress = null;
        InternetAddress toAddress = null;
        try {
            fromAddress = new InternetAddress(from);
            toAddress = new InternetAddress(to);
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace(System.out);
        }

        try {

            Message.setHeader("Content-Type", "text/plain; charset=\"utf-8\"");
            Message.setHeader("Content-Transfer-Encoding", "quoted-printable");

            Message.setFrom(fromAddress);
            Message.setRecipient(RecipientType.TO, toAddress);
            Message.setSubject(subject, "UTF-8");
            Message.setContent(text, "text/html; charset=UTF-8");

            //System.out.println("-----");
            System.out.println(text);

            Transport.send(Message);

        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace(System.out);
        }
    }

    public SendMail(Connection con, String Screen_id) throws Exception {
        ResultSet rs = null;
        objreturn = new DataBeanSendMail();
        String SQL_SEND_MAIL = "select email_from,email_to,email_server,email_port from mscreen where screen_id = '" + Screen_id + "' and delete_flag = 'N'";
        System.out.println("SQL_SEND_MAIL = " + SQL_SEND_MAIL);
        try {
            rs = con.createStatement().executeQuery(SQL_SEND_MAIL);
            while (rs.next()) {
                objreturn.setEmail_from((rs.getString("email_from") == null || rs.getString("email_from").equals("")) ? "" : rs.getString("email_from"));
                objreturn.setEmail_to((rs.getString("email_to") == null || rs.getString("email_to").equals("")) ? "" : rs.getString("email_to"));
                objreturn.setEmail_server((rs.getString("email_server") == null || rs.getString("email_server").equals("")) ? "" : rs.getString("email_server"));
                objreturn.setEmail_port((rs.getString("email_port") == null || rs.getString("email_port").equals("")) ? "" : rs.getString("email_port"));

                System.out.println("objreturn = " + objreturn);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }

        }
    }

    public DataBeanSendMail Return_DataBeanSendMail() {
        return objreturn;
    }
}
