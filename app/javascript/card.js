const pay = () => {

  if (typeof gon === "undefined" || !gon.public_key) {
    console.error("gon is not defined or public_key is missing");
    return;
  }
  
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  numberElement.mount("#number-form");

  const expiryElement = elements.create("cardExpiry");
  expiryElement.mount("#expiry-form");

  const cvcElement = elements.create("cardCvc");
  cvcElement.mount("#cvc-form");

  const form = document.getElementById("charge-form");
  if (!form) return;

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const errorDiv = document.getElementById("card-errors");
    errorDiv.textContent = ""; 

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        form.submit();
      } else {
        const token = response.id;
        const tokenInput = document.createElement("input");
        tokenInput.setAttribute("type", "hidden");
        tokenInput.setAttribute("name", "order_address[token]");
        tokenInput.setAttribute("value", token);
        form.appendChild(tokenInput);

        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);