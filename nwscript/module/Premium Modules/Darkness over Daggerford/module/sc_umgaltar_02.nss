int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oJared = GetNearestObjectByTag("ks_jared");
    if (GetIsObjectValid(oJared))
    {
        if (!GetIsDead(oJared))
        {
            AssignCommand(oJared, ClearAllActions());
            AssignCommand(oJared, ActionMoveToObject(oPC, TRUE));
            return(TRUE);
        }
    }
    return(FALSE);
}
