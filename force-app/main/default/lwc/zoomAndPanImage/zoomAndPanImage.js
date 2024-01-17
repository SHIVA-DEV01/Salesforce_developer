import { LightningElement, track } from 'lwc';

export default class ZoomAndPanImage extends LightningElement {
  @track imageUrl = 'https://source.unsplash.com/1000x500/?Bosnia%20and%20Herzegovina'; // Replace with the actual image URL
  @track imageStyle = 'width: 100%; height: 100%;'; // Initial image size
  @track imageContainerStyle = ''; // Initial container size and position

  // Variables for tracking mouse interaction
  mouseDown = false;
  lastX = 0;
  lastY = 0;

  // Zoom function
  handleZoom(event) {
    event.preventDefault();
    const zoomFactor = 0.1; // Adjust the zoom factor as needed
    let { width, height } = this.imageContainerStyle;

    width = parseFloat(width) || 100;
    height = parseFloat(height) || 100;

    if (event.deltaY < 0) {
      width += zoomFactor * width;
      height += zoomFactor * height;
    } else {
      width -= zoomFactor * width;
      height -= zoomFactor * height;
    }

    this.imageStyle = `width: ${width}%; height: ${height}%;`;
    this.imageContainerStyle = `width: ${width}%; height: ${height}%;`;
  }

  // Mouse down event handler
  handleMouseDown(event) {
    if (event.button === 0) {
      if (this.mouseDown) {
        // Detect double-click for zooming
        const currentTime = new Date().getTime();
        const timeDiff = currentTime - this.lastClickTime;
        if (timeDiff < 300) {
          this.handleZoom(event);
        }
      }
      this.mouseDown = true;
      this.lastClickTime = new Date().getTime();
      this.lastX = event.clientX;
      this.lastY = event.clientY;
    }
  }

  // Mouse up event handler
  handleMouseUp() {
    this.mouseDown = false;
  }

  // Mouse move event handler for panning
  handleMouseMove(event) {
    if (this.mouseDown) {
      const container = this.template.querySelector('.container');
      const imageContainer = this.template.querySelector('.image-container');
      const containerRect = container.getBoundingClientRect();
      const imageContainerRect = imageContainer.getBoundingClientRect();

      const xOffset = this.lastX - event.clientX;
      const yOffset = this.lastY - event.clientY;

      const newXOffset = imageContainerRect.left - containerRect.left - xOffset;
      const newYOffset = imageContainerRect.top - containerRect.top - yOffset;

      this.imageContainerStyle = `width: ${imageContainerRect.width}%; height: ${imageContainerRect.height}%; transform: translate(-${newXOffset}px, -${newYOffset}px);`;

      this.lastX = event.clientX;
      this.lastY = event.clientY;
    }
  }
}