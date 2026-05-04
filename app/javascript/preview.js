const preview = function(){

  const sellBtn = document.querySelector(".sell-btn");
  if(!sellBtn) return;

  const previewArea = document.getElementById("previews");

    //プレビュー生成関数 
  const buildPreview = (dataIndex, blob) => {
    const previewImg = document.createElement("img");
    previewImg.setAttribute("class", "preview-img");
    previewImg.setAttribute("data-index", dataIndex);
    previewImg.src = blob;

    // 削除ボタンも作成
    const deleteBtn = document.createElement("div");
    deleteBtn.setAttribute("class", "img-delete-btn");
    deleteBtn.setAttribute("data-index", dataIndex);
    deleteBtn.textContent = "削除";
    deleteBtn.addEventListener("click", () => deleteImg(dataIndex));

    previewArea.appendChild(previewImg);
    previewArea.appendChild(deleteBtn);
  }

    // 二枚目以降の投稿ボタン生成関数
  const buildNewForm = () => {
    const imgFormArea = document.querySelector(".click-upload");
    const newImgForm = document.createElement("input");
    newImgForm.setAttribute("type", "file");
    newImgForm.setAttribute("name", "item[images][]");

    // 二枚目以降のナンバリング
    const lastImgIndex = document.querySelector('input[type="file"][name="item[images][]"]:last-child');
    const nextImgIndex = Number(lastImgIndex.getAttribute("data-index")) + 1;
    newImgForm.setAttribute("data-index", nextImgIndex);

    newImgForm.addEventListener("change", changeFile);
    imgFormArea.appendChild(newImgForm);
  }

  // ファイルが空の時フォームを削除する関数
  const deleteImg = (dataIndex) => {
    const deletePreview = document.querySelector(`.preview-img[data-index="${dataIndex}"]`);
    deletePreview.remove();

    const deleteImgForm = document.querySelector(`input[type="file"][data-index="${dataIndex}"]`);
    deleteImgForm.remove();

    const deleteDeleteBtn = document.querySelector(`.img-delete-btn[data-index="${dataIndex}"]`);
    deleteDeleteBtn.remove();
  }


    // 投稿ボタンが触れられた時の関数
  const changeFile = (e) => {
    const dataIndex = e.target.getAttribute('data-index');
    const imgFile = e.target.files[0];

    // 画像が何も選択されなかったらdeleteImgを呼び出す
    if (!imgFile){
      deleteImg(dataIndex);
      return ;
    }

    const blob = URL.createObjectURL(imgFile);

    const alreadyPreview = document.querySelector(`.preview-img[data-index="${dataIndex}"]`);
    if(alreadyPreview){
      alreadyPreview.src = blob;
      return ;
    };

    buildPreview(dataIndex, blob);
    buildNewForm();
  }

  const imgForm = document.getElementById("item-image");
  imgForm.addEventListener("change", changeFile);
};


document.addEventListener("turbo:load", preview)