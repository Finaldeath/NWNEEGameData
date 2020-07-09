//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_madoc8
// DATE: August 29, 2005
// AUTH: Luke Scull
// NOTE: Journal entry, set int, NPCs leave inn.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oBron = GetNearestObjectByTag("TheBron", oPC);
    object oGormstadd = GetObjectByTag("Gormstadd");
    object oMadoc = GetNearestObjectByTag("MadoctheUncouthInn", oPC);
    object oZhentarim1 = GetObjectByTag("VoonlarZhentarimFighter1");
    object oZhentarim2 = GetObjectByTag("VoonlarZhentarimFighter2");
    object oZhentarim3 = GetNearestObjectByTag("VoonlarZhentarimMage", oPC);

    // Add 2nd journal entry for Voonlar
    AddJournalQuestEntry("Voonlar", 20, oPC);

    // Set local int "bronfight" to 1.
    SetLocalInt(oPC, "bronfight", 1);

    // Make sure plot flag is removed for Madoc, Bron, and Gormstadd.
    SetPlotFlag(oMadoc, 0);
    SetPlotFlag(oBron, 0);
    SetPlotFlag(oGormstadd, 0);
    SetLocalInt(oMadoc, "nBusy", 1);

    // Make them all move to inn door and then destroy.
    ExecuteScript("hf_cs_exit", oBron);
    ExecuteScript("hf_cs_exit", oZhentarim1);
    DelayCommand(4.0, ExecuteScript("hf_cs_exit", oZhentarim2));
    DelayCommand(8.0, ExecuteScript("hf_cs_exit", oGormstadd));
    DelayCommand(10.0, ExecuteScript("hf_cs_exit", oMadoc));
    DelayCommand(10.1, SetLocalInt(oMadoc, "nBusy", 0));
    DelayCommand(11.0, ExecuteScript("hf_cs_exit", oZhentarim3));
}
