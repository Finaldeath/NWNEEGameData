//::///////////////////////////////////////////////
//:: PotSC - Henchman Popup Trigger: A0_MARTINS
//:: ten_pop_martins.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     If any henchmen are nearby, have them say an
     appropriate popup line.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 6, 2005
//:://////////////////////////////////////////////

void ClearConvIndex(object oPC, string sConvIndex);

void main()
{
    object oEnterer = GetEnteringObject();
    object oNisar0 = GetNearestObjectByTag("a0_hench_nisar");
    string sConvIndex = GetLocalString(OBJECT_SELF, "CONV_INDEX");
    int bFireOnce = GetLocalInt(OBJECT_SELF, "bFireOnce");
    object oMartins = GetNearestObjectByTag("a0_Martins");

    //Only fire if Martins is present.
    if (GetIsObjectValid(oMartins) == TRUE)
    {
        //Check the DoOnce
        if (bFireOnce == FALSE)
        {
            //Only fire for an actual PC...
            if (GetIsPC(oEnterer) == TRUE &&
                GetIsPossessedFamiliar(oEnterer) == FALSE &&
                GetIsDM(oEnterer) == FALSE &&
                GetIsDMPossessed(oEnterer) == FALSE)
            {
                //Only fire if there's actually a henchman in the area.
                if (GetIsObjectValid(oNisar0) == TRUE)
                {
                    //Apply the ConvIndex to the player.
                    SetLocalString(oEnterer, "CONV_INDEX", sConvIndex);

                    //Prepare the player and henchmen for conv.
                    AssignCommand(oEnterer, ClearAllActions(TRUE));
//                    AssignCommand(oNisar0, ClearAllActions(TRUE));

                    //Flag the trigger object on the player so the DoOnce can be set in the conv.
                    SetLocalObject(oEnterer, "oPopUpTrigger", OBJECT_SELF);

                    //Have the PC launch the popup conv file on themselves.
                    AssignCommand(oEnterer, ActionStartConversation(oEnterer, "a0_hench_popups", FALSE, FALSE));

                    //Remove the ConvIndex from the player on a delay.
                    DelayCommand(6.0, ClearConvIndex(oEnterer, sConvIndex));
                }
            }
        }
    }
}

//:://////////////////////////////////////////////
/*
    Clear the Conversation index from the player
    (provided a new one hasn't already been set).
*/
//:://////////////////////////////////////////////
void ClearConvIndex(object oPC, string sConvIndex)
{
    string sCurIndex = GetLocalString(oPC, "CONV_INDEX");
    object oTrigger = GetLocalObject(oPC, "oPopUpTrigger");

    if (sCurIndex == sConvIndex)
    {
        SetLocalString(oPC, "CONV_INDEX", "");
    }
    if (oTrigger == OBJECT_SELF)
    {
        SetLocalObject(oPC, "oPopUpTrigger", OBJECT_INVALID);
    }
}
