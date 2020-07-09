// November 2005
// B W-Husey
// This cutscene freezes the PC while the agent makes their escape - sets plot variable and journal
// Changed to teleport out the NPC instead.

#include "cu_cutscenes"
#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    if (GetLocalInt(oPC,"nFrozen")==0)
    {
        object oBaddy = GetNearestObjectByTag("Agent");
        /*
        effect eStuck = EffectParalyze();
        effect eVis = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
        ClearForCut(oPC); // Function does all the cleaning up needed before the cutscene starts
        DelayCommand(12.5,SetCutsceneMode(oPC,FALSE)); //To stop us getting stuck. Remove when done.
        SetCutsceneMode(oPC,TRUE);
        AssignCommand(oBaddy,ActionCastFakeSpellAtObject(SPELL_ISAACS_LESSER_MISSILE_STORM,oPC));
        DelayCommand(1.0,EffectAll(oPC, eStuck, DURATION_TYPE_TEMPORARY, 10.0)); //paralyse everyone
        DelayCommand(1.0,EffectAll(oPC, eVis, DURATION_TYPE_TEMPORARY, 10.0)); //paralyse everyone
        AssignCommand(oBaddy,DelayCommand(4.0,ActionMoveToObject(GetWaypointByTag("WP_AgentM1"),TRUE)));
        AssignCommand(oBaddy,DelayCommand(4.3,SpeakOneLinerConversation("fools")));
        AssignCommand(oBaddy,DelayCommand(6.0,ActionMoveToObject(GetObjectByTag("TSHDoorDown"),TRUE)));
        */
        effect eTeleport = EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE);
        effect eTeleport2 = EffectVisualEffect(VFX_IMP_DISPEL);
        effect eTeleport3 = EffectVisualEffect(SPELL_SUMMON_CREATURE_III);
        AssignCommand(oBaddy,ClearAllActions());
        AssignCommand(oBaddy,DelayCommand(0.1,SpeakOneLinerConversation("fools")));
        AssignCommand(oBaddy,DelayCommand(0.2,PlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,1.5)));
        DelayCommand(0.3,SetCommandable(FALSE,oBaddy));
        DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_INSTANT,eTeleport,oBaddy));
        DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_INSTANT,eTeleport2,oBaddy));
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eTeleport3,oBaddy));
        SetLocalInt(oPC,"nFrozen",1);
        AllParty("nSpy",oPC,9);
        AddJournalQuestEntry("Catch",30,oPC);  //To Catch a Spy journal entry
        DestroyObject(oBaddy,1.6);
    }
}
