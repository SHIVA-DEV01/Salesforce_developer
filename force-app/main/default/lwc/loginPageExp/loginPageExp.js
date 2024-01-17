import { LightningElement } from 'lwc';

export default class LoginPageExp extends LightningElement {

usernameInput = this.template.querySelector(".username");
passwordInput = this.template.querySelector(".password");
showPasswordButton = this.template.querySelector(".password-button");
face = this.template.querySelector(".face");



connectedCallback() {
    // this.passwordInput.addEventListener("focus", (event) => {
    //     this.template.querySelectorAll(".hand").forEach((hand) => {
    //       hand.classList.add("hide");
    //     });
    //     this.template.querySelector(".tongue").classList.remove("breath");
    //   });
      
    // this.passwordInput.addEventListener("blur", (event) => {
    //     this.template.querySelectorAll(".hand").forEach((hand) => {
    //       hand.classList.remove("hide");
    //       hand.classList.remove("peek");
    //     });
    //     this.template.querySelector(".tongue").classList.add("breath");
    //   });
      
    // this.usernameInput.addEventListener("focus", (event) => {
    //     let length = Math.min(usernameInput.value.length - 16, 19);
    //     this.template.querySelectorAll(".hand").forEach((hand) => {
    //       hand.classList.remove("hide");
    //       hand.classList.remove("peek");
    //     });
      
    //     face.style.setProperty("--rotate-head", `${-length}deg`);
    //   });
      
    // this.usernameInput.addEventListener("blur", (event) => {
    //     face.style.setProperty("--rotate-head", "0deg");
    //   });
      
    // this.usernameInput.addEventListener(
    //     "input",
    //     _.throttle((event) => {
    //       let length = Math.min(event.target.value.length - 16, 19);
      
    //       face.style.setProperty("--rotate-head", `${-length}deg`);
    //     }, 100)
    //   );
      
    // this.showPasswordButton.addEventListener("click", (event) => {
    //     if (this.passwordInput.type === "text") {
    //       this.passwordInput.type = "password";
    //       this.template.querySelectorAll(".hand").forEach((hand) => {
    //         hand.classList.remove("peek");
    //         hand.classList.add("hide");
    //       });
    //     } else {
    //       this.passwordInput.type = "text";
    //       this.template.querySelectorAll(".hand").forEach((hand) => {
    //         hand.classList.remove("hide");
    //         hand.classList.add("peek");
    //       });
    //     }
    //   });
}

}