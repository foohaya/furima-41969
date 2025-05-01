document.addEventListener('turbo:load', function() {

  const priceInput = document.getElementById("item-price");
  const taxOutput = document.getElementById("add-tax-price");
  const profitOutput = document.getElementById("profit");

  if (!priceInput || !taxOutput || !profitOutput) return;

  priceInput.addEventListener("input", function() {
    const price = parseInt(priceInput.value, 10);


    if (isNaN(price) || price < 300 || price > 9999999) {
      taxOutput.textContent = "";
      profitOutput.textContent = "";
      return;
    }

 
    const fee = price * 0.1;
    const profit = price - fee;


    taxOutput.textContent = Math.floor(fee);
    profitOutput.textContent = Math.floor(profit);
  });
});