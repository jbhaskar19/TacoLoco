package com.DetroitLabs.TacoLoco.model;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;

public class Bill {

	String discount;


	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}
	BigDecimal total;

public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

public Bill() {
	total=new BigDecimal(0.0);
	discount="0%";
}
	public Bill calculateTotal(List <Order> items){
		Bill bill = new Bill();
		try {
		int totalquantity=0;
		  BigDecimal billAmount=new  BigDecimal(0.0);
		System.out.println("Calculating");
		//Calculating total for every item in order list
		for(int i=0;i<items.size();i++) { 
			Order item=new Order();
			//CAsting the JSON request to Model tyoe
			ObjectMapper mapper = new ObjectMapper(); 
			item=mapper.convertValue(items.get(i), Order.class);
			//get the price of the item
			if(item==null) {
			continue;	
			}
			Menu menu=new Menu(); 
			int qt=item.getQuantity();

			totalquantity+=qt;
			
			//compare incoming item with menu and fetch the respective price
		  if(menu.getModel().containsKey(item.getItem())) { 
			  BigDecimal price = new BigDecimal(menu.getModel().get(item.getItem()));
			  BigDecimal quantity = new BigDecimal(qt);
			  BigDecimal totalPrice=price.multiply(quantity);
			  
			  billAmount=billAmount.add(totalPrice);
			  System.out.println("\tTotal:"+totalPrice+"\tPrice:"+price+"\tQuantity:"+quantity); 
			  }
		  }
		  
		  System.out.println("\tTotal Bill Amount:$"+billAmount);
		  //discount implementation
		  if(totalquantity>=4) { 
			  bill.setDiscount("20%");
			  billAmount=billAmount.multiply(new BigDecimal(0.8));
			  System.out.println("\tAfter Discount:$"+billAmount);
		  } 
		  //rounding off to 2 decimal places
		  MathContext m = new MathContext(3);
		  bill.setTotal(billAmount.round(m));
		}
		
		catch(Exception e) {
			  System.out.println("Something went wrong"+e.getMessage());
		}
		return bill; 
	}




}
