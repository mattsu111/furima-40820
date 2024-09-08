function setEventListeners() {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // priceInputが存在しない場合は終了

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();

    const addProfitDom = document.getElementById("profit");
    addProfitDom.innerHTML = Math.floor(inputValue - Math.floor(inputValue * 0.1)).toLocaleString();
  });
}

document.addEventListener('turbo:load', setEventListeners);
document.addEventListener('turbo:render', setEventListeners);