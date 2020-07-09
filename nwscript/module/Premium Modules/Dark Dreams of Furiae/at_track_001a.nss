// fade party to black
#include "ddf_util"


void DoDamageToPCFromTrace(object oPC)
{
    int nHealth = d6() + d6();// GetCurrentHitPoints(oPC) - 1;

    // ensure that you can't kill the pc here.
    int iCurrentHP = GetCurrentHitPoints(oPC);
    if(nHealth >= iCurrentHP) nHealth = iCurrentHP - 1;

    //debug("-- damage: " + IntToString(nHealth));

    // Declare the damage - visuals, however, are not automatic.
    effect eOuch = EffectDamage(nHealth, DAMAGE_TYPE_BLUDGEONING);

    //PlaySound("cb_ht_fleshleth2");

    int iGender = GetGender(oPC);
    if(iGender == GENDER_MALE)
    {
        //PlaySound("vs_ndruidm1_hit1");
    }
    else
    {
       // PlaySound("vs_ndruidf1_hit1");
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eOuch, oPC);
}

void main()
{
    object oPC = GetPCSpeaker();

    FadeToBlack(oPC);
    //PartyFadeToBlack(FALSE);

    PlaySound("cb_sw_blunt1");
    object oNPC = GetObjectByTag("ddf_trace");

    DelayCommand(2.0, AssignCommand(oNPC, DoDamageToPCFromTrace(oPC)));

    //DelayCommand(2.0, PartyFadeFromBlack(FALSE));
    DelayCommand(2.0, FadeFromBlack(oPC));

}

