//::///////////////////////////////////////////////
//:: con_id_lt_notalk
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    first time encountered
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id_liltimmy"
#include "inc_id1_utility"

int StartingConditional()
{
    if (lt_GetIsTalkedTo() == FALSE)
    {
        object oPC = GetPCSpeaker();
        string sKey = GetPCPublicCDKey(oPC);
        if (sKey == "")
        {
            SetLocalInt(GetModule(), "bMultiplayer", FALSE);
        } else
        {
            SetLocalInt(GetModule(), "bMultiplayer", TRUE);

            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY, -1);
            SetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE, ID1_ENCOUNTER_SIZE_NORMAL);
            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY, 50);
        }

        // find the average level of players in the dungeon
        int nCR = GetPartyLevel(GetFirstPC(), TRUE);

        // get timmy's current store
        object oStore = GetLocalObject(OBJECT_SELF, "oStore");
        if (oStore != OBJECT_INVALID)
        {
            DestroyObject(oStore);
        }

        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU37");
        SetLocalInt(oMicroCPU, "nLevel", nCR);
        SetLocalInt(oMicroCPU, "bTimmy", TRUE);
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);

        DelayCommand(0.01, ExecuteScript("exe_id1_micstore", oMicroCPU));

        return TRUE;
    } else
    {
        return FALSE;
    }
}
