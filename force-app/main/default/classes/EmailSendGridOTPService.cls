public with sharing class EmailSendGridOTPService {
    // In-memory OTP store (temporary)
    private static Map<String, String> otpStore = new Map<String, String>();
    static {
        System.debug('Initialized otpStore: ' + otpStore);
    }

    @AuraEnabled
    public static String sendOtp(String email) {
        System.debug('sendOtp method called with email: ' + email);

        // 1. Generate OTP
        Integer otp = (Integer)(Math.mod(Math.abs(Crypto.getRandomLong()), 1000000));
        System.debug('Generated OTP: ' + otp);

        String otpString = String.valueOf(otp).leftPad(6, '0');
        System.debug('OTP as string with padding: ' + otpString);

        otpStore.put(email, otpString);
        System.debug('Stored OTP in otpStore for email ' + email + ': ' + otpString);

        // 2. Prepare SendGrid request
        Map<String, Object> personalization = new Map<String, Object>{
            'to' => new List<Object>{new Map<String, String>{'email' => email}},
            'subject' => 'Your OTP Code'
        };
        System.debug('Personalization map: ' + personalization);

        Map<String, Object> sendGridPayload = new Map<String, Object>{
            'personalizations' => new List<Object>{personalization},
            'from' => new Map<String, String>{'email' => 'your_verified_sender@domain.com'},
            'content' => new List<Object>{new Map<String, String>{
                'type' => 'text/plain',
                'value' => 'Your OTP is: ' + otpString
            }}
        };
        System.debug('SendGrid Payload: ' + sendGridPayload);

        String body = JSON.serialize(sendGridPayload);
        System.debug('Serialized JSON body: ' + body);

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:SendGrid/v3/mail/send');
        System.debug('Set HTTP endpoint');

        req.setMethod('POST');
        System.debug('Set HTTP method to POST');

        // req.setHeader('Authorization', 'Bearer YOUR_SENDGRID_API_KEY');
        req.setHeader('Content-Type', 'application/json');
        System.debug('Set HTTP headers');

        req.setBody(body);
        System.debug('Set HTTP body');

        Http http = new Http();
        System.debug('Created new Http instance');

        HttpResponse res = http.send(req);
        System.debug('HTTP response received. Status code: ' + res.getStatusCode());
        System.debug('HTTP response body: ' + res.getBody());

        if (res.getStatusCode() == 202) {
            String successMessage = 'OTP sent successfully to ' + email;
            System.debug(successMessage);
            return successMessage;
        } else {
            String errorMessage = 'Failed to send email: ' + res.getBody();
            System.debug(errorMessage);
            throw new AuraHandledException(errorMessage);
        }
    }

    @AuraEnabled
    public static Boolean verifyOtp(String email, String inputOtp) {
        System.debug('verifyOtp method called with email: ' + email + ' and inputOtp: ' + inputOtp);
        Boolean isValid = otpStore.containsKey(email) && otpStore.get(email) == inputOtp;
        System.debug('OTP verification result for ' + email + ': ' + isValid);
        return isValid;
    }
}