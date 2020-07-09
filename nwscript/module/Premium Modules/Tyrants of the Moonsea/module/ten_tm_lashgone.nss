void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (!(GetLocalInt(oPC, "lashannothere")== 1))
   return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)
    return;

AddJournalQuestEntry("LocktowerRescue", 101, oPC);
AssignCommand(oPC, SpeakString("Lashan is gone, as is Deputy Grimswold. You have a bad feeling about this. If Lashan has been caught snooping around, there's only one place he's liable to end up..."));

SetLocalInt(OBJECT_SELF, "fired", 1);
}

