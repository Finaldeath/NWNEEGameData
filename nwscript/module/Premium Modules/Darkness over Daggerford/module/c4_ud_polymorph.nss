//::///////////////////////////////////////////////
//:: Name x2_def_userdef
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On User Defined Event script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {
        object oTarget = OBJECT_SELF;
        if (IsInConversation(oTarget))return;
        int iPoly = d100(1);
        //95 = the boat appearance - don't want that here :lol: - Phil
        if (iPoly == 95)
        {
            iPoly = iPoly + 1;
        }
        effect ePoly = EffectPolymorph(iPoly);
        effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, oTarget);
        if (iPoly == 26)
            ActionSpeakString("Too small");
        else if (iPoly == 27 || iPoly == 25 || iPoly == 24 || iPoly == 40)
            ActionSpeakString("Nothing exciting about this form!");
        else if (iPoly == 3 || iPoly == 62 || iPoly == 100)
            ActionSpeakString("Too many legs I think!");
        else if (iPoly == 80 || iPoly == 81)
            ActionSpeakString("Now I can throw a tantrum!");
        else if (iPoly == 71 || iPoly == 72 || iPoly == 73 || iPoly == 8 )
            ActionSpeakString("I best watch for that ceiling!");
        else if (iPoly == 74 || iPoly == 75 || iPoly == 76 || iPoly == 77 || iPoly == 7)
            ActionSpeakString("Oooh scary undead!");
        else if (iPoly == 13 || iPoly == 14 || iPoly == 15 || iPoly == 16 || iPoly == 17)
            ActionSpeakString("Too Elementally!");
        else if (iPoly == 46 || iPoly == 47 || iPoly == 48 || iPoly == 49 || iPoly == 50)
            ActionSpeakString("Hey, It's me again!");
        else if (iPoly == 64 || iPoly == 68 || iPoly == 97 || iPoly == 60 || iPoly == 32)
            ActionSpeakString("Oh no! I've turned into my mother in law!");
        else if (iPoly == 33 || iPoly == 34 || iPoly == 35 || iPoly == 36 || iPoly == 37)
            ActionSpeakString("Hmmm. A bit 'dire' ha ha.");
        else if (iPoly == 52 || iPoly == 53 || iPoly == 54 || iPoly == 55 || iPoly == 56)
            ActionSpeakString("Weeee. I've got wings!");
        else if (iPoly == 90 || iPoly == 91 || iPoly == 92 || iPoly == 93 || iPoly == 57)
            ActionSpeakString("Now I'm impressed with this form");
        else if (iPoly == 9 || iPoly == 41 || iPoly == 42 || iPoly == 44 || iPoly == 45)
            ActionSpeakString("I'm tall at last.");
        else if (iPoly == 63)
            ActionSpeakString("Peekaboo. I see you.");
        else
           {
            int iSay = d3(1);
            if (iSay == 1)
                ActionSpeakString("Not bad! Let's see the next form.");
            if (iSay == 2)
                ActionSpeakString("I wonder what the next form is?");
            if (iSay == 3)
                ActionSpeakString("Let me try the next form.");
            }
        }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

    }
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {

    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {

    }
    else if(nUser == 1007) // DEATH  - do not use for critical code, does not fire reliably all the time
    {

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {

    }


}


