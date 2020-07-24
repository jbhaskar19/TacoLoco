package com.DetroitLabs.TacoLoco.model;

import java.util.HashMap;

public class Menu {
	HashMap<String, Double> model ;

	public HashMap<String, Double> getModel() {
		return model;
	}
	public void setModel(HashMap<String, Double> model) {
		this.model = model;
	}
	public Menu(){
		model=new HashMap<String, Double>();
		model.put("VeggieTaco", 2.50);
		model.put("ChickenTaco", 3.00);
		model.put("BeefTaco", 3.00);
		model.put("ChorizoTaco", 3.50);
	}
}
