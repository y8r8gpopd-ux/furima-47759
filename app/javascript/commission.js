function commission (){
  console.log("test");
  const priceForm = document.getElementById("item-price");
  priceForm.addEventListener("input", calculate);

    function calculate(){
    let price = priceForm.value
    price = parseInt(priceForm.value, 10) || 0;
    document.getElementById("add-tax-price").textContent = `${Math.floor(price * 0.1)}`;
    document.getElementById("profit").textContent = `${Math.floor(price * 0.9)}`;
    }
  
}

document.addEventListener('turbo:load', commission);
document.addEventListener('turbo:render', commission);