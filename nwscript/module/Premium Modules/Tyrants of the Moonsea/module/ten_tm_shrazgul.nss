//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_shrazgul
// DATE: October 29, 2005
// AUTH: Luke Scull
// NOTE: Starts Shrazgul cutscene
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

const string DOOR_TAG_SHRAZ_LAIR = "ShrazgulsLair_To_OldCatacombs";

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) &&(GetLocalInt(OBJECT_SELF, "nDone") == 0))
    {
        // Fire cutscene script
        CutscenePlay(oPC, "cut_tm_shrazgul");

        object oDoor = GetObjectByTag(DOOR_TAG_SHRAZ_LAIR);
        AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        DelayCommand(1.0, AssignCommand(oDoor, SetLocked(oDoor, TRUE)));

        SetLocalInt(OBJECT_SELF, "nDone", 1);
    }
}

