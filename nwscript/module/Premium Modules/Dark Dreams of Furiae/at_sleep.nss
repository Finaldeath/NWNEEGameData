#include "ddf_util"

void main()
{
    object oPC = GetPCSpeaker();

    if(MovePartyToObject(oPC, oPC, TRUE, FALSE, "You must gather the party before resting")) IncrementDay();

    /*
    SetCutsceneMode(oPC, TRUE, FALSE);
    FadeToBlack(oPC);

    IncrementDay();

    DelayCommand(2.0, FadeFromBlack(oPC));
    DelayCommand(2.0, SetCutsceneMode(oPC, FALSE, TRUE));
    */
}
