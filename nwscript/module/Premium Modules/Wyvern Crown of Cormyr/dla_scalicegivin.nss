//::///////////////////////////////////////////////
//:: FileName dla_scalicegivin
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 16/07/2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Inspect local variables
    return ((GetLocalInt(oPC, "nInfoPoltGath") == 1) &&
       (GetLocalInt(oPC, "nInfoPoltGot") == 0));
}
