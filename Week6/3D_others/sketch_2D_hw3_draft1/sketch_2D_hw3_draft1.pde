/********************************************************
 * Data Visualization - 3D                              *
 * Author: April Cai    
 * Code reference: Mohit Hingorani
 ********************************************************/

import peasy.*;

PeasyCam cam;
int years = 12;
float radius = 400;
int sectors = years*12;
int stepHeight=12;
int startYear=2005;
String [] Month = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
int noPL=6;
float dd,mm,yy;
float x,y,z;

//Hue,Saturation,Brightness
float Hue=209;
float Saturation=61;
float Brightness =100;

Table[] table= new Table[noPL];
int []tableLength= new int[noPL];
//Table table[noPL];
String cinString,coutString;
int rows = 8000,columns = 5;
int[][][] cinNumbersTable=new int[noPL][rows][columns];
int[][][] coutNumbersTable=new int[noPL][rows][columns];

float[][][] cinPositionsTable=new float[noPL][rows][3];
float[][][] coutPositionsTable=new float[noPL][rows][3];

boolean randomFlag= true;
boolean algorithmFlag= true;  
boolean dataMiningFlag= true;
boolean machineLearningFlag= true;
boolean operatingSystemFlag= true;
boolean aiFlag= true;
boolean pythonFlag= true;
boolean sectorFlag= true;
boolean arcFlag = false;
boolean circleFlag = true;
float[] position= new float[3];

void setup() {
        size(1300,1200, P3D);
        cam = new PeasyCam(this,0,0,stepHeight*years/2*12,3500);
        colorMode(HSB,360,100,100,255);
        cam.setMinimumDistance(50);
        cam.setMaximumDistance(3000);               
        background(0,0,0);     
        /*
        table= new Table();
        table= loadTable("cs.csv","header");
        tableLength=table.getRowCount();
        */
        ////loading tables
        
        table[0]= loadTable("python.csv","header");
        tableLength[0]=table[0].getRowCount();
            
        table[1]= loadTable("AI.csv","header");
        tableLength[1]=table[1].getRowCount();
              
        table[2]= loadTable("algorithms.csv","header");
        tableLength[2]=table[2].getRowCount();       
        
        table[3]= loadTable("data_mining.csv","header");
        tableLength[3]=table[3].getRowCount();
              
        table[4]= loadTable("machine_learning.csv","header");
        tableLength[4]=table[4].getRowCount();
        
        table[5]= loadTable("operatingsystem.csv","header");
        tableLength[5]=table[5].getRowCount();
              
        for (int pl = 0; pl< noPL;pl++)
            {
          
            for (int i = 0; i< tableLength[pl];i++)
                {
                 cinString= table[pl].getString(i,0);
                 coutString= table[pl].getString(i,1);
    
                int cinNumbers[] = int(splitTokens(cinString, "- "));             
                int coutNumbers[] =int(splitTokens(coutString, "- "));
                
                for (int matrix = 0; matrix < 3; matrix++)
                    {
                      cinNumbersTable[pl][i][matrix] =cinNumbers[matrix];
                      coutNumbersTable[pl][i][matrix] =coutNumbers[matrix];                  
                    }
                              
                              
                }
        }    
//conversion to cylendrical cordinates

    for (int pl = 0; pl < noPL;pl++)
        {
        for (int i = 0; i < tableLength[pl]; i++)
             {
              //cin table 
                cinPositionsTable[pl][i][0]= radius/2  * cos((radians(30*cinNumbersTable[pl][i][1])+radians(cinNumbersTable[pl][i][2])));    // major rotations by mm , minor rotations with dd
                cinPositionsTable[pl][i][1]= radius/2  * sin((radians(30*cinNumbersTable[pl][i][1])+radians(cinNumbersTable[pl][i][2])));
                cinPositionsTable[pl][i][2]= (cinNumbersTable[pl][i][0]-startYear)*stepHeight*12+ cinNumbersTable[pl][i][1]*stepHeight;  ///geeting to the right height
                
              //cout table  
                coutPositionsTable[pl][i][0]= radius/2  * cos((radians(30*coutNumbersTable[pl][i][1])+radians(coutNumbersTable[pl][i][2])));    // major rotations by mm , minor rotations with dd
                coutPositionsTable[pl][i][1]= radius/2  * sin((radians(30*coutNumbersTable[pl][i][1])+radians(coutNumbersTable[pl][i][2])));
                coutPositionsTable[pl][i][2]= (coutNumbersTable[pl][i][0]-startYear)*stepHeight*12+ coutNumbersTable[pl][i][1]*stepHeight;  ///geeting to the right height
           
                radius = radius + 0.25;
             }  
             
        }  
            //println(cinNumbersTable[0][1]);       
      }