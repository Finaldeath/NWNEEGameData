//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_suzildar0
//::////////////////////////////////////////////////////
//:: "Healing" script for Loviatar temple
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oSuzildara = OBJECT_SELF;

    // Only the first time is free
    if (GetLocalInt(oSuzildara, "HF_ARG") > 0)
    {
        TakeGoldFromCreature(100, oPC, FALSE);
    }
    SetLocalInt(oSuzildara, "HF_ARG", 1);

    AssignCommand(oPC, ActionPauseConversation());
    FadeToBlack(oPC, FADE_SPEED_FAST);

    DelayCommand(2.0, AssignCommand(oPC, PlaySound("cb_sw_whip2")));
    DelayCommand(2.5, AssignCommand(oPC, PlaySound("cb_sw_whip2")));
    DelayCommand(3.5, AssignCommand(oPC, PlaySound("cb_sw_whip1")));

    DelayCommand(5.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
    DelayCommand(6.0, AssignCommand(oPC, ActionResumeConversation()));
}
