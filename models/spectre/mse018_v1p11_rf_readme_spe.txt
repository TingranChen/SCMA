***0.18um Mixed Signal 1P6M Salicide 1.8V/3.3V Enhanced Process***
*** For Spectre only ***

Update History:
     V1.0 : Initiate

Files:

      mse018_v1p11_rf_readme_spe.txt                     .... This file!
      mse018_v1p11_rf_spe.lib                            .... Corner values for MOSFETs, resistors and MIM
      mse018_v1p11_mis_rf_spe.mdl                        .... Model of MOSFETs
      mse018_v1p11_diff_ind_3t_rf_spe.ckt                .... Subcircuit model of centre-tap differential inductor 
      mse018_v1p11_diff_ind_3t_rf_psub_spe.ckt           .... Subcircuit model of centre-tap differential inductor with pusb terminal
      mse018_v1p11_diff_ind_3t_rf_spe.ckt                .... Subcircuit model of differential inductor 
      mse018_v1p11_diff_ind_3t_rf_psub_spe.ckt           .... Subcircuit model of differential inductor with pusb terminal
      mse018_v1p11_ind_rf_spe.ckt                        .... Subcircuit model of spiral inductor 
      mse018_v1p11_ind_rf_psub_spe.ckt                   .... Subcircuit model of spiral inductor with pusb terminal
      mse018_v1p11_rf_var_spe.ckt                        .... Subcircuit model of varactors
      mse018_v1p11_rf_res_spe.ckt                        .... Subcircuit model of resistors
      mse018_v1p11_rf_mim_spe.ckt                        .... Subcircuit model of MIM 
      mse018_rf_layer.map                               .... GDSII layers definition file
      mse018_rf_interconnect_struct_1.txt               .... Interconnect tables for structure-1 (Parallel lines above a bottom plate)
      mse018_rf_interconnect_struct_2.txt               .... Interconnect tables for structure-2 (Parallel lines between two plates)
      N18_W10LD18N8.gds                                         .... GDSII file for 1.8V NMOS W/L/N=10/0.18/8
      N18_dnw_W10LD18N8.gds                                     .... GDSII file for 1.8V deep N-well NMOS W/L/N=10/0.18/8
      N18_dnw_6t_W10LD18N8.gds                                  .... GDSII file for 1.8V deep N-well NMOS W/L/N=10/0.35/8 with 6-terminal
      N33_W10LD35N8.gds                                         .... GDSII file for 3.3V W/L/N=10/0.35/8 with psub terminal
      N33_dnw_W10LD35N8.gds                                     .... GDSII file for 3.3V deep N-well NMOS W/L/N=10/0.35/8
      N33_dnw_6t_W10LD35N8.gds                                  .... GDSII file for 3.3V deep N-well NMOS W/L/N=10/0.35/8 with 6-terminal
      P18_W10LD18N8.gds                                         .... GDSII file for 1.8V PMOS W/L/N=10/0.18/8
      P18_5t_W10LD18N8.gds                                      .... GDSII file for 1.8V PMOS W/L/N=10/0.18/8 with 5-terminal 
      P33_W10LD3N8.gds                                          .... GDSII file for 3.3V PMOS W/L/N=10/0.18/8
      P33_5t_W10LD3N8.gds                                       .... GDSII file for 3.3V PMOS W/L/N=10/0.18/8 with 5-terminal
      PVAR18_JUN_W5L20N20.gds                                   .... GDSII file for 1.8V Varactor Junction Diode W/L/N=5/20/20
      PVAR18_MOS_W2L1N24.gds                                    .... GDSII file for 1.8V MOS VARACTOR W/L/N=2/1/24
      PVAR33_JUN_W5L20N20.gds                                   .... GDSII file for 3.3V Varactor Junction Diode W/L/N=5/20/20
      PVAR33_MOS_W2L1N24.gds                                    .... GDSII file for 3.3V MOS VARACTOR W/L/N=2/1/24
      MIM_A900.gds                                              .... GDSII file for MIM Area=30*30
      MIM_shield_A900.gds                                       .... GDSII file for MIM Area=30*30 with metal shielding layer
      RNDIFSAB_W2L10.gds                                        .... GDSII file for Non-silicide N+ Diffusion Resistor W/L=2/10
      RPDIFSAB_W2L10.gds                                        .... GDSII file for Non-silicide P+ Diffusion Resistor W/L=2/10
      RNPOSAB_W2L10.gds                                         .... GDSII file for Non-silicide N+ Poly Resistor W/L=2/10
      RPPOSAB_W2L10.gds                                         .... GDSII file for Non-silicide P+ Poly Resistor W/L=2/10
      RHRPO_W2L10.gds                                           .... GDSII file for Non-silicide HR Poly Resistor W/L=2/10      
      18MTE_diff_ind_3t_rf.gds                                  .... GDSII file for centre-tap Differential Inductor                                     18MTE_diff_ind_3t_rf_psub.gds                             .... GDSII file for centre-tap Differential Inductor with psub terminal
      18MTE_diff_ind_rf.gds                                     .... GDSII file for Differential Inductor 
      18MTE_diff_ind_rf_psub.gds                                .... GDSII file for Differential Inductor with psub terminal
      18MTE_ind_rf.gds                                          .... GDSII file for Spiral Inductor 
      18MTE_ind_rf_psub.gds                                     .... GDSII file for Spiral Inductor with psub terminal
      PAA_Substrate_Noise_S30.gds                               .... GDSII file for P+AA to P+AA spacing=30um Substrate coupling noise structure  
      PAA_GR_Substrate_Noise_S30.gds                            .... GDSII file for P+AA to P+AA spacing=30um with P+AA Guard Ring isolation Substrate coupling noise structure  
      PAA_DNwell_Substrate_Noise_S30.gds                        .... GDSII file for P+AA to P+AA spacing=30um with Deep Nwell isolation Substrate coupling noise structure  
                                    

How to use SMIC SPICE models in SPECTRE:

   1. Run MOS, inductor and varactor simulation:
      Add the following statements to SPECTRE netlist.
      Specify model corner by the 'include' statement;

         include "/xxx/xxx/mse018_v1p11_rf_spe.lib" section=tt
         include "/xxx/xxx/mse018_v1p11_rf_spe.lib" section=spirind_tt
         include "/xxx/xxx/mse018_v1p11_rf_spe.lib" section=diffind_tt
         include "/xxx/xxx/mse018_v1p11_rf_spe.lib" section=3tdiffind_tt
         include "/xxx/xxx/mse018_v1p11_rf_spe.lib" section=var_tt
                                                          
         /xxx/xxx is the directory where lib and ckt files are located.
         
         
   2. Run resistor simulation:
      Add the following statements to SPECTRE netlist.
      Specify model corner by the 'include' statement;

         include "/xxx/xxx/mse018_v1p11_rf_spe.lib" section=res_tt
                                                          
         /xxx/xxx is the directory where lib and ckt files are located.

   3. Run MIM simulation:
      Add the following statements to SPECTRE netlist.
      Specify model corner by the 'include' statement;

         include "/xxx/xxx/mse018_v1p11_rf_spe.lib" section=mim_tt

        /xxx/xxx is the directory where lib and ckt files are located.      
                 
          In the .lib file, all the subcircuits are included.         
          Then add the following statement in the netlist to define
          the subcircuit you want to simuilate.
          e.g.
          
          a. 1.8V NMOS width(wr)=2.5um length(lr)=0.18um finger(nf)=8

             X1( 1 2 3 4) n18_ckt_rf wr=2.5u lr=0.18u nf=8 sar=1.04e-006 sbr=1.04e-006 sdr=0.54e-6 nrdr=0.00675 nrsr=0.00915625 mr=1 scar=0 scbr=0 sccr=0 mismod=1
 

          b. Inductor width=8um spacing=1.5um inner_redius(r)=60um turns(n)=3
             (Note:Spacing is fixed at 1.5um)
             X1 (1 2) ind_rf r=60u w=8u n=3
             X2 (1 2) diff_ind_rf r=60u w=8u n=3
             X3 (1 2 0) diff_ind_3t_rf r=60u w=8u n=3
             X4 (1 2 0) ind_rf_psub r=60u w=8u n=3
             X5 (1 2 0) diff_ind_rf_psub r=60u w=8u n=3
             X6 (1 2 0 0) diff_ind_3t_rf_psub r=60u w=8u n=3
          

          c. MIM Area(ar)=900um^2(30um*30um)
             X1 (1 2) mim1_rf lr=30u wr=30u mimmis_mod=0
             X1 (1 2) mim1_shield_rf lr=30u wr=30u mimmis_mod=0

          d. MOS varactor width(wr)=10um length(lr)=1um finger(nf)=20
             X1 (1 2) pvar18_ckt_rf wr=10u lr=1u nf=20


          e. Junction varactor width(wr)=5um length(lr)=20um finger(nf)=20
             X1 (1 2) pvardio18_ckt_rf wr=5u lr=20u nf=20


          f. Non-silicide N+ diffision resistor width(wr)=2um length(lr)=10um
             X1 (1 2) rndifsab_ckt_rf l=10u w=2u
        
             Non-silicide P+ diffision resistor width(wr)=2um length(lr)=10um
             X1 (1 2) rpdifsab_ckt_rf l=10u w=2u
          
             Non-silicide N+ poly resistor width(wr)=2um length(lr)=10um
             X1 (1 2) rnposab_ckt_rf l=10u w=2u resmis_mod=0

             Non-silicide P+ poly resistor width(wr)=2um length(lr)=10um
             X1 (1 2) rpposab_ckt_rf l=10u w=2u resmis_mod=0

             HR poly resistor width(wr)=2um length(lr)=10um
             X1 (1 2) rhrpo_ckt_rf l=10u w=2u resmis_mod=0
         
      Model corners are provided for MOSFETs, MIM and resistors. They are
      ----------------------------------------------------
      MOS                name : corner
      ----------------------------------------------------
                       TT : Typical case
                       SS : Slow case
                       FF : Fast case
                       SNFP : Slow N Fast P case    
                       FNSP : Fast N Slow P case    
      ----------------------------------------------------
      Resistor           name : corner
      ----------------------------------------------------
                       RES_TT : Typical case
                       RES_SS : Slow case
                       RES_FF : Fast case 
      ----------------------------------------------------
      MIM                name : corner
      ----------------------------------------------------
                       MIM_TT : Typical case
                       MIM_SS : Slow case
                       MIM_FF : Fast case 
      ----------------------------------------------------
      Spiral Inductor    name : corner
      ----------------------------------------------------
                       SPIRIND_TT : Typical case
                       SPIRIND_SS : Slow case
                       SPIRIND_FF : Fast case 
      ----------------------------------------------------
      Differential Inductor name : corner
      ----------------------------------------------------
                       DIFFIND_TT : Typical case
                       DIFFIND_SS : Slow case
                       DIFFIND_FF : Fast case 
      ----------------------------------------------------
      3-Terminal Differential Inductor name : corner
      ----------------------------------------------------
                       3TDIFFIND_TT : Typical case
                       3TDIFFIND_SS : Slow case
                       3TDIFFIND_FF : Fast case 
      ----------------------------------------------------
      Mos varactor       name : corner
      ----------------------------------------------------
                       VAR_TT : Typical case
                       VAR_SS : Slow case
                       VAR_FF : Fast case 

  Whereas, Five model corners are provided for RF MOS and
  Three model corners are provided for MIM,resistors,Metal6 resistor,spiral inductor,differential inductor,3-terminal differential inductor,mos varactor 
  They are defined respectively in the .lib files.
 
4. Monte Carlo Statistical model
   Demo netlist
------------------------------------------------------------
simulator lang=spectre insensitive=yes
include "mse018_v1p11_rf_spe.lib" section=mc
x1 (d1 g1 0 0 ) n18_ckt_rf wr=2.5u lr=0.18u nf=8 sar=1.04e-006 sbr=1.04e-006 sdr=0.54e-6 nrdr=0.00675 nrsr=0.00915625 mr=1 scar=0 scbr=0 sccr=0 mismod=1
vd1 (d1 0) vsource dc=1.8
vg1 (g1 0) vsource dc=1.8
save vd1:currents
mc1 montecarlo variations=process numruns=500 donominal=no \
savefamilyplots=yes { 
 dc1 dc dev=vg1 param=dc  values=[1.8]
 dcOpInfo info what=oppoint where=file file=mos.out extremes=yes
}
*---------------------------------------------------------*

5. demo netlist for mosfet mismatch model
*------------------------------------------------------------------*
//
simulator lang=spectre insensitive=yes
include "mse018_v1p11_rf_spe.lib" section=tt
vgs1 ( g1 0 ) vsource dc=1.8
vds1 ( d1 0 ) vsource dc=1.8
vds2 ( d2 0 ) vsource dc=1.8
x1 (d1 g1 0 0 ) n18_ckt_rf wr=2.5u lr=0.18u nf=8 sar=1.04e-006 sbr=1.04e-006 sdr=0.54e-6 nrdr=0.00675 nrsr=0.00915625 mr=1 scar=0 scbr=0 sccr=0 mismod=1
x2 (d2 g1 0 0 ) n18_ckt_rf wr=2.5u lr=0.18u nf=8 sar=1.04e-006 sbr=1.04e-006 sdr=0.54e-6 nrdr=0.00675 nrsr=0.00915625 mr=1 scar=0 scbr=0 sccr=0 mismod=1
save vds1:currents
save vds2:currents

mc1 montecarlo variations=mismatch seed=50 numruns=100 donominal=no \
savefamilyplots=yes { 
dc1 dc dev=vgs1 param=dc  values=[1.8]
dcopinfo info what=oppoint extremes=yes
}