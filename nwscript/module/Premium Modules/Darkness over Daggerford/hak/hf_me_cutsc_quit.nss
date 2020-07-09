// use this as the module's onCutsceneAbort script

#include "hf_in_cutscene"

void main()
{
    object oPC = GetLastPCToCancelCutscene();
    CutsceneAbort(oPC);
}
