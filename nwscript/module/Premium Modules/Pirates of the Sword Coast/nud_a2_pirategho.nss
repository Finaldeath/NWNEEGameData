//::///////////////////////////////////////////////
//:: Ghostly Pirate UserDefined
//:: nud_a2_ghostpirate.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Apply ghostly effects to the lighthouse
     pirates and handle their Arrr! and Yarrr!
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 29, 2004
//:://////////////////////////////////////////////

const string sShout01 = "Arrr!";
const string sShout02 = "Yarrr!";
const string sShout03 = "Garrr?";
const string sShout04 = "Avast!";
const string sShout05 = "Shiver me timbers!";
const string sShout06 = "Ahoy!";
const string sShout07 = "Yarrr?";
const string sShout08 = "Yo-ho-ho!";
const string sShout09 = "Where's me rum!?";
const string sShout10 = "Arrr!";

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
        //Make them transparent and ghostly.
        effect eGhost = EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
    }


}


