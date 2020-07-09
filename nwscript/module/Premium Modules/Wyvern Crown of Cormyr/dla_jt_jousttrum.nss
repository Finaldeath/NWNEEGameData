//::///////////////////////////////////////////////
//:: dla_jt_jousttrum
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Make the trumpeters raise their horns and play a trumpet fanfare sound then
   prepare the riders and send them to their starting points.
*/
//:://////////////////////////////////////////////
//:: Created By: Dave Musser (Syrsnein)
//:: Created On: 1 March 2006
//:://////////////////////////////////////////////
/* Change History

 Date
 year/mm/dd | Author   | Change
 -----------+----------+--------------------------------------------------------
 2006/07/12  Syrsnein   Added the code to prepare the riders and send them to
                         their starting points
 */


#include "dla_i0_joust"

void dla_trumpet_play(object oTrumpetter, object oFanfare)
{
    AssignCommand(oTrumpetter, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM3, 1.0, 8.5));
    SoundObjectSetVolume(oFanfare, 127);
    DelayCommand(1.0, SoundObjectPlay(oFanfare));
    DelayCommand(15.0,SoundObjectStop(oFanfare));
}

void main()
{
    object oPC = GetEnteringObject();
    if (!GetLocalInt(oPC, DLA_VAR_JOUST_ON))
        return; //PC is not on joust, do nothing.

    float fCueTime = 0.0;

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC);

    // Stop background music and play fanfare!
    MusicBackgroundStop(GetArea(oPC));
    int n=0;
    object oTrumpetter = GetObjectByTag("dla_joust_trumpetter", n);
    object oFanfare = GetObjectByTag("dla_joust_fanfare", n);
    while (GetIsObjectValid(oTrumpetter))
    {
        // clear all actions
        AssignCommand(oTrumpetter, ClearAllActions());
        // blow trumpet
        dla_trumpet_play(oTrumpetter, oFanfare);
        // Get the next trumpeter
        n++;
        oTrumpetter = GetObjectByTag("dla_joust_trumpetter", n);
//        oFanfare = GetObjectByTag("dla_joust_fanfare", n);
    }

    // Get the opponent
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    DLA_JoustDebug("Player Setup Name: " + GetName(oPC));
    DLA_JoustDebug("Opp Setup Name: " + GetName(oOP));
    object oShield = GetLocalObject(oPC, DLA_VAR_JOUST_SHIELD);
    object oHelmet = GetLocalObject(oPC, DLA_VAR_JOUST_HELMET);
    object oOPShield = GetLocalObject(oOP, DLA_VAR_JOUST_SHIELD);
    object oOPHelmet = GetLocalObject(oOP, DLA_VAR_JOUST_HELMET);

    //Setup the Jousters
//    DelayCommand(fCueTime+=1.0, DLA_EquipJoustingItems(oPC, DLA_EQUIP_SHIELD));
//    DelayCommand(fCueTime+=0.1, DLA_EquipJoustingItems(oPC, DLA_EQUIP_HELM));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ActionEquipItem(oShield, INVENTORY_SLOT_LEFTHAND)));
    DelayCommand(fCueTime+=0.1, AssignCommand(oPC, ActionEquipItem(oHelmet, INVENTORY_SLOT_HEAD)));

    if (DLA_GetOpponentNumber(oPC)>8)
    {
        DelayCommand(fCueTime+=0.1, AssignCommand(oOP, ActionEquipItem(oOPShield, INVENTORY_SLOT_LEFTHAND)));
    }
    DelayCommand(fCueTime+=0.1, AssignCommand(oOP, ActionEquipItem(oOPHelmet, INVENTORY_SLOT_HEAD)));

    DelayCommand(fCueTime+=5.5, FadeToBlack(oPC,FADE_SPEED_FAST));

    //jumps pc to joust starting point
    DelayCommand(fCueTime+=1.2, AssignCommand(oPC, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT1")))));
    DelayCommand(fCueTime+=0.01, AssignCommand(oOP, ActionJumpToLocation(GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT1")))));
//    DelayCommand(2.0, FadeFromBlack(oPC));
}
