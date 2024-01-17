import { LightningElement } from 'lwc';

export default class FileReaderAPI extends LightningElement {

    handleFile(event) {
        const fileInput = event.target;
        const file = fileInput.files[0];

        if (file) {
            this.readInChunks(file);
        }
    }

    readInChunks(file) {
        const CHUNK_SIZE = 512 * 1024; // 512KB
        let offset = 0;
        const reader = new FileReader();

        reader.onload = (e) => {
            if (e.target.result.length > 0) {
                console.log(e.target.result);  // process the chunk of data here

                offset += CHUNK_SIZE;
                readNext();
            } else {
                // Done reading file
                console.log("Finished reading file.");
            }
        };

        const readNext = () => {
            const slice = file.slice(offset, offset + CHUNK_SIZE);
            reader.readAsText(slice);
        };

        readNext();
    }
}