#include "ddf_util"

// Exposed variable
const string DIALOG = "DIALOG";

void main()
{
    object oPC = GetPlaceableLastClickedBy();
    if (GetIsObjectValid(oPC))
    {
        // Get the waypoint variable
        string sDialog = GetLocalString(OBJECT_SELF, DIALOG);

        if (sDialog != "")
        {
            ActionStartConversation(oPC, sDialog);
        }
        else
        {
            debug("P_CLICK_DIALOG: Missing var [" + DIALOG + "]");
        }
    }
}
