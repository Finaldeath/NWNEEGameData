//Sets a variable on the PC that tells them they're in a burn area. Dropping a barrel of oil while
//In this state puts a variable on the barrel placeable so it sets fire to things when it explodes.

//This one is used on the ship, to identify it from the rest (variable set to 2 not 1)
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))  SetLocalInt(oPC,"nBurnArea",2);
}
