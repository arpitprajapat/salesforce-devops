import { LightningElement, track } from 'lwc';

export default class LoginForm extends LightningElement {
  @track email = '';
  @track password = '';
  @track rememberMe = false;

  handleChange(event) {
    this[event.target.name] = event.target.value;
  }

  handleCheckbox(event) {
    this.rememberMe = event.target.checked;
  }

  handleLogin() {
    const emailField = this.template.querySelector('[name="email"]');
    const passwordField = this.template.querySelector('[name="password"]');
    
    if (emailField.reportValidity() && passwordField.reportValidity()) {
      console.log('Login:', {
        email: this.email,
        password: this.password,
        rememberMe: this.rememberMe
      });
    }
  }
}