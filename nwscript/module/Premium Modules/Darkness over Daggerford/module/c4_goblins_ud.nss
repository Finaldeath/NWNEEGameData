//heartbeat random actions and mutterings for combat goblins
//on perception attack

#include "nw_i0_plot"
#include "nw_i0_generic"

void GoblinChat();
void Attack(object oPC);
int GoHome();

void main()
{
    int nUserDef = GetUserDefinedEventNumber();
    int iRandom = d8();
    int iAnimation;
    switch(iRandom)
    {
        case 1: iAnimation = ANIMATION_FIREFORGET_PAUSE_BORED; break;
        case 2: iAnimation = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD; break;
        case 3: iAnimation = ANIMATION_LOOPING_TALK_LAUGHING; break;
        case 4: iAnimation = ANIMATION_LOOPING_PAUSE2; break;
        case 5: iAnimation = ANIMATION_FIREFORGET_TAUNT ; break;
        case 6: iAnimation = ANIMATION_LOOPING_PAUSE ; break;
        case 7: iAnimation = ANIMATION_FIREFORGET_DRINK; break;
        case 8: iAnimation = ANIMATION_LOOPING_TALK_FORCEFUL ; break;
    }

    if (nUserDef==1001) //heartbeat event
    {
        if (GetLocalInt(OBJECT_SELF, "is_busy") == 0)
        {
            // return home if too far away
            if (GoHome())
            {
                return;
            }

            // attack the player if seen
            object oPC = GetFirstPC();
            if (GetObjectSeen(oPC))
            {
                Attack(oPC);
            }
            else
            {
                // random ambient stuff
                if(d2() == 1)
                {
                    ClearAllActions();
                    ActionRandomWalk();
                    if(d3() == 1)
                    {
                        GoblinChat();
                    }
                }
                else if(d4() == 1)
                {
                    ClearAllActions();
                    ActionPlayAnimation(iAnimation, 1.0, 2.0);
                    ActionPlayAnimation(iAnimation, 1.0, 2.0);
                    ActionPlayAnimation(iAnimation, 1.0, 2.0);
                    if(d3() == 1)
                    {
                        GoblinChat();
                    }
                }
            }
        }
    }
    if (nUserDef==1002) //perception event
    {
        if (GetLocalInt(OBJECT_SELF, "is_blind") == 0 &&
            GetLocalInt(OBJECT_SELF, "is_busy")  == 0)
        {
            object oSeen = GetLastPerceived();
            if (GetIsPC(oSeen) && GetLastPerceptionSeen())
            {
                Attack(oSeen);
            }
        }
    }
}

//Goblins mutter a random string
void GoblinChat()
{
    int iMutter = d20();
    string q = GetLocalString(GetModule(), "QUOTE");
    switch(iMutter)
    {
        case 1: SpeakString(q+"Moo, moo, moo-cows."+q); break;
        case 2: SpeakString(q+"Gatha kath!"+q); break;
        case 3: SpeakString(q+"Stupid farmers don't know who's got the cows, ha ha ha."+q); break;
        case 4: SpeakString(q+"Run here, do that, quick quick quick! Me wants bed..."+q); break;
        case 5: SpeakString(q+"*Grumble* Tanarukks never happy. *Grumble*"+q); break;
        case 6: SpeakString(q+"Safe in cave, yeesss, all safe and secret."+q); break;
        case 7: SpeakString(q+"What's this? Ewww, green and slimy one!"+q); break;
        case 8: SpeakString(q+"No one finds us here. Get paid real good!"+q); break;
        case 9: SpeakString(q+"Don't touch humans said boss. Why not? Eh?"+q); break;
        case 10: SpeakString(q+"Stinky stuff grows, mushrooms and toes! La la la."+q); break;
        case 11: SpeakString(q+"Oooh, wormsey! I saw it first! It's mine!"+q); break;
        case 12: SpeakString(q+"Catch 'em, bring 'em, chop 'em, eat 'em! *Cackle*"+q); break;
        case 13: SpeakString(q+"Orcsies always hit, orcsies so dumb."+q); break;
        case 14: SpeakString(q+"Butcher angry! Me hides now..."+q); break;
        case 15: SpeakString(q+"Oh no! I broke it..."+q); break;
        case 16: SpeakString(q+"Feed the orcs! Always have to feed orcs first."+q); break;
        case 17: SpeakString(q+"Me brave dragon-killer goblin. Killed many dragons, yes."+q); break;
        case 18: SpeakString(q+"Hehe. That one's a nasty one!"+q); break;
        case 19: SpeakString(q+"Stupid cow. You even more stupid than brother."+q); break;
        case 20: SpeakString(q+"Me likes going all invisibubble. Me goes invisibubble and steal stuff maybe, mmm?"+q); break;
    }
}

//random one liner as Goblins attack player
void AttackString()
{
    int iFlee = d6();
    string q = GetLocalString(GetModule(), "QUOTE");
    switch (iFlee)
    {
        case 1: SpeakString(q+"Intruders! Run away! No! Dead end - eeeek! Attack!"+q); break;
        case 2: SpeakString(q+"Protect the cows! Fight!"+q); break;
        case 3: SpeakString(q+"Run away! No! Fight!"+q); break;
        case 4: SpeakString(q+"Eeeek! We beat now you!"+q); break;
        case 5: SpeakString(q+"Fight! Kill the Invaders!"+q); break;
        case 6: SpeakString(q+"We going to beat you!"+q); break;
    }
}

// attack the player
void Attack(object oPC)
{
    if (!GetIsEnemy(oPC))
    {
        ClearAllActions();
        if (d2() == 1)
            AttackString();
        SetPCDislike(oPC, OBJECT_SELF);
        DetermineCombatRound();
        ActionAttack(oPC);
    }
    else
    {
        if (d6() == 1)
            AttackString();
        DetermineCombatRound();
    }
}

// return to home location
int GoHome()
{
    object oHome = GetObjectByTag("WP_AR1501_GOBLIN_HOME");
    float fDist  = GetDistanceToObject(oHome);
    if (fDist > 10.0)
    {
        ClearAllActions(TRUE);
        ActionMoveToObject(oHome, TRUE, 3.0);
        return(TRUE);
    }
    return(FALSE);
}
