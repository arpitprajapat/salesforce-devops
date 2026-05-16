// emailVerification.js
import { LightningElement, track } from 'lwc';
import sendOTPEmail from '@salesforce/apex/EmailOTPController.sendOTPEmail';
import verifyOTP from '@salesforce/apex/EmailOTPController.verifyOTP';

export default class EmailVerification extends LightningElement {
    @track email = '';
    @track otp = '';
    @track otpSent = false;
    @track successMessage = '';
    @track errorMessage = '';

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handleOTPChange(event) {
        this.otp = event.target.value;
    }

    sendOTP() {
        sendOTPEmail({ email: this.email })
            .then(result => {
                this.otpSent = true;
                this.successMessage = result;
                this.errorMessage = '';
            })
            .catch(error => {
                this.errorMessage = 'Failed to send OTP';
                console.log(error);
            });
    }

    verifyOTP() {
        //console.log('enter otp: ' +this.otp);
        verifyOTP({ email: this.email, enteredOtp: this.otp })
            .then(result => {
                if (result) {
                    this.successMessage = 'Email verified successfully!';
                    this.errorMessage = '';
                } else {
                    this.successMessage = '';
                    this.errorMessage = 'Invalid OTP!';
                }
            })
            .catch(error => {
                this.errorMessage = 'Verification failed!';
            });
    }
}