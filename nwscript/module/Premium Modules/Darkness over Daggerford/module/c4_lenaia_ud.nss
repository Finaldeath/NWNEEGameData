// when fighting thokk, lenaia begs for mercy

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Damaged()
{
    object oEnemy = GetLastDamager();
    if (GetTag(oEnemy) == "ks_lizslave1")
    {
        int n = GetLocalInt(OBJECT_SELF, "nBegIndex");
        if (n == 0)
        {
            SpeakString("Stop! You're hurting me!");
        }
        else if (n == 1)
        {
            SpeakString("Please...don't kill me! We must fight the lizards together!");
        }
        else if (n == 2)
        {
            SpeakString("Help! I don't want to die!");
        }
        else if (n == 3)
        {
            SpeakString("No! Stop this senseless blood-sport!");
        }
        else if (n == 4)
        {
            SpeakString("Someone! Stop him! He's killing me!");
        }
        else if (n == 5)
        {
            SpeakString("*groan*");
        }
        else if (n == 6)
        {
            SpeakString("Help! I'm dying!");
        }
        SetLocalInt(OBJECT_SELF, "nBegIndex", ++n);
    }
}


void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_DAMAGED)
    {
        Damaged();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);
    }
}
