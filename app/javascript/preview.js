const preview = function(){
  const sellBtn = document.querySelector(".sell-btn");
  if(!sellBtn) return;

  const previewArea = document.getElementById("previews");

  // 編集ページ用・保存されている画像の取得処理
  const imagesData = previewArea.dataset.images;
  const existingImages = imagesData ? JSON.parse(imagesData) : [];
  // 重複してる場合の初期化
  previewArea.innerHTML = "";

  //プレビュー生成関数 
  const buildCard = (dataIndex, src = null, imgId = null) => {
    // cardが５枚に達していたら脱出
    const imageCount = document.querySelectorAll(".preview-card").length;
    if(imageCount >= 5) return;

    // card形式でプレビュー生成
    const card = document.createElement("div");
    card.setAttribute("class", "preview-card");
    card.setAttribute("data-index", dataIndex);

    // プレビューの生成
    const previewImg = document.createElement("img");
    previewImg.setAttribute("class", "preview-img");
    if(src) previewImg.src = src;

    // 削除ボタンも作成
    const deleteBtn = document.createElement("div");
    deleteBtn.setAttribute("class", "img-delete-btn");
    deleteBtn.textContent = "削除";
    deleteBtn.setAttribute("style", "display: none;"); // ← いったん非表示
    deleteBtn.addEventListener("click", () => deleteImg(dataIndex, imgId));

    const uploadText = document.createElement("div");
    uploadText.setAttribute("class", "upload-text");

    if(src){
      previewImg.src = src;
      deleteBtn.setAttribute("style", "display: block;") // ← 既存画像は最初から表示
      uploadText.textContent = "クリックして再選択可"; // ← 画像がある場合の説明文
    }
    else {
      uploadText.textContent = "クリックして画像をアップロード"; // ← 画像がない場合の説明文
    }


    // 新規フォームの生成
    const newImgForm = document.createElement("input");
    newImgForm.setAttribute("type", "file");
    newImgForm.setAttribute("name", "item[images][]");
    newImgForm.setAttribute("data-index", dataIndex);
    newImgForm.addEventListener("change", changeFile);

    // カードにまとめる
    card.appendChild(previewImg);
    card.appendChild(deleteBtn);
    card.appendChild(newImgForm);
    card.appendChild(uploadText);
    

    // プレビューに追加する
    previewArea.appendChild(card);
  }

  // フォームをカードごと削除する関数
  const deleteImg = (dataIndex, imgId) => {
    const card = document.querySelector(`.preview-card[data-index="${dataIndex}"]`);
    card.remove();

    if(imgId){
      const hidden = document.createElement("input");
      hidden.type = "hidden";
      hidden.name = "item[remove_image_ids][]";
      hidden.value = imgId;
      const form = document.querySelector(".items-sell-main form");
      form.appendChild(hidden);
    }

    // 全部カードが消えた場合に追加で作成
    const inputs = document.querySelectorAll('input[type="file"]');
    if (inputs.length === 0) {
    buildCard(0);
    }

    // ５枚選択されていた場合に削除されたら新規の５枚目のカードを作成
    const imageCount = document.querySelectorAll(".preview-img[src]").length;
    const nextIndex = getNextIndex();

    if (imageCount === 4) {
      buildCard(nextIndex);
    }
  };


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

    const card = document.querySelector(`.preview-card[data-index="${dataIndex}"]`);
    const previewImg = card.querySelector(".preview-img");

    previewImg.src = blob;

    // 削除ボタンの表示
    const deleteBtn = card.querySelector(".img-delete-btn");
    previewImg.src = blob;
    deleteBtn.setAttribute("style", "display: block;");
    // 説明文の変更
    const uploadText = card.querySelector(".upload-text");
    uploadText.textContent = "クリックして再選択可";

    // 次の投稿カードの準備
    const nextIndex = getNextIndex();
    const nextCard = document.querySelector(`.preview-card[data-index="${nextIndex}"]`);
    const imageCount = document.querySelectorAll(".preview-img[src]").length;

    // 次の投稿カードがなければ生成、五枚までの制限あり
    if (!nextCard && imageCount < 5) {
      buildCard(nextIndex);
    }
  };

  // 次に使うindexの数値の取得
  const getNextIndex = () => {
    const cards = document.querySelectorAll(".preview-card");
    const indices = Array.from(cards).map(card => Number(card.dataset.index));
    return indices.length ? Math.max(...indices) + 1 : 0;
  };

   // 編集ページ、すでに画像がある時
  if (existingImages.length > 0){
    existingImages.forEach((img, index) => {
      buildCard(index, img.url, img.id);
    });
    buildCard(existingImages.length);
  } 
  // 出品ページ、画像がまだないとき
  else {
    buildCard(0);
  }
  
};


document.addEventListener("turbo:load", preview);
document.addEventListener("turbo:render", preview);