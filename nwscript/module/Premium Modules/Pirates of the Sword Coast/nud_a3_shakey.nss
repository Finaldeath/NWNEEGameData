//::///////////////////////////////////////////////
//:: Act 3 Crewman Shakey McGuires userdefined events
//:: nud_a3_shakey.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Act 3 Crewman Shakey McGuires userdefined events
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 29, 2004
//:://////////////////////////////////////////////
//:: Modified By: Keith Hayward
//:: Created On: April 18, 2005
//:://////////////////////////////////////////////

const string sShout01 = "W-w-w-wait for me!";
const string sShout02 = "P-p-please don't leave me alone out here!";
const string sShout03 = "I'm c-closing my eyes now!";
const string sShout04 = "This is even w-worse than s-s-sailing...";
const string sShout05 = "I want to go home!";
const string sShout06 = "If I c-close my eyes, will you go away?";
const string sShout07 = "Oh dear...";
const string sShout08 = "Help!";
const string sShout09 = "Run away!";
const string sShout10 = "Sh-sh-shakey McGuire, at your service, captain.";

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {
        //Make them say something when they see a NPC they don't like.
        int iRandom3 = Random(3);
        int bSeen = GetLastPerceptionSeen();
        object oPerceived = GetLastPerceived();

        if ((bSeen == TRUE)
          && (GetObjectType(oPerceived) == OBJECT_TYPE_CREATURE)
          && (GetIsPC(oPerceived) == FALSE)
          && (GetIsEnemy(oPerceived) == TRUE)
          && (iRandom3 != 0))
        {
            string sTalk;
            int iRandom10 = Random(10);
            switch(iRandom10)
            {
                case 0:
                    sTalk = sShout01;
                break;
                case 1:
                    sTalk = sShout02;
                break;
                case 2:
                    sTalk = sShout03;
                break;
                case 3:
                    sTalk = sShout04;
                break;
                case 4:
                    sTalk = sShout05;
                break;
                case 5:
                    sTalk = sShout06;
                break;
                case 6:
                    sTalk = sShout07;
                break;
                case 7:
                    sTalk = sShout08;
                break;
                case 8:
                    sTalk = sShout09;
                break;
                case 9:
                    sTalk = sShout10;
                break;
            }
            SpeakString(sTalk);
        }
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


