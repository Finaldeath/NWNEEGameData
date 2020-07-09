// has the player collected enough bottles of blood

#include "inc_bloodbag"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return(HasEnoughBlood(oPC));
}
