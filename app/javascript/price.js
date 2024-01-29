function price(){
  const itemPrice = document.getElementById("item-price")
  itemPrice.addEventListener("keyup",()=>{
    
    const commission = Math.floor(itemPrice.value / 10);
    const addTaxPrice  = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = `${commission}`;
    
    const grace = Math.floor(itemPrice.value-commission);
    const Profit  = document.getElementById("profit");
    Profit.innerHTML = `${grace}`;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);