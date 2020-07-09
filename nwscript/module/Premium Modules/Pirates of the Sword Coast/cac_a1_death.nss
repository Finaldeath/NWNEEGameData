//::///////////////////////////////////////////////
//:: cac_a1_death
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has lost to Garm in the arena through
    failing a save in conversation.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////

void RemoveInvis (object oPC);
void main()
{
    object oArea = GetObjectByTag("a1_trogarena");
    object oFighter = GetLocalObject(oArea, "A1_CURRFIGHTER");
    object oGarm = GetObjectByTag("a1_garmclone");
    object oClone = GetObjectByTag("A1PC_CLONE");
    object oPC;

    effect eDeath = EffectDeath();

    AssignCommand(oGarm, ActionMoveToObject(oClone, FALSE, 0.0f));
    oPC = GetFirstObjectInArea(oArea);

    while (GetIsObjectValid(oPC) == TRUE)
    {
        if (oPC == oFighter)
        {
            FadeToBlack(oPC);
            DelayCommand(2.0f, SetCutsceneMode(oPC, FALSE));
            DelayCommand(2.0f, RemoveInvis(oPC));
            DelayCommand(2.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oFighter));
        }
        else if ((GetLocalInt(oPC, "A1_WATCHING_FIGHT") == TRUE)
          && (GetIsPC(oPC) == TRUE))
        {
            ExecuteScript("exe_a1nwtchfight", oPC);
        }

        oPC = GetNextObjectInArea(oArea);
    }

    DestroyObject(oClone, 2.0f);
}

void RemoveInvis (object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect) == TRUE)
    {
        if(GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
        {
            DelayCommand(0.1f, RemoveEffect(oPC, eEffect));
        }

        eEffect = GetNextEffect(oPC);
    }
}
