/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers.UserController;

/**
 *
 * @author ptrung
 */
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class SendEmail {

    private final String from = "trungpthe170431@fpt.edu.vn"; // Địa chỉ email người gửi
    private final String password = "rqonsojgwxfrbtba"; // Mật khẩu ứng dụng email người gửi

    public static void main(String[] args) {
        SendEmail emailSender = new SendEmail();
        String to = "trungpt1503@gmail.com"; // Địa chỉ email người nhận
        String subject = "Test Email";
        String body = "This is a test email sent from Java.";

        // Gửi email
        boolean result = emailSender.sendEmail(to, subject, body);
        if (result) {
            System.out.println("Email đã được gửi thành công.");
        } else {
            System.out.println("Gửi email không thành công.");
        }
    }

    public boolean sendEmail(String to, String subject, String body) {
        // Thiết lập thuộc tính cho phiên làm việc
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com"); // Máy chủ SMTP Gmail
        properties.put("mail.smtp.port", "587"); // Cổng SMTP cho STARTTLS
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true"); // Bật TLS

        // Tạo phiên làm việc
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            // Tạo đối tượng email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            // Thiết lập nội dung email
            message.setContent(body, "text/html; charset=UTF-8"); // Đặt nội dung là HTML

            // Gửi email
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            System.err.println("Gửi email thất bại: " + e.getMessage());
            e.printStackTrace(); // In stack trace ra console để giúp việc debug dễ dàng hơn
            return false;
        }
    }
}