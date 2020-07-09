// when enough important lizard folk die, the dragon comes running
// .. but will only appear in the village itself

#include "x0_i0_position"

// returns a location directly in front of the target
location GetFrontLocation(object oTarget)
{
    float fDir = GetFacing(oTarget);
    float fAngleOpposite = GetOppositeDirection(fDir);
    return GenerateNewLocation(oTarget, DISTANCE_SHORT, fDir, fAngleOpposite);
}

// the dragon appears and atacks
void DoSummonDragon(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR1900_DRAGON_START");
    location lLoc = GetLocation(oWP);
    location lPlayer = GetFrontLocation(oPC);
    object oDragon = CreateObject(OBJECT_TYPE_CREATURE, "ks_thuraskulusk1", lLoc, TRUE);
    AdjustReputation(oPC, oDragon, -100);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappearAppear(lPlayer), oDragon, 6.0);
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

// if the player is in the village, the dragon appears
// .. otherwise the onEnter script will make the dragon appear
void CheckSummonDragon(object oKiller)
{
    object oWP = GetNearestObjectByTag("WP_AR1900_AR1800_EXIT", oKiller);
    if (GetIsObjectValid(oWP))
    {
        // the player is in the village, so summon the dragon
        SummonDragon(oKiller);
    }
    else
    {
        // the player is in a hut, so they just hear the first horn blowing
        object oHorn = GetNearestObjectByTag("ks_snd_horn2", oKiller);
        if (GetIsObjectValid(oHorn))
        {
            object oPC = GetFirstPC();
            FloatingTextStringOnCreature("You hear a loud horn blowing outside.", oPC);
            SoundObjectPlay(oHorn);
        }
    }
}

void main()
{
    // increment the "dragon come now" counter
    object oMod = GetModule();
    int nCount = GetLocalInt(oMod, "nDeadLizardfolkCount");
    if (nCount >= 0)
    {
        SetLocalInt(oMod, "nDeadLizardfolkCount", ++nCount);
    }

    // summon the dragon
    if (nCount == 2)
    {
        object oKiller = GetLastKiller();
        CheckSummonDragon(oKiller);
    }

    // we have to know if the chief is dead (can't confront the dragon)
    if (GetTag(OBJECT_SELF) == "lizchief")
    {
        SetLocalInt(oMod, "nDeadLizardfolkChief", 1);
    }

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
}
