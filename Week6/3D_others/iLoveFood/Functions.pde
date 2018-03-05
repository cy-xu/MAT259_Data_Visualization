color elementDetermine(float dewey){
  color c = #FFFFFF;
  
  if(dewey<0.2){       //gastronomy, epicurism, nutrition
    c = #75B553; //green
  }
  else if(dewey<0.3){  //drinks
    c = #6699CC; //blue
  }
  else if(dewey<0.5){  //food history, preservation
    c = #FF8C42; //orange
  }
  else if(dewey<0.6){  //cooking
    c = #FFF275; //yellow
  }
  else if(dewey<0.9){  //cooking specific foods, dishes, techniques
    c = #B77BE5; //purple
  }
  else{
    c = #FF0000; //red
  }
  return c;
}

String category(color c){
  String cat = "";
  if (c==#75B553){
    cat = "Gastronomy, Epicurism, Nutrition";
  }
  else if (c==#6699CC){
    cat = "Drinks";
  }
  else if (c==#FF8C42){
    cat = "Food History, Preservation";
  }
  else if (c==#FFF275){
    cat = "Cooking";
  }
  else if (c==#B77BE5){
    cat = "Cooking Specific Dishes, Techniques";
  }
  else{
    cat = "Miscellaneous";
  }
  return cat;
}