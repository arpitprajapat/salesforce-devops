import { LightningElement } from 'lwc';
import sendOtp from '@salesforce/apex/EmailSendGridOTPService.sendOtp';
import verifyOtp from '@salesforce/apex/EmailSendGridOTPService.verifyOtp';

export default class EmailOtpForm extends LightningElement {
    email = '';
    otp = '';
    message = '';
    otpSent = false;

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handleOtpChange(event) {
        this.otp = event.target.value;
    }

    async sendOtp() {
        try {
            const result = await sendOtp({ email: this.email });
            this.message = result;
            this.otpSent = true;
        } catch (error) {
            this.message = error.body.message;
        }
    }

    async verifyOtp() {
        try {
            const isValid = await verifyOtp({ email: this.email, inputOtp: this.otp });
            this.message = isValid ? '✅ OTP Verified!' : '❌ Invalid OTP!';
        } catch (error) {
            this.message = error.body.message;
        }
    }
}