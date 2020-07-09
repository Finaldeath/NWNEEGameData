#include "inc_id1_debug"
#include "inc_id1_utility"

void main()
{
    // get the number of MicroCPUs created
    int nMicroNum = GetLocalInt(GetModule(), "nMicroNum");

    // get the number of MicroCPUs finished
    int nMicroDead = GetLocalInt(GetModule(), "nMicroDead");

    DebugMessage("");
    DebugMessage("Holding plot generation with " + IntToString(nMicroNum) + " active and " + IntToString(nMicroDead) + " dead microprocesses.");

    // if waiting on micro processes
    if (nMicroDead < nMicroNum)
    {
        DelayCommand(0.01, ExecuteScript("exe_id1_plothold", GetNextCPU()));
    } else // all microprocesses done
    {
        // reset number of active and dead microCPUs
        SetLocalInt(GetModule(), "nMicroNum", 0);
        SetLocalInt(GetModule(), "nMicroDead", 0);

        DebugMessage("Returning to exe_id1_plotgen.");
        DelayCommand(0.01, ExecuteScript("exe_id1_plotgen", GetNextCPU()));
    }
}
