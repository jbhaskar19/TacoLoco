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
.order {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
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

table {
  border-collapse: collapse;
  width: 100%;
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

	
function addItems(){

    var itemselectindx = document.getElementById("orderlist");
    var itemselect = itemselectindx.options[itemselectindx.selectedIndex].value;
    var itemquantity = document.getElementById("quantity").value;
    
    if(itemquantity ===""){
    	alert("Enter value");
    	return false;
    }
    
	  var items = document.createElement("TR");
	  document.getElementById("order").appendChild(items);

	  var item = document.createElement("TD");
	  item.setAttribute("id", "item");
	  var itemselectnode = document.createTextNode(itemselect);
	  item.appendChild(itemselectnode);
	  
	  items.appendChild(item);

	  var quantity = document.createElement("TD");
	  quantity.setAttribute("id", "quantity");
	  var itmquantity = document.createTextNode(itemquantity);
	  quantity.appendChild(itmquantity);
	  
	  items.appendChild(quantity);
	  
 		orderJSONObj['order'].push({"item":itemselect,"quantity":itemquantity});
 		order_request = JSON.stringify(orderJSONObj);
 		document.getElementById("submitOrder").style.visibility = "visible";
 		document.getElementById("order").style.visibility = "visible";
 
		 
}


function submitorder(){
	$.ajax({
	    url: "http://localhost:8080/TacoLoco/total",
	    data: order_request,
	    type: "POST",
	    dataType:"json",
	    contentType:'application/json' ,
	    success : function(data) {
			alert(">>"+JSON.parse(data));
	    },
		error : function(e) {
			console.log("ERROR: ", e);
			alert("Error"+e);
		},
		done : function(e) {
			alert.log("DONE");
		}              
	});
		document.getElementById("ot").style.visibility = "visible";	 
 		document.getElementById("od").style.visibility = "visible";	
 		document.getElementById("ordertotal").style.visibility = "visible";
 		document.getElementById("orderdiscount").style.visibility = "visible";	
}

</script>
</head>
<body>
          
    
    <h2 style="text-align:center">TACO LOCO ORDER</h2>

<div class="order">
  <select id="orderlist">
    <option value="VeggieTaco">Veggie Taco</option>
    <option value="ChickenTaco">Chicken Taco</option>
     <option value="BeefTaco">Beef Taco</option>
  <option value="ChorizoTaco">Chorizo Taco</option>
  </select>
    <input  id="quantity" type="number" min="1"/>
  <p><button id="submitItem" onclick="return addItems()">Add Item</button></p>
</div>

<table style="visibility:hidden" id="order" border="1">
	  <tr>
    <th>Item </th>
    <th>Quantity</th>
  </tr>
	</table>
  <button id="submitOrder" onclick="submitorder()" style="visibility:hidden">Place Order</button>
<br>
   <label style="visibility:hidden; text-align:center" id="ot">Total:</label> <input disabled id="ordertotal" style="visibility:hidden" />${total} <br>
   <label style="visibility:hidden; text-align:center" id="od">Discount:</label> <input disabled id="orderdiscount" style="visibility:hidden" />${discount}

</body>
</html>