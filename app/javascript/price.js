window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);

function price() {
  const priceInput = document.getElementById("item-price");
  const add_tax_price = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  let item_price_value;
  let add_tax_price_value;
  let profit_value;

  priceInput.addEventListener("keyup", ()=>{
    item_price_value = priceInput.value;
    add_tax_price_value = Math.floor(item_price_value * 0.1);
    profit_value = Math.floor(priceInput.value) - add_tax_price_value;

    add_tax_price.innerHTML = add_tax_price_value.toLocaleString();
    profit.innerHTML = profit_value.toLocaleString();
  });
};