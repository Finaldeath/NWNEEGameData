/*
The main purpose of this AI is to ensure that the workers run in terror
from the evil succubus.
*/

#include "nw_i0_generic"
#include "x0_i0_spells"
#include "x2_inc_switches"

void Yell(object oIntruder)
{
    string s;
    int n = d8();
    if      (n == 1) s = "Help!";
    else if (n == 2) s = "Run away!";
    else if (n == 3) s = "Oh no!";
    else if (n == 4) s = "Save us!";
    else if (n == 5) s = "Argh!";
    else if (n == 6) s = "We're all going to die!";
    else if (n == 7) s = "It's after me! Help!";
    else if (n == 8) s = "Run for your lives, boys!";
    SpeakString(s, TALKVOLUME_SHOUT);
}

void Scream(object oIntruder)
{
    string s;
    int n = d4();
    if      (n == 1) s = "c_behold_atk1";
    else if (n == 2) s = "c_behold_atk2";
    else if (n == 3) s = "c_behold_bat1";
    else if (n == 4) s = "c_behold_bat2";
    PlaySound(s);
}

void Panic(object oIntruder)
{
    int nAction = d10();
    if (nAction == 1)
    {
        // fight for your life
        ActionAttack(oIntruder);
    }
    else if (nAction == 2)
    {
        // do nothing
    }
    else if (nAction <= 4)
    {
        // yell like a fool
        Yell(oIntruder);
        Scream(oIntruder);
    }
    else
    {
        // run away!
        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR), OBJECT_SELF, 3.0);
        ActionMoveAwayFromObject(oIntruder, TRUE, 20.0);
    }
}

void main()
{
    object oIntruder = GetCreatureOverrideAIScriptTarget();

    ClearCreatureOverrideAIScriptTarget();
    SetCreatureOverrideAIScriptFinished();

    if (GetIsObjectValid(oIntruder) == FALSE)
        oIntruder = bkAcquireTarget();

    if (GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }

    if (GetIsObjectValid(oIntruder) && GetIsDead(oIntruder) == TRUE)
    {
        return;
    }

    if (!GetIsEnemy(oIntruder))
    {
        return;
    }

    if (GetTag(oIntruder) == "ks_dig_suc")
    {
        return;
    }

    if (__InCombatRound() == TRUE)
    {
        return;
    }

    __TurnCombatRoundOn(TRUE);

    if(GetIsObjectValid(oIntruder))
    {
        if (GetLocalInt(OBJECT_SELF, "UNDEAD") == 0)
        {
            if (GetRacialType(oIntruder) == RACIAL_TYPE_OUTSIDER ||
                GetRacialType(oIntruder) == RACIAL_TYPE_UNDEAD ||
                GetLocalInt(oIntruder, "UNDEAD") != 0)
            {
                // we don't like to fight scary things
                Panic(oIntruder);
            }
            else
            {
                // we don't run from the PC if he attacks us
                ActionAttack(oIntruder);
            }
        }
        else
        {
            // we're undead, so attack
            ActionAttack(oIntruder);
        }
    }
     __TurnCombatRoundOn(FALSE);
}
