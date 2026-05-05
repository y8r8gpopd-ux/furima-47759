const zoom = function(){
  const itemImage = document.querySelector(".item-box-img");
  if(!itemImage) return;

  const zoomImage = (e) => {
    const zoomBack = document.querySelector(".zoom-back");
    zoomBack.setAttribute("style", "display: flex;");

    const zoomImg = document.querySelector(".zoom-img");
    zoomImg.setAttribute("src", e.target.src);

    zoomBack.onclick = () => {
      zoomBack.setAttribute("style", "display: none;")
    };
  }

  itemImage.addEventListener("click", zoomImage);

  const otherImages = document.querySelectorAll(".other-image-element");
  otherImages.forEach((image) =>
    image.addEventListener("click", zoomImage)
  );
  
};

document.addEventListener("turbo:load", zoom);