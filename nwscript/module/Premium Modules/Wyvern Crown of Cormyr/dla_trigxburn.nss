//Sets a variable on the PC that tells them they've left a burn area.
#include "cu_functions"
void main()
{
    object oPC = GetExitingObject();
    if (GetIsDefPC(oPC))  SetLocalInt(oPC,"nBurnArea",0);
}
