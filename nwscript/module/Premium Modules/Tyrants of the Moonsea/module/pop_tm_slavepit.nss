//Door to Zhentil Keep slave pit is opened

#include "hf_in_plot"

void main()
{
    PlotLevelSet("ZhentSlave", 1);
    //Remove the dog that has been waiting outside for its master
    DestroyObject(GetObjectByTag("EmpathyZKDog"));
}
