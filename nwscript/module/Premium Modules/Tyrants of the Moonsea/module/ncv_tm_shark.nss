//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ncv_tm_shark
// DATE: October 16, 2018
// AUTH: Rich Barker
// NOTE: Allow dialog when effectively petrified and don't face player
//////////////////////////////////////////////////////

void main()
{
   // start talking, but don't turn to face the player
    float fDir = GetFacing(OBJECT_SELF);
    BeginConversation();
    ClearAllActions();
    AssignCommand(OBJECT_SELF, SetFacing(fDir));
}
