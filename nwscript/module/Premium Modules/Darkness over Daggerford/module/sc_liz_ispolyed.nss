// is the player polymorphed as a lizard?

#include "inc_polymorph"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(IsPolymorphed(oPC));
}
