//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_templedoor
// DATE: September 14, 2005
// AUTH: Luke Scull
// NOTE: Pop-up text, and opens temple door. Also gets
//       rid of Gormstadd in Voonlar for continuity
//       purposes.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYVoonlar");



if (nInt < 30)
   return;

if (GetLocalInt(OBJECT_SELF, "fired") == 1)
    return;

object oDoor = GetObjectByTag("Voonlar_To_TempleofBane");

SetLocked(oDoor, FALSE);

AssignCommand(oPC, SpeakString("The corpses of Bane's faithful litter the blood-covered snow, caught attempting to flee the temple. Someone, or something, is inside..."));

object oGormstadd = GetObjectByTag("Gormstadd");

SetImmortal(oGormstadd, FALSE);

DestroyObject(oGormstadd, 0.5);

SetLocalInt(OBJECT_SELF, "fired", 1);
}
