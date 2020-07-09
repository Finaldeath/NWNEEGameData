//::///////////////////////////////////////////////
//:: Check Arcane
//:: NW_D2_Arcane
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks if the PC is a Wizard, Sorcerer or Bard
    and does not have the key and has met Rylett before
*/
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: October 10, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int nClass;
    nClass = GetLevelByClass(CLASS_TYPE_BARD, GetPCSpeaker());
    nClass += GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker());
    nClass += GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker());
    if (!((nClass > 0) && (GetLocalInt(OBJECT_SELF,"has_met_pc")==1)
    &&(!(GetLocalInt(GetPCSpeaker(), "pm_sorcgotkey") == 1))))
    return FALSE;
    return TRUE;

}

