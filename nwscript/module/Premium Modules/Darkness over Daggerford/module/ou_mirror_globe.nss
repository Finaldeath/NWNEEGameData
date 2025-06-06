//::///////////////////////////////////////////////
//:: OnUse: Toggle Activate
//:: x2_plc_used_act
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Simple script to toggle the placeable animation
    state for placeables that support Activate and
    DeActivate Animations

    Placeables are best set to be DeActivated by
    default with this script.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////
//additions by Luspr 16th March 06
void main()
{
    if(GetLocalInt(GetModule(),"meta_quest")==1&&GetLocalInt(OBJECT_SELF,"off")!=1)
    {
        // * note that nActive == 1 does  not necessarily mean the placeable is active
        // * that depends on the initial state of the object
        //int nActive = GetLocalInt (OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE");
        // * Play Appropriate Animation
        //if (!nActive)
        //{
            //ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
       //}
        //else
        //{
        //ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        //}
        // * Store New State
        //SetLocalInt(OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE",!nActive);
        object oPC = GetLastUsedBy();

        if(GetIsPC(oPC))
        {
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(OBJECT_SELF, ActionStartConversation(oPC));
            SetLocalInt(OBJECT_SELF,"off",1);
        }
    }
    else
    {
        object oPC = GetLastUsedBy();
        if(GetIsPC(oPC))
        {
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(OBJECT_SELF, ActionStartConversation(oPC));
        }
    }
}
