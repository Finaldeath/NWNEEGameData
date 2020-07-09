//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: con_tm_hen_hired
//:: DATE: February 21, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Henchman script
//:: Return true if the Object spoken to is currently
//:: a Henchman.
//:: This should be the basic henchman conversation,
//:: when nothing is else is going on (quest or area)
//::////////////////////////////////////////////////////

#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHench = OBJECT_SELF;

    return (HenchmanIsMine(oHench, oPC));
}
