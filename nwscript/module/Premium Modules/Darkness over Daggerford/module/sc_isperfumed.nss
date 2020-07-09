int StartingConditional()
{
    int iPerfumed = 0;
    object oPC = GetPCSpeaker();
    effect eCheck = GetFirstEffect(oPC);

    while(GetIsEffectValid(eCheck))
    {
        // Check creator
        if(GetEffectCreator(eCheck) == OBJECT_SELF)
        {
            iPerfumed = 1;
        }
        eCheck = GetNextEffect(oPC);
    }
    return iPerfumed;
}
