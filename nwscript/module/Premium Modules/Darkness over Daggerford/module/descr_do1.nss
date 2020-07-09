
void main()
{
object oPC = GetEnteringObject();

if(GetIsPC(oPC) == TRUE && GetLocalInt(OBJECT_SELF, "do_once") !=1)
    {
        AssignCommand(oPC, SpeakString("Careful! There are orcs ahead but they seem to be busy stacking crates of supplies..."));
        SetLocalInt(OBJECT_SELF, "do_once", 1);
    }
}
