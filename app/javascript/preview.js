const preview = function(){
  const sellBtn = document.querySelector(".sell-btn");
  if(!sellBtn) return;

  const previewArea = document.getElementById("previews");

  //プレビュー生成関数 
  const buildCard = (dataIndex, blob = null) => {
    // card形式でプレビュー生成
    const card = document.createElement("div");
    card.setAttribute("class", "preview-card");
    card.setAttribute("data-index", dataIndex);

    // プレビューの生成
    const previewImg = document.createElement("img");
    previewImg.setAttribute("class", "preview-img");
    if(blob) previewImg.src = blob;

    // 削除ボタンも作成
    const deleteBtn = document.createElement("div");
    deleteBtn.setAttribute("class", "img-delete-btn");
    deleteBtn.textContent = "削除";
    deleteBtn.addEventListener("click", () => deleteImg(dataIndex));

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

    // プレビューに追加する
    previewArea.appendChild(card);
  }

  // フォームをカードごと削除する関数
  const deleteImg = (dataIndex) => {
    const card = document.querySelector(`.preview-card[data-index="${dataIndex}"]`);
    card.remove();

    // 全部カードが消えた場合に追加で作成
    const inputs = document.querySelectorAll('input[type="file"]');
    if (inputs.length === 0) {
    buildCard(0);
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

    // 次の投稿カードの準備
    const nextIndex = Number(dataIndex) + 1;
    const nextCard = document.querySelector(`.preview-card[data-index="${nextIndex}"]`);

    // 次の投稿カードがなければ生成
    if (!nextCard) {
    buildCard(nextIndex);
    }
  };
  
  const card = document.querySelector(".preview-card")
  if(!card){
    buildCard(0);
  }
};


document.addEventListener("turbo:load", preview);
document.addEventListener("turbo:render", preview);