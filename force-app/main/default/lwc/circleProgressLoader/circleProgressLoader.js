import { LightningElement, track } from 'lwc';

export default class CircleProgressLoader extends LightningElement {
 renderedCallback() {
    const container = this.template.querySelector('.container');

    const courses = [
      { course: 'HTML', percent: 99, color: '#f9ca24' },
      { course: 'CSS', percent: 65, color: '#78e08f' },
      { course: 'JavaScript', percent: 35, color: '#c56cf0' },
      { course: 'Bootstrap', percent: 85, color: '#badc58' },
    ];

    courses.forEach((course) => {
      const progressGroup = document.createElement('div');
      progressGroup.classList.add('progess-group');

      progressGroup.innerHTML = `
        <div class="circular-progress" style="background: conic-gradient(${course.color} ${3.6 * course.percent}deg, #fff 0deg);">
          <span class="course-value" style="color:${course.color}">0%</span>
        </div>
        <label class="text" style="color:${course.color}">${course.course}</label>
      `;

      container.appendChild(progressGroup);

      let progressStartValue = 0;
      let progressStartEnd = course.percent;
      let speed = 50;
      let progessTimer = setInterval(() => {
        progressStartValue++;
        if (progressStartValue == progressStartEnd) {
          clearInterval(progessTimer);
        }
        progressGroup.querySelector('.circular-progress').style.background = `
          conic-gradient(${course.color} ${3.6 * progressStartValue}deg, #fff 0deg)`;

        progressGroup.querySelector('.course-value').innerHTML = progressStartValue + '%';
      }, speed);
    });
  }
}