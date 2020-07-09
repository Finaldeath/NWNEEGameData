//dla_atmandercost
// May 2006
// B W-Husey
// Sets cost of the treasure map to 1 less gold than player has or 20gp min.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetGold(oPC)-1;

    if (GetLocalInt(oPC,"nTMapCost")>0) return; //price already set.
    else
    {
        if (nGold <20) nGold = 20;
        AllParty("nTMapCost",oPC,nGold);
        SetCustomToken(1008,IntToString(nGold));
    }
}
