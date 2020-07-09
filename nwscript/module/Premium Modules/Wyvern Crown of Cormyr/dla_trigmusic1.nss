// February 2006
// B W-Husey
// Change the battle music as the player approaches the WL
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
    MusicBattleChange(GetArea(oPC),73);     // Change to chapter 3 battle music
    DestroyObject(OBJECT_SELF);
    }
}
