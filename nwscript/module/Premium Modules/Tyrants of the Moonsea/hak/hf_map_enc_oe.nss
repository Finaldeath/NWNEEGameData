// spawn an encounter and generate random loot when the first player enters
// one of the "random encounter areas

#include "hf_in_spawn"
#include "hf_in_worldmap"

// randomly apply locks and traps to a chest
void DecorateChest(object oChest)
{
    // maybe lock the chest
    int nRandom = d4();
    if (nRandom == 1)
    {
        SetLocked(oChest, TRUE);
        SetLockLockDC(oChest, 10 + d8());
    }
    else
    {
        SetLocked(oChest, FALSE);
    }

    // maybe trap the chest
    nRandom = d10();
    if (nRandom == 1)
    {
        SetTrapActive(oChest, TRUE);
        SetTrapDetectable(oChest, TRUE);
        SetTrapDetectDC(oChest, 5 + d8());
        SetTrapDisarmable(oChest, TRUE);
        SetTrapDisarmDC(oChest, 10 + d8());
        SetTrapRecoverable(oChest, FALSE);
        SetTrapOneShot(oChest, TRUE);
    }
    else
    {
        SetTrapActive(oChest, FALSE);
    }
}

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

        int nRandom = d100();
        if (nRandom <= 35) // this is the percentage chance of random treasure
        {
            object oLoot = GetNearestObjectByTag("hf_map_reloot", oPC);
            if (!GetIsObjectValid(oLoot))
            {
                // select a random loot placeable
                nRandom = d8();
                string sBP = ("hf_map_reloot_" + IntToString(nRandom));
                location lLoc;
                object oWP;
                int nNum;
                int nChest = 0;

                if (nRandom >= 6) // this is a chest placeable
                {
                    // find a chest waypoint
                    nNum = d2();
                    oWP = GetNearestObjectByTag(sWM_RE_CHEST_SPAWN, oPC, nNum);
                    nChest = 1;
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

                // create the loot
                if (GetIsObjectValid(oWP))
                {
                    lLoc = GetLocation(oWP);
                    object oLoot = CreateObject(OBJECT_TYPE_PLACEABLE, sBP, lLoc);
                    if (GetIsObjectValid(oLoot))
                    {
                        if (nChest == 1)
                        {
                            DecorateChest(oLoot);
                        }
                    }
                }
            }
        }

        SpawnEnter(oPC);
    }
}
