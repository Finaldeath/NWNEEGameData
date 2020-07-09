// on enter script for the lizardfolk village
// .. the dragon will come running if enough lizardfolk are dead
// .. (see c4_lizardman_de script)

#include "hf_in_spawn"
#include "hf_in_cutscene"
#include "x0_i0_position"
#include "inc_polymorph"
#include "nw_i0_generic"

// returns a location directly in front of the target
location GetFrontLocation(object oTarget)
{
    float fDir = GetFacing(oTarget);
    float fAngleOpposite = GetOppositeDirection(fDir);
    return GenerateNewLocation(oTarget, DISTANCE_SHORT, fDir, fAngleOpposite);
}

// --------------------------------------------------------------------------

// returns true if an object contains this tag
int ContainsItem(object oChest, string sTag)
{
    object oEggs = GetFirstItemInInventory(oChest);
    while (GetIsObjectValid(oEggs))
    {
        if (GetTag(oEggs) == sTag)
        {
            return(TRUE);
        }
        oEggs = GetNextItemInInventory(oChest);
    }
    return(FALSE);
}

// are the eggs hidden in the chief's hut?
int EggsHidden()
{
    // can't find the eggs if the chief is dead
    if (GetLocalInt(GetModule(), "nDeadLizardfolkChief") == 1)
    {
        return(FALSE);
    }

    // see if the eggs are lying on the ground in the chief's hut
    object oEggs = GetObjectByTag("ks_dragon_eggs");
    object oWP1 = GetNearestObjectByTag("WP_AR1902_ENTER", oEggs);
    if (GetIsObjectValid(oWP1))
    {
        return(TRUE);
    }

    // see if the eggs are inside a chest in the chief's hut
    object oWP = GetWaypointByTag("WP_AR1902_ENTER");
    object oArea = GetArea(oWP);
    object oChest = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oChest))
    {
        if (GetObjectType(oChest) == OBJECT_TYPE_PLACEABLE)
        {
            if (GetHasInventory(oChest))
            {
                if (ContainsItem(oChest, "ks_dragon_eggs"))
                {
                    return(TRUE);
                }
            }
        }
        oChest = GetNextObjectInArea(oArea);
    }

    // didn't find anything
    return(FALSE);
}

// --------------------------------------------------------------------------

// the dragon flies in and attacks after a few seconds of circling the village
void DoSummonDragon(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR1900_DRAGON_START");
    location lLoc = GetLocation(oWP);
    location lPlayer = GetFrontLocation(oPC);
    object oDragon = CreateObject(OBJECT_TYPE_CREATURE, "ks_thuraskulusk1", lLoc, TRUE);
    AdjustReputation(oPC, oDragon, -100);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDisappearAppear(lPlayer), oDragon, 6.0);
}

// summon the dragon to the village
void SummonDragon(object oPC)
{
    // flag that the dragon can't be summoned again
    object oMod = GetModule();
    SetLocalInt(oMod, "nDeadLizardfolkCount", -1);

    // blow the horn that summons the dragon
    object oWP = GetWaypointByTag("WP_AR1900_AR1800_EXIT");
    object oHorn = GetNearestObjectByTag("ks_snd_horn2", oWP);
    if (GetIsObjectValid(oHorn))
    {
        FloatingTextStringOnCreature("You hear a loud horn blowing.", oPC);
        SoundObjectPlay(oHorn);
        DelayCommand(4.0, FloatingTextStringOnCreature("You hear wings flapping overhead.", oPC));
        DelayCommand(4.0, SoundObjectPlay(oHorn));
    }

    // the dragon hears the horn and appears
    DoSummonDragon(oPC);
}

// --------------------------------------------------------------------------

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // should we repoly?
        string sPreviousArea = GetLocalString(oPC, "sWM_PreviousArea");
        if (FindSubString(sPreviousArea, "ar1800") >= 0 ||
            FindSubString(sPreviousArea, "ar1900") >= 0)
        {
            PolymorphAreaEnter(oPC, TRUE);
        }
        else
        {
            PolymorphAreaEnter(oPC, FALSE);
        }

        // handle the standard spawns for this area
        SpawnEnter(oPC);

        // make sure that the horn sound isn't blowing
        object oWP = GetWaypointByTag("WP_AR1900_AR1800_EXIT");
        object oHorn = GetNearestObjectByTag("ks_snd_horn2", oWP);
        SoundObjectStop(oHorn);

        // check if the dragon should appear
        object oMod = GetModule();
        int nCount = GetLocalInt(oMod, "nDeadLizardfolkCount");
        if (nCount >= 0)
        {
            if (EggsHidden())
            {
                // dragon appears and kills saslick
                // .. (after this the dragon can't be summoned again)
                CutscenePlay(oPC, "mv_ar1900_2");
                SetLocalInt(oMod, "nDeadLizardfolkCount", -1);
            }
            else
            {
                // dragon appears and fights the player
                if (nCount >= 2)
                {
                    SummonDragon(oPC);
                }
            }
        }
    }

    // no water in this area!
    SetFootstepType(FOOTSTEP_TYPE_DEFAULT, oPC);
}
