// February 2006
// B W-Husey
// PC cannot advance unless they wear a helm of the deep. Heartbeat script makes people drown if they don't wear the helmet
// Updated 28th March 2006, with Georg Zoeller's logic
#include "cu_functions"

// Drown logic
void _DoDrown(object oTarget)
{
    effect eDamage;
    //------------------------------------------------------------------
    // basic validation
    //------------------------------------------------------------------
    if (!GetIsObjectValid(oTarget))
    {
      return;
    }
    //------------------------------------------------------------------
    // Ignore racial types immune to this kind of "hassle"
    //------------------------------------------------------------------
    int nRace = GetRacialType(oTarget);
    if (nRace == RACIAL_TYPE_CONSTRUCT || nRace == RACIAL_TYPE_UNDEAD ||
        nRace == RACIAL_TYPE_DRAGON || nRace == RACIAL_TYPE_HUMANOID_REPTILIAN ||
        nRace == RACIAL_TYPE_OOZE)
    {
        return;
    }
    //------------------------------------------------------------------
    // Handle elementals
    //------------------------------------------------------------------
    if (nRace == RACIAL_TYPE_ELEMENTAL)
    {
        int nAppearance = GetAppearanceType(oTarget);

        if (nAppearance == APPEARANCE_TYPE_ELEMENTAL_FIRE || nAppearance == APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER)
        {
             //---------------------------------------------------------
             //fire elementals don't like water at all. Summoning them will do no good
             //---------------------------------------------------------
             eDamage = EffectDamage(d20(4)+20, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
        }
        else if (nAppearance == APPEARANCE_TYPE_ELEMENTAL_WATER || nAppearance == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER)
        {
            //----------------------------------------------------------
            // Rules say water elementals heal.
            //----------------------------------------------------------
            eDamage = EffectHeal(d6(2));
        }
        else
        {
            //----------------------------------------------------------
            // other elementals don't give a damn.
            //----------------------------------------------------------
            return;
        }
    }
    //------------------------------------------------------------------
    // All other racial types
    //------------------------------------------------------------------
    else
    {
          //------------------------------------------------------------
          // Normal damage is d4+2. Damage power energy means unresistable
          //------------------------------------------------------------
          eDamage = EffectDamage(d4()+2, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
    }
    //-----------------------------------------------------------------
    // No damage if you have the helm of the deep
    //-----------------------------------------------------------------
    object oHelm = GetItemInSlot(INVENTORY_SLOT_HEAD,oTarget);
    if (GetIsObjectValid(oHelm))
    {
       if (GetTag(oHelm) == "HelmoftheDeep")
       {
            return;
       }
    }
    //-----------------------------------------------------------------
    // Do the Damage
    //-----------------------------------------------------------------
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
    //-----------------------------------------------------------------
    // Floaty
    //-----------------------------------------------------------------
    FloatingTextStringOnCreature(GetName(oTarget)+" is drowning!",oTarget,TRUE);
}

void main()
{
     //Make sure it's a non-DM PC in the area
     object oPC = GetFirstPC();
     while (GetIsObjectValid(oPC))
     {
        if (GetIsDefPC(oPC))
           break;
        oPC = GetNextPC();
     }

    // check area of PC and area of drowning match
    if (GetArea(oPC) != OBJECT_SELF) return; //else quit this script
    if (GetLocalInt(OBJECT_SELF,"nDrownArea")==1) // don't run continuously.
    {
        //Set variables up
        object oPC = GetFirstPC();
        object oHench1 = ReturnHenchman(oPC,1);
        object oHench2 = ReturnHenchman(oPC,2);
        object oHench3 = ReturnHenchman(oPC,3);
        object oAssoc1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
        object oAssoc2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
        object oAssoc3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);
        object oHelm1 = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
        object oHelm2 = GetItemInSlot(INVENTORY_SLOT_HEAD,oHench1);
        object oHelm3 = GetItemInSlot(INVENTORY_SLOT_HEAD,oHench2);
        object oLHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
        object oRHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        object oRHand2 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oHench1);
        object oRHand3 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oHench2);
        //Remove illegal items
        if (GetTag(oLHand) == "NW_TORCH") AssignCommand(oPC,DLA_ForceUnequip(oLHand));
        if (GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oHench1)) == "NW_TORCH") AssignCommand(oHench1,DLA_ForceUnequip(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oHench1)));
        if (GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oHench2)) == "NW_TORCH") AssignCommand(oHench2,DLA_ForceUnequip(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oHench2)));
        if (GetWeaponRanged(oRHand)) {AssignCommand(oPC, DLA_ForceUnequip(oRHand)); FloatingTextStringOnCreature("Ranged weapons are useless underwater",oPC);}
        if (GetWeaponRanged(oRHand2)) {AssignCommand(oHench1, DLA_ForceUnequip(oRHand2)); FloatingTextStringOnCreature("Ranged weapons are useless underwater",oHench1);}
        if (GetWeaponRanged(oRHand3)) {AssignCommand(oHench2, DLA_ForceUnequip(oRHand3)); FloatingTextStringOnCreature("Ranged weapons are useless underwater",oHench2);}
        //Handle drowning - drown anyone/thing without a Helm of the Deep (associates, followers, etc)
        // except immune race followers
        //Apply the drowning check
        _DoDrown(oPC);
        _DoDrown(oHench1);
        _DoDrown(oHench2);
        _DoDrown(oHench3);
        _DoDrown(oAssoc3);
        _DoDrown(oAssoc1);
        _DoDrown(oAssoc2);
}


//old (slower but working) version just in case
/*

        effect eDam = EffectDamage(d4()+2,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWENTY);
        if (GetTag(oHelm1)!= "HelmoftheDeep")
        {
            SendMessageToPC(oPC,"You are drowning");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oPC);
        }
        if (GetTag(oHelm2)!= "HelmoftheDeep" && GetIsObjectValid(oHench1))
        {
            SendMessageToPC(oPC,GetName(oHench1)+" is drowning");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oHench1);
        }
        if (GetTag(oHelm3)!= "HelmoftheDeep" && GetIsObjectValid(oHench2))
        {
            SendMessageToPC(oPC,GetName(oHench2)+" is drowning");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oHench2);
        }
        if (GetIsObjectValid(oAssoc1) && RacialOK(oAssoc1))
        {
            SendMessageToPC(oPC,GetName(oAssoc1)+" is drowning");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oAssoc1);
        }
        if (GetIsObjectValid(oAssoc2) && RacialOK(oAssoc2))
        {
            SendMessageToPC(oPC,GetName(oAssoc2)+" is drowning");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oAssoc2);
        }
        if (GetIsObjectValid(oAssoc3) && RacialOK(oAssoc3))
        {
            SendMessageToPC(oPC,GetName(oAssoc3)+" is drowning");
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oAssoc3);
        }
*/


    }
    //*********debug lines*************
//    SendMessageToPC(GetFirstPC(),"Running HB");
//    SendMessageToPC(GetFirstPC(),"Active = "+IntToString(GetLocalInt(OBJECT_SELF,"nActive")));

/*
//Checks to see if this race can drown
int RacialOK(object oAssoc)
{
 if (GetRacialType(oAssoc)== RACIAL_TYPE_UNDEAD || GetRacialType(oAssoc)== RACIAL_TYPE_CONSTRUCT || GetRacialType(oAssoc)== RACIAL_TYPE_OOZE)
 return FALSE;
 return TRUE;
}


