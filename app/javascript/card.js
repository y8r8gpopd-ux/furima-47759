
const pay = () => {

  const chargeForm = document.getElementById("charge-form");
  if (!chargeForm) return;

  // const payjp = Payjp(ENV[PAYJP_PUBLIC_KEY])
  let payjp = Payjp("pk_test_0e9fecadcef5a9c09b88dda2");
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
        console.log(response.error.message)
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
