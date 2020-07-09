//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: tat_tm_lockgate
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: If the player has maanged to get the Locktower
//       gate opened peacefully, his/henchmen will get
//       removed to "keep up the ruse".
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "hf_in_henchman"

void main()
{
    object oLocktower = GetObjectByTag("Locktower_To_Voonlar");
    object oPC = GetFirstPC();

    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");

    if(nInt == 70)
    {
        int i = 0;
        int nHenchmanCount = HenchmanCount(oPC);

        object oHenchman;

        for (i = nHenchmanCount; i > 0; i--)
        {
            oHenchman = GetHenchman(oPC, i);
            HenchmanFire(oHenchman, oPC);
            HenchmanGoHome(oHenchman);
        }

        if(nHenchmanCount > 0)
        {
            SetLocalInt(oPC, "nHenchmenLeft", 1);
        }
    }

    AssignCommand(oPC, JumpToObject(oLocktower));
}
