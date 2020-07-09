// basic spawn on enter script plus random treasure generation
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

        int nRandom = d100();
        if (nRandom <= 35) // this is the percentage chance of random treasure
        {
            object oLoot = GetNearestObjectByTag("bw_reloot", oPC);
            if (!GetIsObjectValid(oLoot))
            {
                // select a random loot placeable
                nRandom = d6();
                string sBP = ("bw_reloot0" + IntToString(nRandom));
                location lLoc;
                object oWP;
                int nNum;

                if (nRandom > 4) // this is a chest placeable
                {
                    // find a chest waypoint
                    nNum = d2();
                    oWP = GetNearestObjectByTag("re_chest_wp", oPC, nNum);
                }
                else // loot sack, etc.
                {
                    // find a creature spawn waypoint to use for the drop
                    nNum =(d3() + 1);
                    oWP = GetNearestObjectByTag(sEncWP, oPC, nNum);
                    if (!GetIsObjectValid(oWP))
                    {
                        oWP = GetNearestObjectByTag(sEncWP, oPC, 2);
                    }
                }

                if (GetIsObjectValid(oWP))
                {
                    lLoc = GetLocation(oWP);

                    // create loot here
                    CreateObject(OBJECT_TYPE_PLACEABLE, sBP, lLoc);
                }
            }
        }

        SpawnEnter(oPC);
    }
}
