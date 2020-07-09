// despawn all spawned creatures and loot bags this area when the last player leaves
// this is used as the area exit event script in random encounter areas

#include "hf_in_spawn"

void main()
{
    object oExiter = GetExitingObject();
    object oMe = OBJECT_SELF;

    if (GetIsPC(oExiter))
    {
        SetLocalInt(oMe, "iActive", 0);

        int nInREArea = 0;
        string sEncName = GetLocalString(OBJECT_SELF, "HF_SP_NAME");

        if (sEncName == "MAPRND") // RE area
        {
            nInREArea = 1;

            // reset travel variables!
            DeleteLocalObject(oExiter, "oWM_RE_Destination");
            DeleteLocalInt(oExiter, "nWM_RE_TDays");
            DeleteLocalInt(oExiter, "nWM_RE_nTHours");

            // MULTIPLAYER HANDLER //
            // remove this variable to clear the 'active' random encounter
            DeleteLocalString(GetModule(), "sWM_RE_ActivePoint");
        }

        object oPC = GetFirstPC();
        int nPCsInArea = 0;

        while (GetIsObjectValid(oPC) && (nPCsInArea == 0))
        {
            if ((oPC != oExiter) && (GetArea(oPC) == oMe))
            {
                nPCsInArea = 1;
            }
            oPC = GetNextPC();
        }

        if (nPCsInArea == 0)
        {
            string sEncWP = ("ENC_" + sEncName);
            object oEncWP = GetObjectByTag(sEncWP);
            int nNth = 1;

            if (nInREArea == 1) // RE area
            {
                // remove any RE chests or loot bags
                // use an encounter waypoint to this area
                object oTreasure = GetNearestObjectByTag("hf_map_reloot", oEncWP, nNth);
                while (GetIsObjectValid(oTreasure))
                {
                    if (GetLocalInt(oTreasure, "nTreasure") == 1)
                    {
                        DestroyObject(oTreasure, 1.0f);
                    }

                    nNth += 1;
                    oTreasure = GetNearestObjectByTag("hf_map_reloot", oEncWP, nNth);
                }

                SetLocalInt(oExiter, "nREComplete", 1);
            }

            // clear spawns from all ENC waypoints
            nNth = 0;
            oEncWP = GetObjectByTag(sEncWP, nNth);
            while (GetIsObjectValid(oEncWP))
            {
                // this function removes all creatures spawned by encounter oEnc
                SpawnRemoveCreatures(oEncWP, oExiter);

                nNth += 1;
                oEncWP = GetObjectByTag(sEncWP, nNth);
            }

            // remove bodybags
            nNth = 0;
            oEncWP = GetObjectByTag(sEncWP);
            object oItem;
            object oBodybag = GetNearestObjectByTag("BodyBag", oEncWP, nNth);
            while (GetIsObjectValid(oBodybag))
            {
                oItem = GetFirstItemInInventory(oBodybag);
                while (GetIsObjectValid(oItem))
                {
                    AssignCommand(oBodybag, ActionDoCommand(DestroyObject(oItem)));
                    oItem = GetNextItemInInventory(oBodybag);
                }
                AssignCommand(oBodybag, ActionDoCommand(DestroyObject(oBodybag, 0.5f)));
                nNth += 1;
                oBodybag = GetNearestObjectByTag("BodyBag", oEncWP, nNth);
            }
        }
    }
}
