// basic spawn on enter script
// for random encounter areas
//
// -Brian Watson

#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    if (GetIsPC(oPC) && GetLocalInt(oArea, "iActive") == 0)
    {
        SetLocalInt(oArea, "iActive", 1);

        string sEncName = GetLocalString(OBJECT_SELF, "HF_SP_NAME");
        string sEncWP = ("ENC_" + sEncName);

        // determine which random encounter list to use
        string sList;
        int nRE = d3();
        if      (nRE == 1) sList = "A";
        else if (nRE == 2) sList = "B";
        else               sList = "C";

        // set var's on all the ENC waypoints
        int nNth = 0;
        object oEncWP = GetObjectByTag(sEncWP, nNth);
        while (GetIsObjectValid(oEncWP))
        {
            SetLocalString(oEncWP, "HF_SP_CREATURES_LIST_USE", sList);
            nNth += 1;
            oEncWP = GetObjectByTag(sEncWP, nNth);
        }

        SpawnEnter(oPC);
    }
}
