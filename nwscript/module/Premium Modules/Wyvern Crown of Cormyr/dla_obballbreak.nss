// January 2006
// B W-Husey
// The ball on the stand: The ball has been destroyed and releases power, making undead.

#include "cu_functions"

void main()
{
      object oPC = GetLastKiller();
      CreateItemOnObject("enchantingstone",OBJECT_SELF);
      CreateItemOnObject("enchantingstone",OBJECT_SELF);
      // Declare the principal players
        object oTarget = GetObjectByTag("PFULAltar");
        location lSpawn1 = GetLocation(GetWaypointByTag("WP_PFULSpawn7"));
        effect eSpawn = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        effect eGorge = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        //Check and drain the user.
        int nDrain = GetCurrentHitPoints(oPC)/2;
        effect E1 = EffectDamage(nDrain,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_PLUS_THREE);
        effect E2 = EffectVisualEffect(VFX_IMP_DEATH);
        effect E3 = EffectVisualEffect(VFX_FNF_IMPLOSION);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,E3,OBJECT_SELF);
        DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,E1,oPC));
        DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,E2,oPC));
        //Decide what to spawn
        string sCreature;
        if (nDrain<10) sCreature = "nw_ghoul";
        else if (nDrain <20) sCreature = "nw_wight";
        else if (nDrain <25) sCreature = "nw_ghast";
        else if (nDrain <35) sCreature = "nw_wraith";
        else if (nDrain <45) sCreature = "nw_spectre";
        else sCreature = "nw_shfiend";

        // Start the visuals
        effect eBeam = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_CHEST);
        effect eBeam2 = EffectBeam(VFX_BEAM_LIGHTNING, oTarget, BODY_NODE_CHEST);
        DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget,0.2));
        DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_INSTANT,eGorge,oTarget));
        DelayCommand(2.0,ActionCreateCreature(sCreature,lSpawn1,"Summon"));
        DelayCommand(2.0,ActionCreateCreature(sCreature,lSpawn1,"Summon"));
        DelayCommand(2.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSpawn, lSpawn1));

       //Alignment consequences of action
     if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD) AligXP("AligXP1break", oPC, "GOOD", 200, 2); //Apply to specific alignment
}
