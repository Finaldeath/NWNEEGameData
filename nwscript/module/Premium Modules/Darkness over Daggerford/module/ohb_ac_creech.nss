//::///////////////////////////////////////////////
//:: FileName ohb_ac_creech
//:: Creech yells insults on heartbeat
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: March 23, 2006
//:://////////////////////////////////////////////
int anyPlayersInArea( object who )
{
    object pc = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, who );
    if( !GetIsObjectValid(pc) )
        return 0;
    return 1;
}

void main()
{
    if( !anyPlayersInArea( OBJECT_SELF ) )
            return;
    if (IsInConversation(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF))
    {
        return;
    }

    string s6;
    string s7;
    string s8;
    string s9;

    if (GetGender(GetFirstPC()) == GENDER_FEMALE)
    {
        s6 = " queen ";
        s7 = " her ";
        s8 = "She ";
        s9 = "she";
    }
    else
    {
        s6 = " king ";
        s7 = " him ";
        s8 = "He ";
        s9 = "he";
    }

    string s1 = "Oh, look. The" + s6 + "of mediocrity has arrived.";
    string s2 = "Drop" + s7 + "in a cauldron, boss. " + s8 + "might make a tasty meal." ;
    string s3 = s8 + " looks very flammable, master. Let's find out!";
    string s4 = "You insult my master with your mere presence!";

    switch (d8())
    {
        case 1:
        ActionSpeakString(s1);
        break;
        case 2:
        ActionSpeakString(s2);
        break;
        case 3:
        ActionSpeakString(s3);
        break;
        case 4:
        ActionSpeakString(s4);
        break;
    }
}


