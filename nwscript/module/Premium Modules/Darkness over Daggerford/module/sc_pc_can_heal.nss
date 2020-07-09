int StartingConditional()
{
    //can the pc heal either by spell or healing skill?
    //i dont think its necessary to check if they have a healing spell memorised
    //e.g. what about clerics with auto convert??
    object oPC=GetPCSpeaker();
    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)==1)
    return TRUE;
    else if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)==1)
    return TRUE;
    else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)==1)
    return TRUE;
    else if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)==1)
    return TRUE;
    else if(GetLevelByClass(CLASS_TYPE_MONK,oPC)==1)
    return TRUE;
    else if(GetSkillRank(SKILL_HEAL,oPC,TRUE)>0)
    return TRUE;
    return FALSE;
}
