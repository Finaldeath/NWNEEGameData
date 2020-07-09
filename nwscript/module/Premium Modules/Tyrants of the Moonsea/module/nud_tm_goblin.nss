// goblins shout random insults at players

string getRandomInsult()
{
    string s;
    int n = d6(1);
    switch (n)
    {
        case 1:
            s = "You stupids!";
        break;
        case 2:
            s = "You dumb!";
        break;
        case 3:
            s = "Heh!";
        break;
        case 4:
            s = "Cowards!";
        break;
        case 5:
            s = "Us goblins strong!";
        break;
        default:
            s = "You ugly!";
        break;
    }
    return s;
}

void main()
{
    int nUser = GetUserDefinedEventNumber();
    int nSeen;
    if(nUser == 1002) //PERCEIVE
    {
        object oCreature = GetLastPerceived();
        if ((GetLastPerceptionSeen()) && (GetIsPC(oCreature)))
        {
            SetFacingPoint(GetPosition(oCreature));
            SpeakString(getRandomInsult(), TALKVOLUME_SHOUT);
        }
    }
}
