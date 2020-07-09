void main()
{
    object oPC = GetEnteringObject();
    string q = GetLocalString(GetModule(), "QUOTE");

    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
    SetLocalInt(OBJECT_SELF,"fired",1);
    AssignCommand(oPC, SpeakString(q+"He took the rope. Blast!"+q));
}
