//::///////////////////////////////////////////////
//:: Attack on End of Conversation
//:: NW_D1_AttOnEnd02
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script makes an NPC attack the person
    they are currently talking with.  This will
    only make the single character hostile not
    their entire faction.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 7, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
    object oMe = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(GetWaypointByTag("WP_WLFinal2"));
    effect eSpawn = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    FloatingTextStringOnCreature("*Sequencer Fired*",oMe,FALSE);
    ActionCastSpellAtObject(SPELL_DISPLACEMENT,oMe,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD,oMe,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ActionCastSpellAtObject(SPELL_PREMONITION,oMe,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    ActionCastSpellAtObject(SPELL_ANIMATE_DEAD,oMe,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    object oCurst1 = CreateObject(OBJECT_TYPE_CREATURE,"curst004",lLoc);
    object oCurst2 = CreateObject(OBJECT_TYPE_CREATURE,"curst004",lLoc);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eSpawn,GetLocation(oCurst1));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eSpawn,GetLocation(oCurst2));
    DelayCommand(0.5,SetIsTemporaryEnemy(oPC));
    DelayCommand(0.5,SetIsTemporaryEnemy(oPC,oCurst1));
    DelayCommand(0.5,SetIsTemporaryEnemy(oPC,oCurst2));
    DelayCommand(1.1,DetermineCombatRound());
}

