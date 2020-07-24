package com.DetroitLabs.TacoLoco.controller;
import org.springframework.http.MediaType;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.DetroitLabs.TacoLoco.model.Bill;
import com.DetroitLabs.TacoLoco.model.Process;

@Controller
public class OrderController {
	
	  @RequestMapping(value="/total",method = RequestMethod.POST,consumes="application/json")
	  public @ResponseBody Bill CalculateOrderTotalArray(@RequestBody Process process) { 
		  //Initiating the bill model to process the incoming instance of order 
		  Bill bill = new Bill();
		  bill=bill.calculateTotal(process.getOrder());
		  System.out.println("Total Order Cost:" + bill.getTotal());
	  return bill;
	  }
}
