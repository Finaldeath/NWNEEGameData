//Does the player have Pale Master levels or Necromantic spell focus?
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) > 0 ||
       GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY, oPC))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
