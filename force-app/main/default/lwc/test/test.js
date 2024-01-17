import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import pdflib from '@salesforce/resourceUrl/pdflib';
// import { PDFDocument } from '@salesforce/resourceUrl/pdflib';
export default class Test extends LightningElement {

  createImage(imageFile) {
  const image = document.createElement('img');
    
//   image.onload = () => this.convertImage(image);
//   image.setAttribute('src', imageFile);
  console.log('Image ::::: ', this.convertImage(image));
}

convertImage(image) {
  const canvas = this.drawImageToCanvas(image);
  const ctx = canvas.getContext('2d');
  
  let result = [];
  for (let y = 0; y < canvas.height; y++) {
    result.push([]);
    for (let x = 0; x < canvas.width; x++) {
      let data = ctx.getImageData(x, y, 1, 1).data;
      result[y].push(data[0]);
      result[y].push(data[1]);
      result[y].push(data[2]);
    }
  }
  
  const arrayCode = `
    #define IMAGE_WIDTH ${canvas.width}
    #define IMAGE_HEIGHT ${canvas.height}
    #define BYTES_PER_PIXEL 3
    uint8_t imageData[IMAGE_HEIGHT][IMAGE_WIDTH * BYTES_PER_PIXEL] = ${this.convertArray(result)};
  `;
  document.getElementById('result').innerHTML = arrayCode;
  console.log(arrayCode);
}
drawImageToCanvas(image) {
  const canvas = document.createElement('canvas');
  canvas.width = image.width;
  canvas.height = image.height;
  canvas.getContext('2d').drawImage(image, 0, 0, image.width, image.height);
  return canvas;
}

convertArray(array) {
  return JSON.stringify(array).replace(/\[/g, '{').replace(/\]/g, '}');
}







async createPdf() {
    try{

        const imageFile = 'https://upload.wikimedia.org/wikipedia/commons/b/b6/Image_created_with_a_mobile_phone.png';
        this.createImage(imageFile);
//    const jpgUrl = 'https://pdf-lib.js.org/assets/cat_riding_unicorn.jpg'
//   const pngUrl = 'https://pdf-lib.js.org/assets/minions_banana_alpha.png'

//   const jpgImageBytes = await fetch(jpgUrl).then((res) => res.arrayBuffer())
//   const pngImageBytes = await fetch(pngUrl).then((res) => res.arrayBuffer())

//   const pdfDoc = await PDFDocument.create()

//   const jpgImage = await pdfDoc.embedJpg(jpgImageBytes)
//   const pngImage = await pdfDoc.embedPng(pngImageBytes)

//   const jpgDims = jpgImage.scale(0.5)
//   const pngDims = pngImage.scale(0.5)

//   const page = pdfDoc.addPage()

//   page.drawImage(jpgImage, {
//     x: page.getWidth() / 2 - jpgDims.width / 2,
//     y: page.getHeight() / 2 - jpgDims.height / 2 + 250,
//     width: jpgDims.width,
//     height: jpgDims.height,
//   })
//   page.drawImage(pngImage, {
//     x: page.getWidth() / 2 - pngDims.width / 2 + 75,
//     y: page.getHeight() / 2 - pngDims.height + 250,
//     width: pngDims.width,
//     height: pngDims.height,
//   })

//   const pdfBytes = await pdfDoc.save()
//             this.saveByteArray("My PDF", pdfBytes);


    }
    catch(error){
        console.log('Error:::::: ', error);
    }

}



  saveByteArray(pdfName, byte) {
    var blob = new Blob([byte], { type: "application/pdf" });
    var link = document.createElement("a");
    link.href = window.URL.createObjectURL(blob);
    var fileName = pdfName;
    link.download = fileName;
    link.click();
  }
        renderedCallback() {
            loadScript(this, pdflib)
            .then(() => console.log('Loaded download.js'))
            .catch(error => console.log(error));
        }        
}