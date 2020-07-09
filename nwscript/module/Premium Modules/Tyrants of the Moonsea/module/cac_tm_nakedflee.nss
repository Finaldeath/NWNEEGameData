#include "hf_in_plot"

void main()
{
    object oCommoner1 = GetObjectByTag("MulNaked1");
    object oCommoner2 = GetObjectByTag("MulNaked2");

    PlotLevelSet("MulNobleNaked", 1);

    ExecuteScript("hf_cs_exit", oCommoner1);
    ExecuteScript("hf_cs_exit", oCommoner2);
}
