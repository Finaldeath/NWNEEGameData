//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Slaves disappear
//:: Elf is moved to abandoned warehouse
//::////////////////////////////////////////////////////

const string NPC_TAG_SLAVE = "tm_cr_melv_slave";

const string NPC_RESREF_ELF = "elf";
const string NPC_TAG_ELF = "Elf";
const string WP_TAG_ELF_HIDEOUT = "WP_melv_shipy_elf_hide";

void main()
{
    // Elf leaves
    object oElf = GetObjectByTag(NPC_TAG_ELF);
    object oElfWaypoint = GetWaypointByTag(WP_TAG_ELF_HIDEOUT);
    ExecuteScript("hf_cs_exit", oElf);
    
    // Create new Elf at abandones warehouse
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ELF, GetLocation(oElfWaypoint), FALSE, NPC_TAG_ELF);

    // Slaves leave
    int nNth = 0;
    object oSlave = GetObjectByTag(NPC_TAG_SLAVE, nNth);
    while (GetIsObjectValid(oSlave))
    {
        ExecuteScript("hf_cs_exit", oSlave);
        nNth++;
        oSlave = GetObjectByTag(NPC_TAG_SLAVE, nNth);
    }
}
