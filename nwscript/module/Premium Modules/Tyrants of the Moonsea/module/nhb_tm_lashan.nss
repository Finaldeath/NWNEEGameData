//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: nhb_tm_lashan
// DATE: September 26, 2005
// AUTH: Luke Scull
// NOTE: Lashan laments his cowardice every 18 seconds.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int nCount=GetLocalInt(OBJECT_SELF, "wait");
void main()
{

object oPC = GetFirstPC();

nCount = nCount+1;

SetLocalInt(OBJECT_SELF, "wait", nCount);


if (!(nCount == 3))

return;

if (IsInConversation(OBJECT_SELF) || GetIsInCombat()) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYLocktowerRescue");


if (!(nInt >= 10))
   {
   SpeakString("D-damn! Why am I such a c-coward?");
   SetLocalInt(OBJECT_SELF, "wait", 0);

}
ExecuteScript("nw_c2_default1", OBJECT_SELF);
}

