//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_dracolich
// DATE: February 25, 2005
// AUTH: Luke Scull
// NOTE: Starts Order ambush cutscene.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "fired") == 0) && (GetLocalInt(oPC, "dracolich") == 1))
    {
        // Fire cutscene script
        SetLocalInt(OBJECT_SELF, "fired", 1);
        CutscenePlay(oPC, "cut_tm_ambush");
    }
}

/*
void main()
{
object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(oPC, "dracolich")!= 1)
   return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)

return;

cs_PreCutsceneFade(CS_FADE_TYPE_BLACK, FADE_SPEED_MEDIUM, OBJECT_SELF);

cs_StartCutscene("cut_tm_ambush", "", 0.1, FALSE, TRUE, 1, OBJECT_SELF);
SetLocalInt(OBJECT_SELF, "fired", 1);
}
*/
