import { LightningElement, track,api } from 'lwc';

export default class WebRTC extends LightningElement {
    @track availableCameras = [];
    @api strTitle;

    connectedCallback() {
        try {
            console.log('strTitle >>>> '+ strTitle);
            const constraints = {
                'video': true,
                'audio': true
            }
            this.updateCameraList();
            this.listenForDeviceChanges();


            navigator.mediaDevices.getUserMedia(constraints)
                .then(stream => {
                    console.log('Got MediaStream:', stream);
                })
                .catch(error => {
                    console.error('Error accessing media devices.', error);
                });
        } catch (error) {
            console.log('Error >>>>>>>>>> ', error);
        }

    }

    async getConnectedDevices(type) {
        const devices = await navigator.mediaDevices.enumerateDevices();
        return devices.filter(device => device.kind === type);
    }

    updateCameraList() {
        const listElement = this.refs.availableCameras;
        listElement.innerHTML = '';

        this.getConnectedDevices('videoinput').then(videoCameras => {
            videoCameras.forEach(camera => {
                const cameraOption = document.createElement('option');
                cameraOption.label = camera.label;
                cameraOption.value = camera.deviceId;
                listElement.add(cameraOption);
            });

            // Update the tracked variable for future reference
            this.availableCameras = videoCameras;
        });
    }

    listenForDeviceChanges() {
        window.addEventListener('devicechange', () => {
            this.updateCameraList();
        });
    }

    handleCameraChange(event) {
        // Handle camera change event if needed
        // You can access the selected camera using event.target.value
    }

}