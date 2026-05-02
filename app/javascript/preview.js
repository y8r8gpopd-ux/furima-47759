const preview = function(){

  const sellBtn = document.querySelector(".sell-btn");
  if(!sellBtn) return;

  const preview = document.getElementById("previews");
  const imageForm = document.getElementById("item-image");


  imageForm.addEventListener("change", function(e){
    // プレビュー交換する場合前のを消す記述↓↓
    const alreadyPreview = document.querySelector(".preview-img");
    if(alreadyPreview){
      alreadyPreview.remove();
    }
    // プレビュー交換する場合前のを消す記述↑↑

    const imageFile = e.target.files[0];
    const blob = URL.createObjectURL(imageFile);

    // 後でラッパーいるか？
    const previewImg = document.createElement("img");
    previewImg.setAttribute("class", "preview-img");
    previewImg.src = blob;
    preview.appendChild(previewImg);
  })
};


document.addEventListener("turbo:load", preview)