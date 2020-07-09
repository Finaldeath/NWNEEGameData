// onEnter event for the lizard marsh; spawns encounters

#include "hf_in_spawn"
#include "inc_polymorph"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // should we repoly?
        string sPreviousArea = GetLocalString(oPC, "sWM_PreviousArea");
        if (FindSubString(sPreviousArea, "ar1900") >= 0 ||
            FindSubString(sPreviousArea, "ar1800") >= 0)
        {
            PolymorphAreaEnter(oPC, TRUE);
        }
        else
        {
            PolymorphAreaEnter(oPC, FALSE);
        }

        // choose a spawn list
        string sList;
        int n = d4();
        if      (n == 1) sList = "A";
        else if (n == 2) sList = "B";
        else if (n == 3) sList = "C";
        else             sList = "D";

        // set all encounters to use that spawn list
        int i = 1;
        object oEnc = GetNearestObjectByTag("ENC_AR1800", oPC, i);
        while (GetIsObjectValid(oEnc))
        {
            if (GetLocalString(oEnc, "HF_SP_CREATURES_LIST_USE") != "")
            {
                SetLocalString(oEnc, "HF_SP_CREATURES_LIST_USE", sList);
            }
            oEnc = GetNearestObjectByTag("ENC_AR1800", oPC, ++i);
        }

        // run the encounters
        SpawnEnter(oPC);

        // save the game when the player first enters this area
        if (GetLocalInt(OBJECT_SELF, "nGameSaved") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nGameSaved", 1);
            DoSinglePlayerAutoSave();
        }
    }
}
