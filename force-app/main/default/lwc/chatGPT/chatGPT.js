import { LightningElement, track } from 'lwc';
import getChatGPTResponse from '@salesforce/apex/ChatGPTS.getChatGPTResponse';


export default class ChatGPTS extends LightningElement { // Class name changed to match Apex class
    @track prompt = '';
    @track response = '';
    @track outputClass = 'minimized';
    @track toggleLabel = 'Maximize';

    handlePromptChange(event) {
        this.prompt = event.target.value;
    }

    callChatGPT() {
        if (!this.prompt.trim()) return;
        getChatGPTResponse({ prompt: this.prompt })
            .then(result => {
                this.response = result;
            })
            .catch(error => {
                this.response = 'Error: ' + error.body.message;
            });
    }

    toggleView() {
        if (this.outputClass === 'minimized') {
            this.outputClass = 'maximized';
            this.toggleLabel = 'Minimize';
        } else {
            this.outputClass = 'minimized';
            this.toggleLabel = 'Maximize';
        }
    }
}