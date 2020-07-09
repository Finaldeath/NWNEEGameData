//sc_ac_rylett1
//Checks if the PC is NOT a Wizard, Sorcerer or Bard
// AND that the player has met Rylett before
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Oct. 10, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int nClass;
    nClass = GetLevelByClass(CLASS_TYPE_BARD, GetPCSpeaker());
    nClass += GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker());
    nClass += GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker());

    if (!((nClass <= 0) && (GetLocalInt(OBJECT_SELF,"has_met_pc")==1)))
    return FALSE;
    return TRUE;
}

