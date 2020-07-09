////////////////////////////////////////////////////////////////////////////////
// dla_d2_deitymala
//
// DLA, Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Conditional script to show Malar as a deity selection based on aligment of
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

    return (nGE==ALIGNMENT_EVIL ||
            (nGE==ALIGNMENT_NEUTRAL &&
            (nLC==ALIGNMENT_CHAOTIC || nLC==ALIGNMENT_NEUTRAL)));
}
