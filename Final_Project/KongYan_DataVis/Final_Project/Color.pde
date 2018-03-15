color getColor(int i){
  color c = #FFFFFF;
  switch(i)
  {
    case 0: c =#928B8B; break; // foreign
    case 1: c = #A3DE83; break; // documentary
    case 2: c = #ceab65; break; // western
    case 3: c = #FCEC2C; break; // mystery
    case 4: c = #511717; break; // family(change)
    case 5: c = #8ccdff; break; // animation
    case 6: c = #ffffff; break; // crime
    case 7: c = #F78F1E; break; // comedy
    case 8: c = #33B0B2; break; // action
    case 9: c = #9287B2; break; // adventure
    case 10: c = #D3DE83; break; // drama (change)
    case 11: c = #4a737a; break; // science fiction(change)
    case 12: c = #fca6d1; break; // romance
    case 13: c = #1376a5; break; // horror
    case 14: c = #8FECC8; break; // thriller
    case 15: c = #412199; break; // fantasy
    case 16: c = #992086; break; // music (change)
    case 17: c = #707070; break; // war(change)
    case 18: c = #a36111; break; // history
  }
  // println("find color:", name, c);
  return c;
}