color elementDetermine(String subject){
  color c = #FFFFFF;
  if(subject.equals("fire") || subject.equals("Fire")){
    c = #F75F00;
  }
  else if(subject.equals("wood") || subject.equals("Wood")){
    c = #00BC56;
  }
  else if(subject.equals("water") || subject.equals("Water")){
    c = #28A4F5;
  }
  else if(subject.equals("gold") || subject.equals("Gold")){
    c = #F7C200;
  }
  return c;
}

float timeParser(String rawTime){
  String[] times = split(rawTime, ':');
  float parsedTime = float(times[0])*60 + float(times[1]);
  return parsedTime;
}

float dateParser(String rawDate){
  String[] dates = split(rawDate, '-');
  float parsedDate = (float(dates[0])-startYear)*365 + (float(dates[1])-1)*30 + float(dates[2]);
  return parsedDate;
}