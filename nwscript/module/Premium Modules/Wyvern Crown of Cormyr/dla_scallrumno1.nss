//::///////////////////////////////////////////////
//:: FileName dla_scallrumno1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: B W-Husey
//:: Created On: 01/10/2005 10:20:13
// The NPC rejects giving the PC a rumour with a random response.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    return (GetLocalInt(GetPCSpeaker(), "nMyRumour") == 50 && Random(3) == 1);
}
