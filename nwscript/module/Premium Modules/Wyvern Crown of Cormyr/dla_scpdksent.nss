//::///////////////////////////////////////////////
//:: FileName dla_scpdksent
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 16/07/2006
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    return (GetLocalInt(OBJECT_SELF, "nSent") < 1);
}
