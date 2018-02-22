void keyPressed()
      {
        if (key == 'p')
            pythonFlag=!pythonFlag;            
        if (key == 'a')    
            algorithmFlag =! algorithmFlag;
        if (key == 'd')                                                      
            dataMiningFlag =! dataMiningFlag;
        if (key == 'm')   
            machineLearningFlag =! machineLearningFlag;
        if (key == 'o')    
            operatingSystemFlag =! operatingSystemFlag;
        if (key == 'i')
            aiFlag =! aiFlag; 
        if (key == 't')
            arcFlag =! arcFlag;
        if (key == 'c')
            circleFlag =! circleFlag;
        if (key == '+')    
            {
              if(sectors<=84)
                  sectors+=12;
            }
        if (key == '-')    
            {
              if(sectors>0)
                  sectors-=12;
            }
        
      }     