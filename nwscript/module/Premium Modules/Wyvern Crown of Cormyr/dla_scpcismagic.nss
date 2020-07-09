//::///////////////////////////////////////////////
//:: FileName dla_scpcismagic
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//
//  Returns TRUE if PC is a bard, sorcerer, wizard
//  cleric or druid
//
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 16/07/2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return (GetLevelByClass(CLASS_TYPE_BARD, oPC) >= 1) ||
    (GetLevelByClass(CLASS_TYPE_SORCERER, oPC) >= 1) ||
    (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) >= 1) ||
    (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) >= 1) ||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC) >= 1);
}
