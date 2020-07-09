//Visual Effects area heartbeat script for Zhentil Keep warzone

#include "hf_in_plot"

#include "inc_ktgate"

void FireballAtLocation(location lTarget)
{
    float fDist;
    float fDelay;

    object oLauncher = GetNearestObjectByTag("KTWZFireball", GetFirstPC());

    effect eVFX = EffectVisualEffect(VFX_FNF_FIREBALL);

    fDist = GetDistanceBetweenLocations(GetLocation(oLauncher), lTarget);
    fDelay = fDist/(3.0 * log(fDist) + 2.0);

    AssignCommand(oLauncher,
        ActionCastFakeSpellAtLocation(SPELL_FIREBALL, lTarget, PROJECTILE_PATH_TYPE_BALLISTIC));
    DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lTarget));
}

void main()
{
    int nRand;

    object oPC = GetFirstPC();
    object oWP;

    effect eVFX;

    //Stop executing the script if player leaves area
    if(PlotLevelGet("ZKWarVFX") == 1)
    {
        //Player is in area but has not transitioned from boat to warzone
        if(PlotLevelGet("ZKWarTransitioned") == 0)
        {
            DelayCommand(RoundsToSeconds(1), ExecuteScript("exe_tm_zkwarvfx", OBJECT_SELF));
            return;
        }
    }
    else
    {
        return;
    }

    //Don't add to combat confusion with spell effects!
    if(GetIsInCombat(oPC))
    {
        DelayCommand(RoundsToSeconds(1), ExecuteScript("exe_tm_zkwarvfx", OBJECT_SELF));
        return;
    }

    nRand = d20();

    switch(nRand)
    {
        //Lightning bolt on nearby rooftop
        case 1:
            eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
            oWP = GetNearestObjectByTag("WP_ZK2_ROOFTOP", oPC, 1);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP));
        break;
        //Lightning bolt on random rooftop
        case 2:
            eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
            oWP = GetNearestObjectByTag("WP_ZK2_ROOFTOP", oPC, d6());
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP));
        break;
        //Lightning bolt near player
        case 3:
            eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetRandomMissLocation(oPC));
        break;
        //Explosion in nearby building
        case 4:
            eVFX = EffectVisualEffect(VFX_FNF_FIREBALL);
            oWP = GetNearestObjectByTag("WP_ZK2_FIRE", oPC, d3());
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP));
        break;
         //Explosion in nearest building
        case 5:
            eVFX = EffectVisualEffect(VFX_FNF_FIREBALL);
            oWP = GetNearestObjectByTag("WP_ZK2_FIRE", oPC, 1);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP));
        break;
        //Prot from evil effect nearby
        case 6:
            eVFX = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetRandomMissLocation(oPC));
        break;
        //Implosion effect nearby
        case 7:
            eVFX = EffectVisualEffect(VFX_FNF_IMPLOSION);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetAheadLocation(oPC));
        break;
        case 8:
            eVFX = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
        break;
        //Red beam effect near PC
        case 9:
            eVFX = EffectVisualEffect(VFX_IMP_HARM);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetRandomMissLocation(oPC));
        break;
        //Fiery beam effect nearby
        case 10:
            eVFX = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetRandomMissLocation(oPC));
        break;
        //Unsummon effect
        case 11:
            eVFX = EffectVisualEffect(VFX_IMP_UNSUMMON);
            oWP = GetNearestObjectByTag("WP_ZK2_RUNES", oPC, d2());
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP));
        break;
        //Fireball nearest rooftop
        case 12: case 13: case 14:
            oWP = GetNearestObjectByTag("WP_ZK2_ROOFTOP", oPC, d2());
            FireballAtLocation(GetLocation(oWP));
        break;
        //Fireball nearby rooftop
        case 15: case 16:
            oWP = GetNearestObjectByTag("WP_ZK2_ROOFTOP", oPC, d4());
            FireballAtLocation(GetLocation(oWP));
        break;
        //Fireball near PC
        case 17: case 18:
            FireballAtLocation(GetRandomMissLocation(oPC));
        break;
        //Fireball nearby house
        case 19: case 20:
            oWP = GetNearestObjectByTag("WP_ZK2_FIRE", oPC, d3());
            FireballAtLocation(GetLocation(oWP));
        break;
    }

    DelayCommand(RoundsToSeconds(1), ExecuteScript("exe_tm_zkwarvfx", OBJECT_SELF));
}
