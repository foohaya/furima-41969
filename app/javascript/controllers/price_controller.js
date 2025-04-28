import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["price", "tax", "profit"]

  calculate() {
    const price = parseInt(this.priceTarget.value, 10)

    if (isNaN(price) || price < 300 || price > 9999999) {
      this.taxTarget.textContent = ""
      this.profitTarget.textContent = ""
      return
    }

    const fee = price * 0.1 // 手数料は10%
    const profit = price - fee // 利益は価格から手数料を引いた額

    this.taxTarget.textContent = Math.floor(fee)
    this.profitTarget.textContent = Math.floor(profit)
  }
}