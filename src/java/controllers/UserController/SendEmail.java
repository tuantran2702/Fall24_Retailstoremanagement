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
import java.util.Random;

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
    
    public boolean sendEmailForgot(String to, String randomCode){
        String subject = "Tap Hoa SWP";

        // Nội dung email định dạng HTML
        String body = "<html>"
                + "<head>"
                + "<meta charset=\"UTF-8\">"
                + "<title>Yêu cầu đặt lại mật khẩu</title>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }"
                + "h2 { color: #333; }"
                + "p { font-size: 16px; color: #555; }"
                + ".container { max-width: 600px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }"
                + ".code { font-weight: bold; color: #4CAF50; font-size: 20px; }"
                + ".footer { margin-top: 20px; font-size: 14px; color: #777; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<h2>Xin chào,</h2>"
                + "<p>Mật khẩu đặt lại của bạn là: <span class='code'>" + randomCode + "</span></p>"
                + "<p>Vui lòng sử dụng mật khẩu này để đăng nhập vào tài khoản của bạn.</p>"
                + "<p class='footer'>Trân trọng,<br>Đội ngũ hỗ trợ</p>"
                + "</div>"
                + "</body>"
                + "</html>";


        
        boolean result = sendEmail(to, subject, body);
        return result;
    }
    
    public boolean sendEmailWelcome(String to, String newPass){
        String subject = "Tap Hoa SWP";

        // Nội dung email định dạng HTML
        String body = "<html>"
                + "<head>"
                + "<meta charset=\"UTF-8\">"
                + "<title>Chào mừng bạn đến với hệ thống</title>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }"
                + "h2 { color: #333; }"
                + "p { font-size: 16px; color: #555; }"
                + ".container { max-width: 600px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }"
                + ".code { font-weight: bold; color: #4CAF50; font-size: 20px; }"
                + ".footer { margin-top: 20px; font-size: 14px; color: #777; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<h2>Xin chào,</h2>"
                + "<p>Mật khẩu mặc định của bạn là: <span class='code'>" + newPass + "</span></p>"
                + "<p>Vui lòng sử dụng mật khẩu này để đăng nhập vào tài khoản của bạn và đổi mật khẩu mới.</p>"
                + "<p class='footer'>Trân trọng,<br>Đội ngũ hỗ trợ</p>"
                + "</div>"
                + "</body>"
                + "</html>";


        
        boolean result = sendEmail(to, subject, body);
        return result;
    }
    
    public String generateRandomCode(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder result = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            result.append(characters.charAt(random.nextInt(characters.length())));
        }
        return result.toString();
    }
}
