//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_waktemple
// DATE: March 30, 2006
// AUTH: Luke Scull
// NOTE: Starts cutscene in Temple District, Hillsfar.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) &&(GetLocalInt(OBJECT_SELF, "fired") == 0))
    {
        // Fire cutscene script
        CutscenePlay(oPC, "cut_tm_waktemple");
        SetLocalInt(OBJECT_SELF, "fired", 1);
    }
}

/*

void main()
{
object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)

return;

cs_PreCutsceneFade(CS_FADE_TYPE_BLACK, FADE_SPEED_MEDIUM, OBJECT_SELF);

cs_StartCutscene("cut_tm_waktemple", "", 0.1, FALSE, TRUE, 1, OBJECT_SELF);
SetLocalInt(OBJECT_SELF, "fired", 1);
}
*/
