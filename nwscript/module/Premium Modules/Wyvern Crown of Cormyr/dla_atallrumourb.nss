// February 2006
// B W-Husey
// The first time this conversation dialogue branch is accessed,
// then the rumour available on this character is set. This is determined by the variable nMyRumour
// nMyRumour > 49 is reserved for NPCs who have refused to give rumours.

// Why two versions: changes to the jousting system meant there were more opponents, so more jousting rumours were needed.
// this more extensive set of rumours is only found on some characters in Thunderstone. Most notably commoners.

void main()
{
    if (GetLocalInt(OBJECT_SELF,"nMyRumour")<51)//make sure this NPC is not in a state of never giving a rumour
    {
        int nScore = Random(23)+1; //currently set to 23 rumours.
        SetLocalInt(OBJECT_SELF,"nMyRumour",nScore);
    }
}
