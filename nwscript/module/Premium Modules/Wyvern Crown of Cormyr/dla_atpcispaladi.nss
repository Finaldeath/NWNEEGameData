//::///////////////////////////////////////////////
//:: FileName dla_atpcispaladi
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Returns TRUE if the player is a paladin
//
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 16/07/2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    // Restrict based on the player's class
    return (GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) >= 1);
}