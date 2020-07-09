//:://////////////////////////////////////////////////
//:: X0_O2_SEC_DOOR2
//::    This is an OnEntered script for a generic trigger.
//::    When a PC enters the trigger area, it will perform
//::    a check to determine if the secret item is revealed,
//::    then make it appear if so.
//::
//::    Secret item to be revealed: Secret Stone Door
//::    Checking for: SKILL_SEARCH
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/08/2002
//:://////////////////////////////////////////////////
#include "ddf_util"
#include "x0_i0_secret"


void main()
{
    object oEntered = GetEnteringObject();

    if (GetIsSecretItemRevealed()) {return;}

    if ( DetectSecretItem(oEntered)) {
        if (!GetIsPC(oEntered)) {
            // If a henchman, alert the PC if we make the detect check
            object oMaster = GetMaster(oEntered);
            if (GetIsObjectValid(oMaster)
                && oEntered == GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oMaster))
            {
                AssignCommand(oEntered, PlayVoiceChat(VOICE_CHAT_SEARCH));
            }
        } else {
            // It's a PC, reveal the item
            AssignCommand(oEntered, PlayVoiceChat(VOICE_CHAT_LOOKHERE));
            //RevealSecretItem("x0_sec_door2");
            string sSetUseableObjectTag = GetLocalString(OBJECT_SELF, "item_tag");
            int bFlag = GetLocalInt(OBJECT_SELF, "item_flag");
            object oTarget = GetObjectByTag(sSetUseableObjectTag);
            if(GetIsObjectValid(oTarget) == FALSE)
            {
                debug("Unable to find object tagged '" + sSetUseableObjectTag + "'.");
                return;
            }
            SetUseableFlag(oTarget, bFlag);
        }
    }
}
