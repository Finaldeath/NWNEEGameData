#include "ddf_util"

void main()
{
    // Shift alignment
    AdjustAlignment(GetPlaceableLastClickedBy(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP);

    // Guard run over to window with text bubble
    object oGuard = GetObjectByTag("FraternityofOrderGuard6");
    AssignCommand(oGuard, SpeakString("Oh that smells good. Powers be, I'm so hungry. Bakery is just around the corner..."));
    AssignCommand(oGuard, ActionMoveToObject(GetObjectByTag("WP_Midtown_Bakery")));

    // Update guard flag
    SetLocalInt(oGuard, "distracted", TRUE);
}
