// make the lieutenant run up and start a conversation with the player

#include "ddf_util"

void main()
{

    //debug("-- in heartbeat...");

    if(GetLocalInt(GetModule(), HADLIEUTENANTDIALOG) == FALSE && IsInConversation(OBJECT_SELF) == FALSE)
    {
         object oPC = GetFirstPC();
         if(GetIsObjectValid(oPC))
         {
            ClearAllActions();
            ActionMoveToObject(oPC, TRUE);
            ActionStartConversation(oPC, "", FALSE, FALSE);
         }
    }

    ExecuteScript("nw_c2_default1", OBJECT_SELF);

}

