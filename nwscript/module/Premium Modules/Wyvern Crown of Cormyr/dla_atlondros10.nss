// B W-Husey
// September 2005
// Londro Sidequest variable set to 10. Quest finished. Matron part at least succeeded.

#include "cu_functions"

void main()
{

object oPC = GetPCSpeaker();
AllParty("LondroSide",oPC,10);
    PartyGotEntry("Dud",oPC,150,"XP Gain - quest completed");
    string sName = "AligXPEnd"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    ScoreAlign(oPC,1,1,1,1,0,1,1,0,1,1);
    AllParty(sName,oPC,1);
    }
}
