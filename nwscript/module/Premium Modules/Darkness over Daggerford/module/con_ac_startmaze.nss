//::///////////////////////////////////////////////
//:: FileName con_ac_startmaze
//:: Cell door opens and countdown starts for maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
#include "x0_i0_petrify"

void ahcRemove(object o7)
{
effect eLoop7=GetFirstEffect(o7);
while (GetIsEffectValid(eLoop7))
   {
   if (GetEffectType(eLoop7)== EFFECT_TYPE_VISUALEFFECT)
         RemoveEffect(o7, eLoop7);
      eLoop7=GetNextEffect(o7);
   }
}

void ahcInvisible(object o1)
{
effect eI = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eI,o1);
}


void ahcJonas2(object oJ, object oJ2, object oPC)
{
    if (GetTag(GetArea(oPC)) != "ar0704_chasemaze") return;

    SetCreatureAppearanceType(oJ2, APPEARANCE_TYPE_WEREWOLF);
    //ahcInvisible(oJ2);
    //ahcInvisible(oJ);
    //AssignCommand(oJ2, ActionJumpToObject(oPC));
    AssignCommand(oJ2, ActionForceFollowObject(oPC,4.0));
    SoundObjectPlay(GetObjectByTag("ac_snd_werewolf"));
    DelayCommand(10.0,SoundObjectStop(GetObjectByTag("ac_snd_werewolf")));
    DestroyObject(GetObjectByTag("ac_snd_werewolf"), 10.0);

    //DelayCommand(5.0, ahcRemove(oJ2));
    DelayCommand(5.1,ChangeToStandardFaction(oJ2,STANDARD_FACTION_HOSTILE));
    DelayCommand(5.2,SetIsTemporaryEnemy(oPC, oJ2));
    //DelayCommand(5.3,AssignCommand(oJ2, ActionAttack(oPC)));
    DelayCommand(5.1,SoundObjectPlay(GetObjectByTag("ac_snd_werewolf")));
    //DelayCommand(5.5,DetermineCombatRound(oPC));
    DelayCommand(5.0,AssignCommand(oJ, ActionJumpToObject(oPC)));
    DelayCommand(5.0,AssignCommand(oJ, ActionForceFollowObject(oPC,4.0)));
    }

void main()
{
object oJ = GetObjectByTag("ac_jonas1");
object oJ2 = GetObjectByTag("ac_jonas2");
object oPC = GetPCSpeaker();
object oD = GetObjectByTag("ac_dr_maze_pc");
float fC = 1.0;
float fD = 2.5;

SetLocalInt(oJ, "no_banter", 1);
SetLocked(oD,FALSE);
AssignCommand(oD, ActionOpenDoor(oD));
AssignCommand(oJ, SpeakString("20", TALKVOLUME_SHOUT));
FloatingTextStringOnCreature("20", oPC);

// the henchmen wake up now
object oRaegen = GetObjectByTag("pm_raegen");
RemoveEffectOfType(oRaegen, EFFECT_TYPE_SILENCE);
RemoveEffectOfType(oRaegen, EFFECT_TYPE_SLEEP);
object oPurfbin = GetObjectByTag("ks_purfbin");
RemoveEffectOfType(oPurfbin, EFFECT_TYPE_SILENCE);
RemoveEffectOfType(oRaegen, EFFECT_TYPE_SLEEP);

/*DelayCommand(fC, AssignCommand(oJ, SpeakString("19", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("19", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("18", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("18", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("17", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("17", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("16", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("16", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("15", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("15", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("14", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("14", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("13", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("13", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("12", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("12", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("11", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("11", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("10", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("10", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("9", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("9", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("8", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("8", oPC));
fC = fC + fD;*/

DestroyObject(GetObjectByTag("ac_maze_cages_pc1"));
DestroyObject(GetObjectByTag("ac_maze_cages_pc2"));


DelayCommand(fC, AssignCommand(oJ, SpeakString("7", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("7", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("6", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("6", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("5", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("5", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("4", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("4", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("3", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("3", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("2", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("2", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("1", TALKVOLUME_SHOUT)));
DelayCommand(fC, FloatingTextStringOnCreature("1", oPC));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, SpeakString("Your head will make a nice trophy.", TALKVOLUME_SHOUT)));
DelayCommand(fC, SetLocalInt(oJ, "no_banter", 0));
fC = fC + fD;
DelayCommand(fC, AssignCommand(oJ, ClearAllActions()));
fC = fC + fD;
DelayCommand(fC, ahcJonas2(oJ, oJ2, oPC));
}
