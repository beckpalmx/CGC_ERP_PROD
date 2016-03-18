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
import javax.mail.*;
import javax.mail.internet.*;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7palmx
 */
public class SendEMail {

    private String from;
    private String to;
    private String subject;
    private String text;
    private DataBeanSendMail objreturn;

    public SendEMail(String from, String to, String subject, String text) {
        this.from = from;
        this.to = to;
        this.subject = subject;
        this.text = text;
    }

    public void send(String email_server, String email_port) {

        Properties props = new Properties();
        props.put("mail.smtp.host", email_server);
        props.put("mail.smtp.port", email_port);

        Session mailSession = Session.getDefaultInstance(props);
        MimeMessage Message = new MimeMessage(mailSession);
        //Message Message = new MimeMessage(mailSession);

        Multipart multipart = new MimeMultipart();

        BodyPart part1 = new MimeBodyPart();

        String htmlText = "<img src=\"http://202.183.167.6:8089/CGC_ERP/IMAGES/HEADER/MAIN_9.png\">"
                + "<a href=\"http://202.183.167.6:8089/CGC_ERP\">CGC ERP LOGIN</a>";


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
            Message.setFrom(fromAddress);
            Message.setRecipient(RecipientType.TO, toAddress);
            Message.setSubject(subject);
            Message.setContent(htmlText, "text/html");
            //Message.setText(text);

            Transport.send(Message);
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace(System.out);
        }
    }

    public SendEMail(Connection con, String Screen_id) throws Exception {
        ResultSet rs = null;
        objreturn = new DataBeanSendMail();
        try {
            rs = con.createStatement().executeQuery("select email_from,email_to,email_server,email_port from mscreen where screen_id = '" + Screen_id + "' and delete_flag = 'N'");
            while (rs.next()) {
                objreturn.setEmail_from(rs.getString("email_from") == null ? null : rs.getString("email_from"));
                objreturn.setEmail_to(rs.getString("email_to") == null ? null : rs.getString("email_to"));
                objreturn.setEmail_server(rs.getString("email_server") == null ? null : rs.getString("email_server"));
                objreturn.setEmail_port(rs.getString("email_port") == null ? null : rs.getString("email_port"));
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
