//::///////////////////////////////////////////////
//:: FileName dla_scpdkself0
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: B G P Hughes
//:: Created On: 18/02/2006 11:34:21
//:://////////////////////////////////////////////
int StartingConditional()
{
    // Inspect local variables
    return GetLocalInt(OBJECT_SELF, "nSelfVar") == 0;
}
