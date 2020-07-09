//::///////////////////////////////////////////////
//:: Area Transition: No Hostiles, No Possessed Familiars
//:: TCL_NoHostNoFam.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Prevents hostiles from following the PC into
    "Safe Areas" in the module while also including
    the standard restriction on Possessed Familiars.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_polymorphfix"

void JumpAssociate(object oMaster, object oTarget, int iAssociateType);

void main()
{
    object oSelf = OBJECT_SELF;
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(oSelf);
    object oCursor;
    int iCounter;

    if (GetIsPossessedFamiliar(oClicker) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oClicker);
    }
    else if(GetIsPC(oClicker) == TRUE)
    {
        //SendMessageToPC(oClicker, "**You are trying to transition.");
        //SendMessageToPC(oClicker, "Door: " + GetTag(oSelf) + " Destination: " + GetTag(oTarget));

        Transition_RemovePolymorphIfNecessary(oClicker, oTarget);

        AssignCommand(oClicker, JumpToObject(oTarget));

// this is completely unnecessary, and in fact causes problems because of a bug in the function
//        JumpAssociate(oClicker, oTarget, ASSOCIATE_TYPE_ANIMALCOMPANION);
//        JumpAssociate(oClicker, oTarget, ASSOCIATE_TYPE_DOMINATED);
//        JumpAssociate(oClicker, oTarget, ASSOCIATE_TYPE_FAMILIAR);
//        JumpAssociate(oClicker, oTarget, ASSOCIATE_TYPE_HENCHMAN);
//        JumpAssociate(oClicker, oTarget, ASSOCIATE_TYPE_SUMMONED);
    }
}

void JumpAssociate(object oMaster, object oTarget, int iAssociateType)
{
    int iCounter = 1;
    object oCursor = GetAssociate(iAssociateType, oMaster, iCounter++);

    while(GetIsObjectValid(oCursor) == TRUE)
    {
        AssignCommand(oCursor, ActionJumpToObject(oTarget));
        oCursor = GetAssociate(iAssociateType, oMaster, iCounter++);
    }
}
