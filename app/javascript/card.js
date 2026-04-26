
const pay = () => {

  const chargeForm = document.getElementById("charge-form");
  if (!chargeForm) return;

  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");
  numberElement.innerHTML = ""
  expiryElement.innerHTML = ""
  cvcElement.innerHTML = ""

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  chargeForm.addEventListener("submit", (e) =>{
    payjp.createToken(numberElement).then(function(response){
      if(response.error){
        
      }else{
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name="token" type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
  

}
document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);
