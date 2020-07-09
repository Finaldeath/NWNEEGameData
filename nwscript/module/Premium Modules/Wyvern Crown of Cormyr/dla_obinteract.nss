// April 2004
// Generic script for floating information about an object when it is used.
// The object must do nothing tag based except this. Set tag to Interactive.
// sMessage is "OBJECT_MESSAGE" variable set on the object.
// B W-Husey

void main()
{
    if (GetTag(OBJECT_SELF)=="Interactive")
    {
    object oPC = GetLastUsedBy();
    string sMessage = GetLocalString (OBJECT_SELF,"OBJECT_MESSAGE");
    FloatingTextStringOnCreature(sMessage,oPC, FALSE);
    }
}
