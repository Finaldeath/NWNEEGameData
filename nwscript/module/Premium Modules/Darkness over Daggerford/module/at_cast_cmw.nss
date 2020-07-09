void main()
{

    object oPC=GetPCSpeaker();
    object oTarget=GetNearestObjectByTag("db_rabbitnez");
    int nSpell=SPELL_CURE_MINOR_WOUNDS;
    int nCastSpell=ANIMATION_LOOPING_CONJURE2;
    ActionPauseConversation();
    AssignCommand(oPC,ActionPlayAnimation(nCastSpell,2.0,2.0));
    ActionCastSpellAtObject(nSpell,oTarget);
    DecrementRemainingSpellUses(oPC,nSpell);
    DelayCommand(2.0,ActionResumeConversation());
}
