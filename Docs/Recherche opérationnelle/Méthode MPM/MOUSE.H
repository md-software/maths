#include<dos.h>
/***************************************************************/
union REGS mouse,center;
int sx,sy,button;
/*************************************************************/
void ini_mouse()
{  mouse.x.ax=0;
   int86(0x33,&mouse,&center);
}
/*************************************************************/
void show_mouse()
{  mouse.x.ax=1;
   int86(0x33,&mouse,&center);
}
/*************************************************************/
void hide_mouse()
{  mouse.x.ax=2;
   int86(0x33,&mouse,&center);
}
/*************************************************************/
void get_pos()
{  mouse.x.ax=3;
   int86(0x33,&mouse,&center);
   sx=center.x.cx;
   sy=center.x.dx;
   button=center.x.bx&1;
}
/*************************************************************/