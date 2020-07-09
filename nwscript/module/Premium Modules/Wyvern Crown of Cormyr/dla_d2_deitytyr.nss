////////////////////////////////////////////////////////////////////////////////
// dla_d2_deitytyr
//
// DLA, Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Conditional script to show Tyr as a deity selection based on aligment of
    the PC speaker in a conversation.
 */
////////////////////////////////////////////////////////////////////////////////
// Created By: Syrsnein
// Created On: 12 June 2006
////////////////////////////////////////////////////////////////////////////////
/*
 Change history

 */
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nGE = GetAlignmentGoodEvil(oPC);
    int nLC = GetAlignmentLawChaos(oPC);

    return ((nGE==ALIGNMENT_GOOD &&
            (nLC==ALIGNMENT_LAWFUL || nLC==ALIGNMENT_NEUTRAL)) ||
            (nGE==ALIGNMENT_NEUTRAL && nLC==ALIGNMENT_LAWFUL));
}
