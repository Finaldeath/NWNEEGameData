//::///////////////////////////////////////////////
//:: Act 3 Seige Sahaugin userdefined events
//:: nud_a3_seigshgn.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Act 3 Skull and Bones Seige Sahaugin have
    custom On preceived lines.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 29, 2004
//:://////////////////////////////////////////////
//:: Modified By: Keith Hayward
//:: Created On: April 18, 2005
//:://////////////////////////////////////////////

const string sShout01 = "You're going down, pirate!";
const string sShout02 = "Glub glub glub!";
const string sShout03 = "Sink her!";
const string sShout04 = "Swim with the fishes!";
const string sShout05 = "A watery grave for you, glub glub!";
const string sShout06 = "Glub glub!";
const string sShout07 = "Glub glub?";
const string sShout08 = "Sink or swim, pirate!";
const string sShout09 = "I think you sprung a leak, captain!";
const string sShout10 = "Pickle them in the brine!";

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
        //Make them say something piratey when they see someone.
        int iRandom3 = Random(3);
        int bSeen = GetLastPerceptionSeen();
        object oPerceived = GetLastPerceived();

        if ((bSeen == TRUE)
          && (GetIsEnemy(oPerceived) == TRUE)
          && (GetIsPC(oPerceived) == TRUE)
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


