<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TACO LOCO</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.orderlist{
  max-width: 100px;  
}
.order {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 500px;
  margin: auto;
  text-align: center;
  font-family: arial;
}

.title {
  color: grey;
  font-size: 18px;
}

button {
  border: none;
  outline: 0;
  display: inline-block;
  padding: 8px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
  font-size: 18px;
}

button:hover, a:hover {
  opacity: 0.7;
}

table, td, th {  
  border: 1px solid #ddd;
  text-align: left;
}

table.center {
  margin-left:auto; 
  margin-right:auto;
}

th, td {
  padding: 15px;
}



</style>
<script src="http:////code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	var orderObj = '{"order":[]}';
	var orderJSONObj = JSON.parse(orderObj);
	var order_request;
	var count=0;
function addItems(){

	// Get Drop Down value
    var itemselectindx = document.getElementById("orderlist");
    var itemselect = itemselectindx.options[itemselectindx.selectedIndex].value;
    
    //Get Quantity value
    var itemquantity = document.getElementById("quantity").value;
    
    //Check drop down selected
    if(itemquantity ===""){
    	alert("Enter value");
    	return false;
    }
    
	  var items = document.createElement("TR");
	  document.getElementById("order").appendChild(items);
	  items.setAttribute("id",count);

	  //Item Name
	  var item = document.createElement("TD");
	  item.setAttribute("id", "item");
	  var itemselectnode = document.createTextNode(itemselect);
	  item.appendChild(itemselectnode);
	  items.appendChild(item);

	  //Quantity
	  var quantity = document.createElement("TD");
	  quantity.setAttribute("id", "quantity");
	  var itmquantity = document.createTextNode(itemquantity);
	  quantity.appendChild(itmquantity);
	  items.appendChild(quantity);

	  //Delete Item Button
	  var removeItemData = document.createElement("TD");	  
	  var removeButtton = document.createElement('BUTTON');
	  removeButtton.setAttribute("name", "rmvbtn");
	  removeButtton.setAttribute("id",count);
	  removeButtton.setAttribute("onclick","reply_click(this)");
	  

	  //removeButtton.id = "rmvbtn";
	// add button's 'onclick' event.
	  removeButtton.innerHTML = "remove";
	  removeItemData.appendChild(removeButtton);
	  items.appendChild(removeItemData);
	  
	  //Controller JSON Request
 		orderJSONObj['order'].push({"item":itemselect,"quantity":itemquantity});
 		//order_request = JSON.stringify(orderJSONObj);
 		count++;
 		document.getElementById("submitOrder").style.visibility = "visible";
 		document.getElementById("order").style.visibility = "visible";
 		 
}


function reply_click(clicked_id)
{

    var row = document.getElementById(clicked_id.id);
    row.parentNode.removeChild(row);
   	count--;
   	delete orderJSONObj['order'][clicked_id.id];

	   
   	//var found = orderJSONObj['order'].filter(function(item) { return item.item === row.firstChild.innerHTML; });
	
   	//var found = orderJSONObj['order'].remove(row.firstChild.innerHTML);   	
}

	//Deleting the item

// 	document.getElementByName("rmvbtn").addEventListener("click", function() {
// 		alert("Remove elemtn"+this.id);
			
// //	   var targetParent = event.target.parentNode; 
// //	   var targetRow = targetParent.parentNode; 
// //		alert("Removing item"+targetRow);
// //	   targetRow.parentNode.removeChild(targetRow);
// 		});

//Ajax call to Controller
function submitorder(){
	//alert("Submittng Request:"+JSON.stringify(orderJSONObj));
	if(count>0){
		$.ajax({
		    url: "http://localhost:8080/TacoLoco/total",
		    data: JSON.stringify(orderJSONObj),
		    type: "POST",
		    dataType:"json",
		    contentType:'application/json' ,
		    success: function (msg) {
		         document.getElementById("ordertotal").value = msg.total;
		         document.getElementById("orderdiscount").value = msg.discount;
	        },
	        error: function (req, status, error) {
	            alert(status+">>>"+error);
	        }             
		});
			document.getElementById("ot").style.visibility = "visible";	 
	 		document.getElementById("od").style.visibility = "visible";	
	 		document.getElementById("ordertotal").style.visibility = "visible";
	 		document.getElementById("orderdiscount").style.visibility = "visible";	
	 		document.getElementById("processPayment").style.visibility = "visible";		
	}else
		{
		alert("Please Enter Order");
		}
	
	
}

function processPayment(){
	alert("Future Implementation");
}

</script>
</head>
<body>   

    <h2 style="text-align:center">TACO LOCO ORDER</h2>

<div class="order">
  <select id="orderlist">
    <option value="VeggieTaco">Veggie Taco		$2.50</option>
    <option value="ChickenTaco">Chicken Taco		$3.00</option>
     <option value="BeefTaco">Beef Taco		$3.00</option>
  <option value="ChorizoTaco">Chorizo Taco		$3.50</option>
  </select>
    <input  id="quantity" type="number" min="1"/>
  <p><button id="submitItem" onclick="return addItems()">Add Item</button></p>
</div>

<table style="visibility:hidden;" id="order" border="1" class="center">
	  <tr>
    <th>Item </th>
    <th>Quantity</th>
    <th>Operation</th>
  </tr>
	</table>
<div class="order" style="visibility:hidden">  
 <button id="submitOrder" onclick="submitorder()" style="visibility:hidden">Place Order</button>
<br>
   <div style="text-align:center;padding-top: 10px;">
   <label style="visibility:hidden; text-align:center" id="ot">Total:</label> <input  disabled id="ordertotal" style="visibility:hidden" /><br>
   <label style="visibility:hidden; text-align:center" id="od">Discount:</label> <input disabled id="orderdiscount" style="visibility:hidden" />
 <button id="processPayment" onclick="processPayment()" style="visibility:hidden">Process Payment</button>
</div>
</div>
</body>
</html>