const pay = () => {
  
  // const payjp = Payjp(ENV[PAYJP_PUBLIC_KEY])
  const payjp = Payjp("pk_test_0e9fecadcef5a9c09b88dda2");
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  const chargeForm = document.getElementById("charge-form");
  chargeForm.addEventListener("submit", (e) =>{
    Payjp.createToken(numberElement).then(function(response){
      if(response.error){
        console.log(response.error.message)
      }else{
        const token = response.id;
        console.log(token)
      }

    });

    e.preventDefault();

  });
  

}

document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);