void main()
{
    object oRab=GetNearestObjectByTag("db_rabbitnez");
    object oPC=GetPCSpeaker();
    effect eZonked=GetFirstEffect(oRab);
    SetLocalInt(GetModule(),"rab_awake",1);
    while (GetIsEffectValid(eZonked))
        {
        if (GetEffectType(eZonked)==EFFECT_TYPE_SLEEP)
        RemoveEffect(oRab,eZonked);
        eZonked=GetNextEffect(oRab);
        }
    AssignCommand(oPC,ClearAllActions());
    //hopefully one of these will fire!
    DelayCommand(1.5,AssignCommand(oRab,ActionStartConversation(oPC)));
    DelayCommand(1.5,AssignCommand(oPC,ActionStartConversation(oRab)));
}
