// 商品出品画面 価格入力に合わせた販売手数料(10%)および販売利益の表示
window.addEventListener('load', () => {
  const inputPrice  = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profitPrice = document.getElementById('profit');
  inputPrice.addEventListener('input', () => {
    const inputValue = parseInt(inputPrice.value);
    const salesFee   = parseInt(inputValue * 0.1);
    if (isNaN(inputValue) == true) {
      addTaxPrice.innerHTML = 0;
      profitPrice.innerHTML = 0;  
    }
    else {
      addTaxPrice.innerHTML = salesFee;
      profitPrice.innerHTML = inputValue - salesFee;
    }
  });
});