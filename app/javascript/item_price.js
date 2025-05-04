const price = () => {
  const priceInput = document.getElementById("item-price");
  const taxOutput = document.getElementById("add-tax-price");
  const profitOutput = document.getElementById("profit");

  if (!priceInput || !taxOutput || !profitOutput) return;

  const calculate = (price) => {
    const fee = Math.floor(price * 0.1);
    const profit = Math.floor(price - fee);
    taxOutput.textContent = fee;
    profitOutput.textContent = profit;
  };

  // 初期表示時に値があれば計算
  const initialPrice = parseInt(priceInput.value, 10);
  if (!isNaN(initialPrice) && initialPrice >= 300 && initialPrice <= 9999999) {
    calculate(initialPrice);
  }

  // 入力時にも再計算
  priceInput.addEventListener("input", function () {
    const price = parseInt(priceInput.value, 10);
    if (isNaN(price) || price < 300 || price > 9999999) {
      taxOutput.textContent = "";
      profitOutput.textContent = "";
      return;
    }
    calculate(price);
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);