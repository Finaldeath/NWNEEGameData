// January 2006
// B W-Husey
// The ball on the stand: when used it drains blood from the user up to half their hit points
// Dependant on the HP drained, it creates undead at the spawn
// locations.

#include "cu_functions"

void main()
{
      object oPC = GetLastUsedBy();
      //Deal with visual and sound of starting up the artifact
      ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
      object oSound = GetNearestObjectByTag("Playsound");
      SoundObjectPlay(oSound);
      DelayCommand(15.0,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
      // Declare the principal players
        object oTarget = GetObjectByTag("PFULAltar");
        object oTarget2 = GetObjectByTag("PFULMaker1");
        object oTarget3 = GetObjectByTag("PFULMaker2");
        location lSpawn1 = GetLocation(GetWaypointByTag("WP_PFULSpawn5"));
        location lSpawn2 = GetLocation(GetWaypointByTag("WP_PFULSpawn6"));
        effect eSpawn = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        effect eGorge = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        //Check and drain the user.
        int nDrain = GetCurrentHitPoints(oPC)/2;
        effect E1 = EffectDamage(nDrain,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_PLUS_THREE);
        effect E2 = EffectVisualEffect(VFX_IMP_DEATH);
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,E1,oPC));
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,E2,oPC));
        //Decide what to spawn
        string sCreature;
        if (nDrain<10) sCreature = "nw_ghoul";
        else if (nDrain <20) sCreature = "nw_wight";
        else if (nDrain <25) sCreature = "nw_ghast";
        else if (nDrain <35) sCreature = "nw_wraith";
        else if (nDrain <45) sCreature = "nw_spectre";
        else sCreature = "nw_bodak";

        // Start the visuals
        effect eBeam = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_CHEST);
        effect eBeam2 = EffectBeam(VFX_BEAM_LIGHTNING, oTarget, BODY_NODE_CHEST);
        DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget,4.0));
        DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eGorge,oTarget));
        DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam2, oTarget2,3.0));
        DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam2, oTarget3,3.0));
        DelayCommand(4.0,ActionCreateCreature(sCreature,lSpawn1,"Summon"));
        DelayCommand(4.0,ActionCreateCreature(sCreature,lSpawn2,"Summon"));
        DelayCommand(4.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn1));
        DelayCommand(4.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn2));
}
