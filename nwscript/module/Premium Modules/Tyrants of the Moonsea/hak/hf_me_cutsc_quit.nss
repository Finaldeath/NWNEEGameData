// use this as the module's onCutsceneAbort script

#include "hf_in_cutscene"
#include "hf_in_worldmap"

void main()
{
    object oPC = GetLastPCToCancelCutscene();
    AbortMapCutscene(oPC);
    CutsceneAbort(oPC);
}
