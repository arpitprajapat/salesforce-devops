import { LightningElement, track, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CurrentPageReference } from 'lightning/navigation';
import ExcelUpload from '@salesforce/apex/ExcelUpload.ExcelUpload';

const SIZE = 200;

export default class MinProject extends LightningElement {

    @api recordId;

    @track fileName      = '';
    @track totalRecords  = 0;
    @track progressValue = 0;
    @track progressLabel = '';
    @track isProcessing  = false;
    @track isComplete    = false;

    parsedData      = [];
    currentRecordId = null;

    get isUploadDisabled() {
        return !this.fileName || this.isProcessing || this.isComplete;
    }

    // Get recordId from URL
    @wire(CurrentPageReference)
    getPageReference(pageRef) {
        if (pageRef) {
            console.log('[getPageReference] Page reference received:', JSON.stringify(pageRef));

            if (this.recordId) {
                this.currentRecordId = this.recordId;
                console.log('[getPageReference] recordId from @api:', this.currentRecordId);
            } else if (pageRef.attributes && pageRef.attributes.recordId) {
                this.currentRecordId = pageRef.attributes.recordId;
                console.log('[getPageReference] recordId from URL attributes:', this.currentRecordId);
            } else if (pageRef.state && pageRef.state.recordId) {
                this.currentRecordId = pageRef.state.recordId;
                console.log('[getPageReference] recordId from URL state:', this.currentRecordId);
            }

            console.log('[getPageReference] Final currentRecordId:', this.currentRecordId);
        }
    }

    // Step 1 - User selects CSV file
    handleFileChange(event) {
        console.log('[handleFileChange] File input changed');

        const file = event.target.files[0];
        console.log('---file----',file);

        if (!file) {
            console.warn('[handleFileChange] No file selected');
            return;
        }

        if (!file.name.endsWith('.csv')) {
            console.warn('[handleFileChange] Invalid file type:', file.name);
            this.showToast('Error', 'Please upload a CSV file. Save your Excel file as CSV first.', 'error');
            return;
        }

        console.log('[handleFileChange] File selected - Name:', file.name, '| Size:', (file.size / 1024).toFixed(2), 'KB');

        this.resetState();
        this.fileName = file.name;

        const reader = new FileReader();

        reader.onload = (e) => {
            console.log('[handleFileChange] FileReader loaded successfully');
            this.parseCSV(e.target.result);
        };

        reader.onerror = (e) => {
            console.error('[handleFileChange] FileReader error:', e);
            this.showToast('Error', 'Failed to read file', 'error');
        };

        reader.readAsText(file);
        console.log('[handleFileChange] FileReader started reading as Text');
    }

    // Step 2 - Parse CSV into Array
    parseCSV(csvText) {
        console.log('[parseCSV] Starting CSV parsing');

        try {
            const allLines = csvText
                .split('\n')
                .map(line => line.trim())
                .filter(line => line !== '');

            console.log('[parseCSV] Total lines including header:', allLines.length);

            if (allLines.length < 2) {
                console.warn('[parseCSV] File has no data rows');
                this.showToast('Warning', 'No records found in the file', 'warning');
                return;
            }

            // Parse headers
            const headers = this.splitCSVLine(allLines[0]);
            console.log('[parseCSV] Headers found:', headers);

            const data = [];

            for (let i = 1; i < allLines.length; i++) {
                const values = this.splitCSVLine(allLines[i]);
                const row    = {};

                headers.forEach((header, index) => {
                    row[header] = values[index] !== undefined ? values[index] : '';
                });

                // Only add row if it has at least one non-empty value
                const hasData = Object.values(row).some(val => val !== '');
                if (hasData) {
                    data.push(row);
                }
            }

            this.parsedData   = data;
            this.totalRecords = data.length;

            console.log('[parseCSV] Parsing complete. Total records:', this.totalRecords);
            console.log('[parseCSV] First row sample:', this.parsedData[0]);
            console.log('[parseCSV] Last row sample:', this.parsedData[this.totalRecords - 1]);

            if (this.totalRecords === 0) {
                console.warn('[parseCSV] No valid records found');
                this.showToast('Warning', 'No records found in the file', 'warning');
                return;
            }

            this.showToast('Info', this.totalRecords + ' records found. Click Save to process.', 'info');

        } catch (error) {
            console.error('[parseCSV] Error parsing CSV file:', error);
            this.showToast('Error', 'Failed to parse file: ' + error.message, 'error');
        }
    }

    // Helper - correctly split a CSV line handling quoted commas
    splitCSVLine(line) {
        const result  = [];
        let current   = '';
        let inQuotes  = false;

        for (let i = 0; i < line.length; i++) {
            const char = line[i];

            if (char === '"') {
                inQuotes = !inQuotes;
            } else if (char === ',' && !inQuotes) {
                result.push(current.trim());
                current = '';
            } else {
                current += char;
            }
        }

        result.push(current.trim());
        return result;
    }

    // Step 3 - Save in batches of 200 to Contact object
    async handleSave() {
        console.log('[handleSave] Save button clicked');
        console.log('[handleSave] @api recordId:', this.recordId);
        console.log('[handleSave] currentRecordId:', this.currentRecordId);
        console.log('[handleSave] Total records to process:', this.parsedData.length);
        console.log('[handleSave] Batch size:', SIZE);
        console.log('[handleSave] Total batches:', Math.ceil(this.parsedData.length / SIZE));

        if (!this.parsedData.length) {
            console.warn('[handleSave] No data found in parsedData');
            this.showToast('Error', 'No data to process', 'error');
            return;
        }

        const finalRecordId = this.currentRecordId || this.recordId;
        console.log('[handleSave] Final recordId to use:', finalRecordId);

        if (!finalRecordId) {
            console.warn('[handleSave] No recordId found from any source');
            this.showToast('Error', 'Record Id not found. Please refresh the page and try again.', 'error');
            return;
        }

        this.isProcessing  = true;
        this.isComplete    = false;
        this.progressValue = 0;

        const total     = this.parsedData.length;
        let processed   = 0;
        let batchNumber = 0;

        for (let i = 0; i < total; i += SIZE) {

            batchNumber++;
            const batch    = this.parsedData.slice(i, i + SIZE);
            const batchEnd = Math.min(i + SIZE, total);

            console.log('[handleSave] --- Batch ' + batchNumber + ' Start ---');
            console.log('[handleSave] Processing rows ' + (i + 1) + ' to ' + batchEnd);
            console.log('[handleSave] Batch record count:', batch.length);
            console.log('[handleSave] Batch first record:', batch[0]);

            try {
                console.log('[handleSave] Sending Batch ' + batchNumber + ' to Apex ExcelUpload...');

                await ExcelUpload({
                    contactData : JSON.stringify(batch),
                    recordId    : finalRecordId
                });

                processed         += batch.length;
                this.progressValue = Math.round((processed / total) * 100);
                this.progressLabel = processed + ' / ' + total + ' records saved - ' + this.progressValue + '% complete';

                console.log('[handleSave] Batch ' + batchNumber + ' saved successfully to Contact object');
                console.log('[handleSave] Progress: ' + processed + '/' + total + ' = ' + this.progressValue + '%');
                console.log('[handleSave] --- Batch ' + batchNumber + ' End ---');

            } catch (error) {
                console.error('[handleSave] Batch ' + batchNumber + ' FAILED');
                console.error('[handleSave] Failed at row range:', (i + 1), 'to', batchEnd);
                console.error('[handleSave] Error details:', error);
                console.error('[handleSave] Error message:', error?.body?.message);

                this.showToast(
                    'Error',
                    'Batch ' + batchNumber + ' failed at row ' + (i + 1) + ': ' + (error?.body?.message || 'Unknown error'),
                    'error'
                );
                this.isProcessing = false;
                return;
            }
        }

        console.log('[handleSave] All batches processed successfully');
        console.log('[handleSave] Total contacts saved to Contact object:', total);

        this.isProcessing  = false;
        this.isComplete    = true;
        this.progressLabel = total + ' / ' + total + ' records saved - 100% complete';
        this.showToast('Success', 'All ' + total + ' contacts saved successfully!', 'success');
    }

    handleCancel() {
        console.log('[handleCancel] Cancel button clicked');
        console.log('[handleCancel] State before reset - fileName:', this.fileName, '| totalRecords:', this.totalRecords);

        this.resetState();

        const input = this.template.querySelector('lightning-input');
        if (input) {
            input.value = null;
            console.log('[handleCancel] File input cleared');
        }

        console.log('[handleCancel] State reset complete');
        this.showToast('Info', 'Upload cancelled', 'info');
    }

    resetState() {
        console.log('[resetState] Resetting component state');
        this.fileName      = '';
        this.totalRecords  = 0;
        this.progressValue = 0;
        this.progressLabel = '';
        this.isProcessing  = false;
        this.isComplete    = false;
        this.parsedData    = [];
        console.log('[resetState] State reset complete');
    }

    showToast(title, message, variant) {
        console.log('[showToast] Title:', title, '| Message:', message, '| Variant:', variant);
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}