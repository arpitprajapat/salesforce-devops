public class SendEmail {
    public static void sendHtmlEmail() {
        System.debug('Start sending HTML email.');

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { 'arpitprajapat2212@gmail.com' });
        mail.setSubject('Welcome to Your Blue Cross Plan');

        String htmlBody = ''
        + '<html><head><style>'
        + 'body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }'
        + '.container { font-family: Arial, sans-serif; font-size: 14px; color: #333; max-width: 900px; margin: 0 auto; background: #fff; padding: 20px; border: 1px solid #ccc; box-shadow: 0 0 8px rgba(0,0,0,0.1); }'
        + '.info-section { display: flex; justify-content: space-between; margin-bottom: 20px; }'
        + '.info-box { width: 45%; text-align: center; }'
        + '.info-box img { width: 40px; margin-bottom: 10px; }'
        + '.info-box h2 { font-size: 16px; margin-bottom: 8px; color: #333; }'
        + '.info-box p { font-size: 13px; color: #555; line-height: 1.4; }'
        + '.blue-line-right { width: 50%; height: 4px; background-color: #00bfa5; margin-left: auto; margin-top: 15px; margin-bottom: 20px; }'
        + '.green-line-left { width: 50%; height: 4px; background-color: #0071bc; margin-right: auto; margin-top: 20px; margin-bottom: 30px; }'
        + '.whats-next { text-align: center; background-color: #f0fbff; box-shadow: 0 0 15px rgba(135, 206, 250, 0.4); margin-bottom: 20px; padding: 20px; border-radius: 8px; }'
        + '.whats-next h3 { color: #e75c27; margin-bottom: 15px; }'
        + '.next-content { display: flex; justify-content: space-between; text-align: left; }'
        + '.steps { width: 40%; }'
        + '.steps label { display: block; margin-bottom: 10px; color: #0071bc; font-weight: 600; font-size: 13px; }'
        + '.steps input[type=radio] { margin-right: 8px; accent-color: #0071bc; }'
        + '.next-text { width: 55%; font-size: 13px; color: #333; line-height: 1.5; }'
        + '.questions { text-align: center; margin-top: 40px; }'
        + '.questions h3 { color: #e75c27; margin-bottom: 10px; }'
        + '.questions p { font-size: 13px; margin-bottom: 15px; }'
        + '.contact { display: flex; justify-content: space-between; font-size: 13px; text-align: left; gap: 20px; }'
        + '.contact div { flex: 1; }'
        + '.contact strong { color: #0071bc; display: block; margin-bottom: 5px; }'
        + '</style></head><body>'
        + '<div class="container">'

        // Top Blue Line
        + '<div style="height: 4px; width: 50%; background-color: #007cba; border-radius: 2px; margin: 20px 0;"></div>'

        // Info Section
        + '<div class="info-section">'
        + '<div class="info-box">'
        + '<img src="https://img.icons8.com/ios-filled/50/id-verified.png" alt="ID Card Icon" />'
        + '<h2>Blue Cross ID card</h2>'
        + '<p>Your member ID card is your ticket to covered care. Plus, it unlocks access to MyBlue, your online member account. Be sure to keep it in a convenient place for easy access.</p>'
        + '</div>'
        + '<div class="info-box">'
        + '<img src="https://img.icons8.com/ios-filled/50/open-envelope.png" alt="Welcome Kit Icon" />'
        + '<h2>Welcome kit</h2>'
        + '<p>Find coverage details, instructions for finding providers and accessing your Evidence of Coverage, important contact information, and helpful resources to support your health.</p>'
        + '</div></div>'

        // Blue line
        + '<div class="blue-line-right"></div>'

        // What’s Next Section
        + '<div class="whats-next">'
        + '<h3>WHAT\'S NEXT</h3>'
        + '<div class="next-content">'
        + '<div class="steps">'
        + '<label><input type="radio" checked /> Application received</label>'
        + '<label><input type="radio" /> Signing up for MyBlue</label>'
        + '<label><input type="radio" /> Using your Flex Card</label>'
        + '<label><input type="radio" /> Putting your plan to work</label>'
        + '</div>'
        + '<div class="next-text">We may reach out to you for additional information to process your application. Keep an eye out for more emails from us that will help you get to know your new plan. Coming soon: How to use MyBlue to easily manage and understand your benefits.</div>'
        + '</div></div>'

        // Green line
        + '<div class="green-line-left"></div>'

        // Questions Section
        + '<div class="questions">'
        + '<h3>QUESTIONS?</h3>'
        + '<p>Our Team Blue Member Service advocates are here to help. Call Team Blue at the phone number(s) below.</p>'
        + '<div class="contact">'
        + '<div><strong>PLAN</strong><p>Medicare Advantage Prescription Drug (MAPD)</p></div>'
        + '<div><strong>PHONE NUMBER</strong><p><a href="tel:18002004255" style="color: #0071bc; text-decoration: none;">1-800-200-4255 TTY: 711</a></p></div>'
        + '<div><strong>HOURS OF OPERATION</strong><p>April 1 through September 30, 8:00 a.m. to 8:00 p.m. ET, Monday through Friday.<br>October 1 through March 31, 8:00 a.m. to 8:00 p.m. ET, seven days a week.</p></div>'
        + '</div></div>'

        + '</div></body></html>';

        mail.setHtmlBody(htmlBody);

        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            System.debug('Email sent successfully.');
        } catch (Exception e) {
            System.debug('Error sending email: ' + e.getMessage());
        }
    }
}