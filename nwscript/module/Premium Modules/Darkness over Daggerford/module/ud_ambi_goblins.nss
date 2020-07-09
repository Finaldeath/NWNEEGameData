//heartbeat random actions and mutterings for non-combat goblins
//on perception flee
//Author: Damian Brown (Luspr)
//Date: 11-Aug-2005

void GoblinChat();
void RunAway();
void FleeString();
void Flee();

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
            object oPC = GetFirstPC();
            if (GetObjectSeen(oPC))
            {
                // run away if we see a player
                Flee();
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
                Flee();
            }
        }
    }
    if (nUserDef==999)// flee signal from cutscene
    {
        ClearAllActions();
        FleeString();
        SetLocalInt(OBJECT_SELF, "is_busy", 1);
        DelayCommand(0.2, RunAway());
    }
    if (nUserDef==998)// busy signal from cutscene
    {
        // goblins can't be walking around mumbling during the scene
        ClearAllActions();
        SetLocalInt(OBJECT_SELF, "is_blind", 1);
        SetLocalInt(OBJECT_SELF, "is_busy", 1);
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

// goblins flee to a random exit
void RunAway()//goblins flee
{
    object oExitWay = GetNearestObjectByTag("EXIT_" + GetTag(OBJECT_SELF));
    ActionMoveToObject(oExitWay, TRUE);
    ActionDoCommand(DestroyObject(OBJECT_SELF, 1.0));
}

// run away
void Flee()
{
    ClearAllActions();
    FleeString();
    SetLocalInt(OBJECT_SELF, "is_busy", 1); //prevents flee being stopped by hb events
    DelayCommand(0.2, RunAway());//flee to tagged waypoint
    if(d2()==1)
    {
        PlaySound("vs_nx0asabm_hit3");
    }
}

//random one liner as Goblins flee
void FleeString()
{
    int iFlee = d6();
    string q = GetLocalString(GetModule(), "QUOTE");
    switch (iFlee)
    {
        case 1: SpeakString(q+"Eeeek! Run!"+q); break;
        case 2: SpeakString(q+"Heeeeeeelp! Invader!"+q); break;
        case 3: SpeakString(q+"Run away! Run away!"+q); break;
        case 4: SpeakString(q+"Eeeek! Discovered!"+q); break;
        case 5: SpeakString(q+"Adventurers are here! Get away!"+q); break;
        case 6: SpeakString(q+"No! Don't hurt! Look, me running!"+q); break;
    }
}
