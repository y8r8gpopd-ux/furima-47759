function commission (){
  const priceForm = document.getElementById("item-price");
  priceForm.addEventListener("input", calculate);

    function calculate(){
    let price = priceForm.value
    price = parseInt(priceForm.value, 10) || 0;
    let salesCommission = Math.floor(price * 0.1);
    document.getElementById("add-tax-price").textContent = `${salesCommission}`;
    document.getElementById("profit").textContent = `${price - salesCommission}`;
    }
  
}

document.addEventListener('turbo:load', commission);
document.addEventListener('turbo:render', commission);