//:://////////////////////////////////////////////////
//:: dla_hrs_ondeath
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnDeath event handler for horses

  OnDeath handler for henchmen ONLY. Causes them to respawn at
  (in order of preference) the respawn point of their master
  or their own starting location.

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////
//:: Updated On: June 06, 2005

#include "x0_i0_henchman"
#include "dla_i0_horse"

void main()
{
    int bIsHorse = DLA_GetIsDLAHorse(OBJECT_SELF);
    //Gale April 21th 2006:
    if (bIsHorse)
    {
         SetPlotFlag(
                CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", GetLocation(OBJECT_SELF)), TRUE);

         if (DLA_GetIsTied(OBJECT_SELF))
                DLA_UntieHorse(OBJECT_SELF);
    }

    //if a horse henchman, keep going for code. If just a horse, refer to the
    /*appropriate AI file.
    if(GetAssociateType(OBJECT_SELF) != ASSOCIATE_TYPE_HENCHMAN || !DLA_GetIsDLAHorse(OBJECT_SELF))
    {
        ExecuteScript("nw_c2_default7", OBJECT_SELF);
        return;
    } */

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
    return;
    // Handle a bunch of stuff to keep us from running around,
    // dying again, etc.
    //PreRespawnSetup();

    // Call for healing
    //DelayCommand(0.5, VoiceHealMe(TRUE));

    // Get our last master
    object oPC = GetLastMaster();
    object oSelf = OBJECT_SELF;

    // Clear dialogue events
    ClearAllDialogue(oPC);
    ClearAllActions();

    // BK Feb 2003: Make the henchman rejoin you so that you can heal them
    //DelayCommand(0.1, DLA_SetHenchman(oPC, oSelf));

    // Start the respawn checking
    //RaiseForRespawn(oPC);

    // make sure proper despawn
    // bring back long enough to properly drop inventory
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oSelf);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(10),oSelf);
    //DLA_DespawnPaladinMount(oSelf);
    // make sure proper despawn
}


