// September 2005
// B W-Husey
// The first time this conversation dialogue branch is accessed,
// then the rumour available on this character is set. This is determined by the variable nMyRumour
// nMyRumour > 49 is reserved for NPCs who have refused to give rumours.
void main()
{
    if (GetLocalInt(OBJECT_SELF,"nMyRumour")<51)//make sure this NPC is not in a state of never giving a rumour
    {
        int nScore = Random(21)+1; //currently set to 21 rumours.
        SetLocalInt(OBJECT_SELF,"nMyRumour",nScore);
    }
}
