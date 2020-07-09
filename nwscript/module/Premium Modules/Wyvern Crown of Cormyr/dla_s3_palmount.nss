//::///////////////////////////////////////////////
//:: dla_s3_palmount.nss
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

Summons to the Paladin a faithful, magical beast--his warhorse mount.

The beast is more powerful as the paladin gets more powerful. See 3.5E PHB for
details...

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 03, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horse"
#include "dla_i0_time"


void main()
{
    int iPaladinLevels = GetLevelByClass(CLASS_TYPE_PALADIN);
    object oPC = OBJECT_SELF;
    object oPalHorse;
    string sHorseTemplate;
    effect eVFX;
    int nTime;
    //ensure they have at least 5 levels in the class.
    //and they do not already have a paladin mount summoned (checks against 5 henchmen positions).
    //Gale May 19, 2006: now keeps function results on variable to avoid calling multiple times
    //Added check for interior areas, to don't allow summoning of horse.
    int bHasPalMount         = DLA_GetHasPaladinMount(oPC);
    int bIsMounted           = DLA_GetIsMounted(oPC);
    int bIsOnInteriorAllowed = DLA_GetIsInteriorAllowed(GetArea(oPC));

    if((iPaladinLevels >= 5)
        && (!bHasPalMount)&&(!bIsMounted) && (bIsOnInteriorAllowed))
    {
        //determine paladin horse template to use.
        if(iPaladinLevels < 8) //levels 5-7
        {
            sHorseTemplate = "dla_palhorse1";
        }
        else if(iPaladinLevels < 11) //levels 8-10
        {
            sHorseTemplate = "dla_palhorse2";
        }
        else if(iPaladinLevels < 15) //levels 11-14
        {
            sHorseTemplate = "dla_palhorse3";
        }
        else if(iPaladinLevels > 14) //levels 15+
        {
            sHorseTemplate = "dla_palhorse4";
        }
        eVFX=EffectVisualEffect(VFX_FNF_SUMMON_PAL_MOUNT);
        oPalHorse = CreateObject(OBJECT_TYPE_CREATURE, sHorseTemplate, GetLocation(oPC), TRUE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFX,GetLocation(oPalHorse));

        nTime=DLA_GetAbsoluteHour();
        nTime=nTime+(iPaladinLevels*2); // 2 hours per paladin level

        SetLocalInt(oPalHorse,"nDespawnHour",nTime);
        SetLocalInt(oPC,"nPalHorseDespawnTime",nTime);
        SetLocalObject(oPC,"oAssigned",oPalHorse);
        SetLocalObject(oPalHorse,"oAssigned",oPC);

        DLA_SetHenchman(oPalHorse, oPC,TRUE,TRUE);


    }
    //Deva Winblood - May 15, 2006:
    //checks / feedback if player is not able to summon mount
    else if (bHasPalMount)
    { // already has a paladin mount
      FloatingTextStringOnCreature("You already have a Paladin Mount!",oPC);
    } // already has a paladin mount
    else if (bIsMounted)
    { // cannot call a paladin mount while mounted
      FloatingTextStringOnCreature("You cannot summon a Paladin Mount while mounted!",oPC);
    } // cannot call a paladin mount while mounted
    else if (!bIsOnInteriorAllowed)
    { // cannot call a paladin mount while mounted
      FloatingTextStringOnCreature("You cannot summon a Paladin Mount on this area!",oPC);
    } // cannot call a paladin mount while mounted
    else
    { // insufficient level
      FloatingTextStringOnCreature("Paladin Mount requires 5 levels in Paladin!",oPC);
    } // insufficient level
}

