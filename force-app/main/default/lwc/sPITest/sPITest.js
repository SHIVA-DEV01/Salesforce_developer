import { LightningElement } from 'lwc';

export default class SPITest extends LightningElement {
    localVideoElement;
    remoteVideoElement;
    localStream;
    peerConnection;

    connectedCallback() {
        this.localVideoElement = this.template.querySelector('#localVideo');
        this.remoteVideoElement = this.template.querySelector('#remoteVideo');
    }

    async startCall() {
        try {
            this.localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
            this.localVideoElement.srcObject = this.localStream;

            this.peerConnection = new RTCPeerConnection();

            // Add local stream tracks to peer connection
            this.localStream.getTracks().forEach(track => this.peerConnection.addTrack(track, this.localStream));

            // Set up event handlers
            this.peerConnection.onicecandidate = (event) => this.handleICECandidate(event);
            this.peerConnection.ontrack = (event) => this.handleTrack(event);

            // Create an offer and set it as the local description
            const offer = await this.peerConnection.createOffer();
            await this.peerConnection.setLocalDescription(offer);

            // Send the offer to the remote peer (signaling)
        } catch (error) {
            console.error('Error starting call:', error);
        }
    }

    async endCall() {
        if (this.peerConnection) {
            this.peerConnection.close();
        }
        if (this.localStream) {
            this.localStream.getTracks().forEach(track => track.stop());
            this.localStream = null;
        }
        this.localVideoElement.srcObject = null;
        this.remoteVideoElement.srcObject = null;
    }

    async handleICECandidate(event) {
        if (event.candidate) {
            // Send the ICE candidate to the remote peer (signaling)
        }
    }

    async handleTrack(event) {
        this.remoteVideoElement.srcObject = event.streams[0];
    }
}