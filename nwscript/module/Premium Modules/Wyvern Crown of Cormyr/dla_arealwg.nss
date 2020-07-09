// February 2006
// B W-Husey
// Sets up Chase as the battle track the first time the glade is entered.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    int nMusic = GetLocalInt(oPC,"nHuntMusic");
    if (GetIsDefPC(oPC) && nMusic ==0)
    {
        MusicBattleChange(oArea,85); //change to chase track
        SetLocalInt(oPC,"nHuntMusic",1);
    }

}
