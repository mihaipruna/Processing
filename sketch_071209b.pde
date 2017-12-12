
/*
Copyright (C) 2008  Mihai Pruna

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
http://www.gnu.org/licenses/gpl.html

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.*/



class vector{
  float x;
  float y;
  float z;
  float leng;
  String lbl;
  int stx;
  int sty;
  int stz;
  
   vector(String label,float xc,float yc,float zc)
  {
    lbl=label;
    x=xc;
    y=yc;
    z=zc;
    leng=sqrt(x*x+y*y+z*z);
    if (abs(x)<10 )
    {
      stx=round(x*255);
    }else
    
    {stx=round(x);}
    
if (abs(y)<10 )
    {
      sty=round(y*255);
    }else
    
    {sty=round(y);}
    
    if (abs(z)<10 )
    {
      stz=round(z*255);
    }else
    
    {stz=round(z);}
    
    while (stx>200 || stx<100)
  {
  if (stx<100)
 {stx=stx+99;

}

if (stx>200)
 {stx=stx-99;

}



  }
while (sty>200 || sty<100)
  {
  if (sty<100)
 {sty=sty+99;

}

if (sty>200)
 {sty=sty-99;

}



  }
  while (stz>200 || stz<100)
  {
  if (stz<100)
 {stz=stz+99;

}

if (stz>200)
 {stz=stz-99;

}



  }
}
  
  void init(String label,float xc,float yc,float zc)
  {
    lbl=label;
    x=xc;
    y=yc;
    z=zc;
    leng=sqrt(x*x+y*y+z*z);
    if (abs(x)<10 )
    {
      stx=round(x*255);
    }else
    
    {stx=round(x);}
    
if (abs(y)<10 )
    {
      sty=round(y*255);
    }else
    
    {sty=round(y);}
    
    if (abs(z)<10 )
    {
      stz=round(z*255);
    }else
    
    {stz=round(z);}
    
     while (stx>200 || stx<100)
  {
  if (stx<100)
 {stx=stx+99;

}

if (stx>200)
 {stx=stx-99;

}



  }
while (sty>200 || sty<100)
  {
  if (sty<100)
 {sty=sty+99;

}

if (sty>200)
 {sty=sty-99;

}



  }
  while (stz>200 || stz<100)
  {
  if (stz<100)
 {stz=stz+99;

}

if (stz>200)
 {stz=stz-99;

}



  }
  }
  
  void update()
  {leng=sqrt(x*x+y*y+z*z);}
void normalize()
{x=x*100/fl;
y=y*100/fl;
z=z*100/fl;
}

void render()
{ 
  
stroke(stx,sty,stz);
  line (0,0,0,x,y,z);
PFont regfont = loadFont("Ziggurat.vlw"); 
   textMode(MODEL);
   textFont(regfont,5);
       
       if (maxl>1000)
       {
       textSize(40);
     }
       else if (maxl>100)
       {
         textSize(round(maxl)/20);
       }
       else
       {
       textSize(round(maxl/10));
     }
       
       
    textAlign(BOTTOM);
    fill(stx,sty,stz);
     pushMatrix();
    translate(x,y,z);
    rotateX(-3.1416/2);
    text(lbl,0,0,0);
    rotateX(3.1416/2);
    translate(-x,-y,-z);
    popMatrix();
   
    //text(lbl,x,y,z);

}

}

float fl=100;
   float sf=1;
float x1,y1,z1;
int starter=1;
String buff="";
int yy=30;
int xx=45;
vector lala=new vector("s",1,1,1);
 float maxl=0;
  PFont regfont;
boolean datainput=true;
int vn=0;
int counterer=1;
boolean xinput=false;
String cords="";
int index=0;
int bula=0;
String[] values=new String[99];
void setup() 
{
 xx=45;
 yy=30;
 starter=1;
 buff="";
  lala=new vector("s",1,1,1);
 maxl=0;
 datainput=true;
 vn=0;
 counterer=1;
 cords="";
 index=0;
  size(800, 600, P3D);
  frameRate(30);
  //noStroke();
  regfont = loadFont("Ziggurat.vlw"); 


}


void draw() 
{
   regfont = loadFont("Ziggurat.vlw"); 
 
    

  lights();
  background(bula);
stroke(100);







  if (datainput==true)
  
{ 
  regfont = loadFont("Ziggurat.vlw"); 
 stroke(255);
  textFont(regfont);
 
  textMode(SCREEN);
 String lords="Sequentially input for all vectors: label,x,y,z separated by commas. Press SPACEBAR when done ";
 
 text(lords.substring(0,35),20,20);
 text(lords.substring(36,lords.length()),20,60);
 text(cords,20,100);
 
 if (buff.length()!=0) 
 { 
   char charry=buff.charAt(0);
   buff="";
    
   if (charry!=' ') 
 {
   
   cords=cords+charry;
 
 }
 else
 {
   datainput=false;
   int position=0;
   counterer=1;
   while (position!=-1)
   {
     position=cords.indexOf(",");
     if (position!=-1)
     {
     values[counterer]=cords.substring(0,position);
     cords=cords.substring(position+1,cords.length());
     //println(values[counterer]+" "+cords);
     counterer=counterer+1;   
   }
   }
   values[counterer]=cords;  
   
  
 }
 }
}
 else
 {
  for (int j=0; j< counterer/4;j++)
   {
     float vex=float(values[j*4+2]);
     float vey=float(values[j*4+3]);
     float vez=float(values[j*4+4]);
     String labeller=values[j*4+1];
     
     lala.init(values[j*4+1],vex,vey,vez);
    if (starter==1)
    {
     if (lala.leng>maxl)
     {maxl=lala.leng;}
    }
   if (starter!=1)
   {lala.normalize();
   }
     
      lala.render();
   }
   
   if (starter==1)
   {fl=maxl;}
   if (starter!=1)
   {maxl=100;}
   
   
      stroke(100);
    textMode(MODEL);
    textSize(5);
    line(0,0,0,maxl,0,0);
   
    
    line(0,0,0,0,maxl,0);
    
  
    line(0,0,0,0,0,maxl);

   
    textFont(regfont,5);
    textAlign(BOTTOM);   
   if (maxl>1000)
       {
       textSize(40);}
       else if (maxl>100)
       {textSize(round(maxl)/20);
       }
       else
       {textSize(round(maxl/10));}
   // 
   //rotateY(3.1416/2);
    //translate(0,maxl,0);
    fill(200);
    
    pushMatrix();
    translate(maxl,0,0);
    rotateX(-3.1416/2);
    text("x",0,0,0);
    rotateX(3.1416/2);
    translate(-maxl,0,0);
    popMatrix();
    
     pushMatrix();
    translate(0,maxl,0);
    rotateX(-3.1416/2);
    text("y",0,0,0);
    rotateX(3.1416/2);
    translate(0,-maxl,0);
    popMatrix();
    
     pushMatrix();
    translate(0,0,maxl);
    rotateX(-3.1416/2);
    text("z",0,0,0);
    rotateX(3.1416/2);
    translate(0,0,-maxl);
    popMatrix();
   
     
    
    
    

if (starter==1)
{

 starter=2;
}
 x1=maxl+10;
y1=maxl+10;
z1=maxl+10;
 } 
   
 
  
 
 
  




if (keyPressed )
{  
char charry='l';
  if (starter!=1)
  {
    if (buff.length()!=0) 
 {
    charry=buff.charAt(0);
   buff="";
 }

   
   if (charry=='=' && sf>0.1)
   {sf=sf-0.01;
   }else if
   (charry=='-')
   {sf=sf+0.01;
   }
   else if
   (charry=='r')
   
   {/*xx=45;
   yy=30;
    sf=1;
     x1=maxl;
y1=maxl;
z1=maxl;
     float xc = sf*(x1*cos(xx*3.1416/180)  - y1*sin(xx*3.1416/180));
float yc = sf*(x1*sin(xx*3.1416/180) + y1*cos(xx*3.1416/180));
float zc = sf*(z1)*sin(yy*3.1416/180);
stroke(255);
camera(xc,yc,zc , 0, 0, 0, 0,0, -1);
     setup();*/
     exit();
   }else if
   (charry=='b')
   {
     if (bula==255)
     {bula=0;}
     else
     {bula=255;}
     
   }
  

}
     
   
  
  

  if (key == CODED) {
    if (keyCode == UP) {
      yy++;
      if (yy>=maxl)
      {yy--;}
      
      
    } else if (keyCode == DOWN) {
      yy--;
      if (yy<=-maxl)
      {yy++;}
      
   
    } 
    else if (keyCode == LEFT) {
      xx--;
      if (xx==0)
      {xx=360;}
   
    } else if (keyCode == RIGHT) {
      xx++;
      if (xx==360)
      {xx=0;}
   
    } else if (keyCode==ESC)
  {
  exit();
  
  }
       
} 
}



float xc,yc,zc;
//rotate camera round z

xc = sf*(x1*cos(xx*3.1416/180)  - y1*sin(xx*3.1416/180));
yc = sf*(x1*sin(xx*3.1416/180) + y1*cos(xx*3.1416/180));
zc = sf*(z1)*sin(yy*3.1416/180);



/*yc = y1*cos(yy*3.1416/180) - z1*sin(yy*3.1416/180);
zc = y1*sin(yy*3.1416/180) + z1*cos(yy*3.1416/180);
xc = x1;
*/

camera(xc,yc,zc , 0, 0, 0, 0,0, -1);

}

void keyPressed()
{
  buff="";
  buff=buff+key;
  
}

  
 

