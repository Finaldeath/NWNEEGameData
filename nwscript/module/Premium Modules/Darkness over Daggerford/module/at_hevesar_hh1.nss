//sets that the PC is helping Hevesar
//Author: Damian Brown (Luspr)
//Date: 02-Aug-2005
#include"inc_bw_worldmap"
void main()
{
    SetLocalInt(GetModule(), "help_hevesar", 1);
    RevealMapLocation("c1ar1300");
}
