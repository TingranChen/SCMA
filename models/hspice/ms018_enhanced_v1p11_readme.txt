***0.18um Mixed Signal Enhanced 1.8V/3.3V SPICE Model ***
*** For HSPICE only ***
1. Update History:

   V1.0:	1. Initiate
   V1.10:	1. Retarget n18 and p18 MOS and re-extract LOD effect model, modify p18 mismatch model. 
		2. Retarget nmvt33 MOS model. Modify nnt33 MOS corner model. 
		3. Re-extract p33 and pmvt18 MOS cjgate parameters.
		4. Modify n33 p33 default dmci value in mdl files.
		5. Modify nnt33 mismatch parameter dxw expression.
		6. Set all MOS devices WPEMOD=0 to turn off WPE effect. 
		7. Retarget n+ poly silicide, p+ poly silicide, p+ poly sab, nwell AA resistor model.
		8. Modify mim default wr lr value in model file and mismatch random variable expression in spectre format model file.
		9. Modify BJT npn18a100.mdl hspice format model file. 
   V1.11:       1. Update the version from v1.10 to v1.11 in title and section 7.5.2/7.6.4/8 in main document.
                2. Deleted 3K HRP resistor related models for PIE request in attachment "ms018_enhanced_v1p11_res.ckt", "ms018_enhanced_v1p11_res.mdl", "ms018_enhanced_v1p11_res_spe.ckt", "ms018_enhanced_v1p11_res_spe.mdl","ms018_fit_G.pdf" and "ms018_fit_D.pdf", and updated in section 7.6.1/7.6.2/7.6.3/7.6.4/7.9 in main document.
                3. Modified 'l=lr w=wr' to 'l=10e-6 w=1e-6' for resistor in "ms018_enhanced_v1p11_res.ckt" and "ms018_enhanced_v1p11_res_spe.ckt".
                4. Deleted doubld defined parameter "+sigma_mis_res=agauss(0,1,1)" for resistor in "ms018_enhanced_v1p11_res.ckt" and "ms018_enhanced_v1p11_res_spe.ckt"..
                5. Updated SPECTRE diode parameter tcv to match HSPICE simualton result in "ms018_enhanced_v1p11_dio_spe.mdl".
                6. Updated gate current to match HSPICE in "gc.va" file.
                7. Updated 'rbm' in all npn BJT devices to avoid warning in bjt folder. 
                8. Updated nmvt18 model to avoid acde parameter warning in "ms018_enhanced_v1p11.mdl", "ms018_enhanced_v1p11_mis.mdl", "ms018_enhanced_v1p11_spe.mdl" and "ms018_enhanced_v1p11_mis_spe.mdl".
                9. Updated mismatch for mim_ckt in SPECTRE to match HSPICE in "ms018_enhanced_v1p11_mim_spe.ckt".
                10. Updated ¡°ASCII.7z¡± zip file name to ¡°SMIC_SP_model_018MSE_1833.tar.gz¡± for new naming rule, and update in section 8.1
                11. Align attached document format to pdf with ECN, and updated in section 8.3.
                12. Update document title to "0.18um Mixed Signal Enhanced 1.8V/3.3V SPICE Model" for new naming rule.
                13. Updated attachment ¡°GDS.7z¡± zip file name to ¡°SMIC_SP_GDS_018MSE_1833.tar.gz¡± for new naming rule.
                14. Updated attachment  name for new naming rule , from ¡°ms018_fit_A.pdf/ms018_fit_B1.pdf/ms018_fit_B2.pdf/ms018_fit_C.pdf/ms018_fit_D.pdf/ms018_fit_F.pdf/ms018_fit_G.pdf¡± to ¡°SMIC_SP_fit_A_018MSE_1833.Pdf/SMIC_SP_fit_B1_018MSE_1833.pdf/SMIC_SP_fit_B2_018MSE_1833.pdf/SMIC_SP_fit_C_018MSE_1833.pdf/SMIC_SP_fit_D_018MSE_1833.pdf/SMIC_SP_fit_F_018MSE_1833.pdf/SMIC_SP_fit_G_018MSE_1833.pdf¡±



2. Files:
           ms018_enhanced_v1p11_readme.txt                             .... This file!

           For hspice: 
    	   ms018_enhanced_v1p11_lib                                    .... Corner values for MOSFETs, and resistors 
    	   ms018_enhanced_v1p11.mdl                                    .... Model parameters file for N/PMOS 
    	   ms018_enhanced_v1p11_mis.mdl                                .... Mismatch Model for N/PMOS 
           ms018_enhanced_v1p11_mim.ckt                                .... mim macro model
           ms018_enhanced_v1p11_mim.mdl                                .... Model parameters file for mim
           ms018_enhanced_v1p11_res.mdl                                .... Model parameters file for resistors
    	   ms018_enhanced_v1p11_res.ckt                                .... Resistor macro model 
           ms018_enhanced_v1p11_var.ckt                                .... varactor macro model 
           ms018_enhanced_v1p11_dio.mdl                                .... diode model 
           ms018_enhanced_v1p11_bjt.mdl                                .... bjt model 

           npn18a4.mdl                                                 .... for bjt mismatch model
           npn18a25.mdl                                                .... for bjt mismatch model
           npn18a100.mdl                                               .... for bjt mismatch model
           npn33a4.mdl                                                 .... for bjt mismatch model
           npn33a25.mdl                                                .... for bjt mismatch model
           npn33a100.mdl                                               .... for bjt mismatch model
           pnp18a4.mdl                                                 .... for bjt mismatch model
           pnp18a25.mdl                                                .... for bjt mismatch model
           pnp18a100.mdl                                               .... for bjt mismatch model
           pnp33a4.mdl                                                 .... for bjt mismatch model
           pnp33a25.mdl                                                .... for bjt mismatch model
           pnp33a100.mdl                                               .... for bjt mismatch model


	  ms018_enhanced_v1p11_interconnect_struct1_tm_9k.txt          .... Interconnect tables for structure-1 (Parallel lines above a bottom plate)
	  ms018_enhanced_v1p11_interconnect_struct1_tm_22k.txt         .... Interconnect tables for structure-1 (Parallel lines above a bottom plate)
	  ms018_enhanced_v1p11_interconnect_struct1_tm_34k.txt         .... Interconnect tables for structure-1 (Parallel lines above a bottom plate)
	  ms018_enhanced_v1p11_interconnect_struct1_tm_40k.txt         .... Interconnect tables for structure-1 (Parallel lines above a bottom plate)
	  ms018_enhanced_v1p11_interconnect_struct2_tm_9k.txt          .... Interconnect tables for structure-2 (Parallel lines between two plates)
	  ms018_enhanced_v1p11_interconnect_struct2_tm_22k.txt         .... Interconnect tables for structure-2 (Parallel lines between two plates)
	  ms018_enhanced_v1p11_interconnect_struct2_tm_34k.txt         .... Interconnect tables for structure-2 (Parallel lines between two plates)
      	  ms018_enhanced_v1p11_interconnect_struct2_tm_40k.txt         .... Interconnect tables for structure-2 (Parallel lines between two plates)
        

	  ms018g_fit_A.doc                  	                 .... Section A1 of the fitting plots for 0.18um Mix-signal model
	  ms018g_fit_B1.doc                  	                 .... Section B1 of the fitting plots for 0.18um Mix-signal model
	  ms018g_fit_B2.doc                                      .... Section B2 of the fitting plots for 0.18um Mix-signal model
	  ms018g_fit_C.doc                   	                 .... Section C of the fitting plots for 0.18um Mix-signal model
	  ms018g_fit_D.doc                   	                 .... Section D of the fitting plots for 0.18um Mix-signal model
	  ms018g_fit_F.doc                   	                 .... Section F of the fitting plots for 0.18um Mix-signal model
	  ms018g_fit_G.doc                   	                 .... Section G of the fitting plots for 0.18um Mix-signal model
          GDS.7z 	                                         .... all devices gds sample
             
            
3. How to use SMIC SPICE models :
  
  For Hspice:
  
      Add the following statements to HSPICE netlist.
      
      a. Specify device corner and model by the '.lib' statement;
         .lib '/xxx/xxx/ms018_enhanced_v1p11.lib' TT(FF/SS/FNSP/SNFP/MC)
                                            ^^ mos model corner
         .lib '/xxx/xxx/ms018_enhanced_v1p11.lib' RES_TT(FF/SS/MC)
                                            ^^ resistor model corner
         .lib '/xxx/xxx/ms018_enhanced_v1p11.lib' BJT_TT(FF/SS/MC)
                                            ^^ BJT model corner
         .lib '/xxx/xxx/ms018_enhanced_v1p11.lib' DIO_TT
                                            ^^ DIO model corner
         .lib '/xxx/xxx/ms018_enhanced_v1p11.lib' VAR_TT(FF/SS)
                                            ^^ VAR model corner
         .lib '/xxx/xxx/ms018_enhanced_v1p11.lib' MIM_TT(FF/SS)
                                            ^^ MIM model corner




4. The Capability of Model

  a. MOS Model

* simple model name         :
*        *----------------------------------------------------------------*
*        |     mosfet type    |   1.8v   |     3.3v  | 1.8V MVT | 3.3V MVT|
*        |================================================================| 
*        |        nmos        |    n18   |     n33   |  nmvt18  | nmvt33  |
*        *----------------------------------------------------------------*
*        |        pmos        |    p18   |     p33   |  pmvt18  |
*        *------------------------------------------------------*
*        |    native nmos     |   nnt18  |    nnt33  |  
*        *-------------------------------------------*
* subckt model name (with mismatch simulation capability) 
*        *----------------------------------------------------------------------------------- 
*        |     mosfet type    |     1.8v       |      3.3v      |   1.8V MVT   |  3.3V MVT  | 
*        |======================================================|==============|============*
*        |      nmos          |   n18_ckt      |    n33_ckt     |   nmvt18_ckt |  nmvt33_ckt|
*        *------------------------------------------------------|--------------|------------*
*        |      pmos          |   p18_ckt      |    p33_ckt     |   pmvt18_ckt |
*        *------------------------------------------------------|--------------*
*        |      nmos          |   nnt18_ckt    |   nnt33_ckt    |
*        *------------------------------------------------------*
*        |      nmos          |   n18_dnw_ckt  | n33_dnw_ckt    |
*        *------------------------------------------------------*
*        |      pmos          |   p18_dnw_ckt  | p33_dnw_ckt    |
*        *------------------------------------------------------*
*        |      nmos          | n18_dnw_4t_ckt | n33_dnw_4t_ckt |
*        *------------------------------------------------------*
*        |      pmos          | p18_dnw_4t_ckt | p33_dnw_4t_ckt |
*        *------------------------------------------------------*

            temperature range:-40C~125C


            b. BJT Model

*   Vertical PNP BJT :
*        *-------------------------------------------------------* 
*        | P+/NWELL/PSUB BJT type        |   1.8V    |   3.3V    |
*        |=======================================================|
*        | Emitter Area: 10*10 um^2      | pnp18a100 | pnp33a100 |
*        |-------------------------------------------------------|  
*        | Emitter Area: 5*5 um^2        |  pnp18a25 | pnp33a25  |
*        |-------------------------------------------------------| 
*        | Emitter Area: 2*2 um^2        |  pnp18a4  | pnp33a4   |
*        *-------------------------------------------------------* 
*
*   Vertical NPN BJT :
*        *-------------------------------------------------------* 
*        |  N+/PWELL/DeepNWELL BJT type  |   1.8V    |   3.3V    |
*        |=======================================================|
*        | Emitter Area: 10*10 um^2      | npn18a100 | npn33a100 |
*        |-------------------------------------------------------|  
*        | Emitter Area: 5*5 um^2        | npn18a25  | npn33a25  |
*        |-------------------------------------------------------| 
*        | Emitter Area: 2*2 um^2        | npn18a4   | npn33a4   |
*        *-------------------------------------------------------* 
         temperature range : -40C ~ 125C

           c. Diode Model
   
*        *-----------------------------------*-----------*
*        |  Junctio Diode type     |   3.3V  |   1.8V    |
*        *===================================|===========*
*        |      N+/PWELL           |  ndio33 |  ndio18   |
*        *-----------------------------------|-----------*
*        |      P+/NWELL           |  pdio33 |    pdio18 |
*        *-----------------------------------|-----------*
*        |      N+/PWELL MVT       |ndiomvt33|  ndiomvt18|
*        *-----------------------------------|-----------*
*        |      P+/NWELL MVT       |         |  pdiomvt18|
*        *-----------------------------------|-----------*
*        |      N+/Psub            | nndio33 |  nndio18  |
*        *-----------------------------------|-----------*
*        |      Nwell/Psub         |        nwdio        |
*        *-----------------------------------------------*
*        |     Buried Pwell/Deep Nwell   |  diobpw       |
*        *-----------------------------------------------*
*        |      Deep Nwell/Psub    |        dnwdio       |
*        *-----------------------------------------------*
*        |      parasitic Nwell/Psub   |parasitic_nwdio  |
*        *-----------------------------------------------*
*        | Buried Pwell/Deep Nwell   |  parasitic_diobpw |
*        *-----------------------------------------------*
*        |      Deep Nwell/Psub    |parasitic_dnwdio     |
*        *-----------------------------------------------*
           temperature range: -40C~125C

           d. Resistor Model

*   Resistor         :
*
*        *----------------------------------------------------------------------* 
*        |             resistor type                            | 1.8v/3.3v     |
*        |======================================================|===============|
*        |        silicide n+ diffusion                         |    rndif      |
*        |------------------------------------------------------|---------------| 
*        |        silicide p+ diffusion                         |    rpdif      |
*        |------------------------------------------------------|---------------| 
*        |           silicide n+ poly                           |     rnpo      |
*        |------------------------------------------------------|---------------| 
*        |           silicide n+ poly(3T)                       |     rnpo_3t   |
*        |------------------------------------------------------|---------------| 
*        |           silicide p+ poly                           |     rppo      |
*        |------------------------------------------------------|---------------| 
*        |           silicide p+ poly(3T)                       |     rppo_3t   |
*        |------------------------------------------------------|---------------|
*        |        silicide nwell under aa                       |    rnwaa      |
*        |------------------------------------------------------|---------------|
*        |        silicide nwell under sti                      |    rnwsti     |
*        |------------------------------------------------------|---------------| 
*        |        non-silicide n+ diffusion                     |   rndifsab    |
*        |------------------------------------------------------|---------------| 
*        |        non-silicide p+ diffusion                     |   rpdifsab    |
*        |------------------------------------------------------|---------------|
*        |          non-silicide n+ poly                        |   rnposab     |
*        |------------------------------------------------------|---------------| 
*        |          non-silicide n+ poly(3T)                    |   rnposab_3t  |
*        |------------------------------------------------------|---------------|
*        |          non-silicide p+ poly                        |   rpposab     |
*        |------------------------------------------------------|---------------| 
*        |          non-silicide p+ poly(3T)                    |   rpposab_3t  |
*        |------------------------------------------------------|---------------|
*        |        high resistance poly                          |     rhrpo     |
*        |------------------------------------------------------|---------------|
*        |        high resistance poly(3T)                      |     rhrpo_3t  |
*        |------------------------------------------------------|---------------| 
*        |                  metal 1                             |      rm1      |
*        |------------------------------------------------------|---------------| 
*        |                  metal 2                             |      rm2      |
*        |------------------------------------------------------|---------------| 
*        |                  metal 3                             |      rm3      |
*        |------------------------------------------------------|---------------|  
*        |                  metal 4                             |      rm4      |
*        |------------------------------------------------------|---------------| 
*        |                  metal 5                             |      rm5      |
*        |------------------------------------------------------|---------------| 
*        |                  metal 6 (9825a)                     |      rm6      |
*        |------------------------------------------------------|---------------| 
*        |                 top   metal MTT1(34100a)             |     rmtt1     |
*        *----------------------------------------------------------------------* 
*        |                 top   metal MTT2(40650a)             |     rmtt2     |
*        *----------------------------------------------------------------------* 
*        |                 top   metal TM2(22000a)              |     rtm2      |
*        *----------------------------------------------------------------------* 
           temperature range:-40C~125C
           For more detailed information, please refer to the main document in section 7.6.

           e. MIM capacitor Model
*
*     MIM capacitor : 
*        *-------------------------------------------------------------------*
*        | MIM Option | MIM Location             | 1p3M | 1P4M | 1P5M | 1P6M |
*        |===================================================================|
*        | 1st Option | between M2 and top metal |   X  |      |      |      |   
*        *            -------------------------------------------------------*
*        |            | between M3 and top metal |      |  X   |      |      |   
*        *            -------------------------------------------------------*
*        |            | between M4 and top metal |      |      |  X   |      |   
*        *            -------------------------------------------------------*
*        |            | between M5 and top metal |      |      |      |  X   |   
*        |===================================================================|
*
*        1st option MIM model name:  mim_ckt & mim2_ckt 
*
           temperature range : -40C~125C
*
           f. Varactor capacitor Model
*   Varactor         :
*        *----------------------------------------------*---------------------*
*        |   mos varactor subckt   |         3.3v(IO)   ||         1.8v(Core) |
*        |=========================|====================||====================|
*        |     n+poly/nwell        |     pvar33_ckt     ||     pvar18_ckt     | 
*        *----------------------------------------------*---------------------*
      

5. Corner Model

   Five model corners are provided for MOSFETs, 
   three model corners are provided for BJT, 
   three model corners are provided for diode,    
   three model corners are provided for resistors, 
   three model corners are provided for MIM capacitors.
   three model corners are provided for varactor.

   They are

      ----------------------------------------------------
      MOS          name : corner
      ----------------------------------------------------
                     TT : Typical case 
                     SS : Slow case
                     FF : Fast case
                   SNFP : Slow N Fast P case 
                   FNSP : Fast N Slow P case 
      ----------------------------------------------------
      BJT          name : corner
      ----------------------------------------------------
                 BJT_TT : Typical case
                 BJT_SS : Slow case
                 BJT_FF : Fast case 
      ----------------------------------------------------
      Diode        name : corner
      ----------------------------------------------------
                 DIO_TT : Typical case
                 DIO_SS : Slow case
                 DIO_FF : Fast case 
      ----------------------------------------------------
      Resistor     name : corner
      ----------------------------------------------------
                 RES_TT : Typical case
                 RES_SS : Slow case
                 RES_FF : Fast case 
      ----------------------------------------------------
      MIM          name : corner
      ----------------------------------------------------
                 MIM_TT : Typical case
                 MIM_SS : Slow case
                 MIM_FF : Fast case 
      ----------------------------------------------------
      Varactor     name : corner
      ----------------------------------------------------
                 VAR_TT : Typical case
                 VAR_SS : Slow case
                 VAR_FF : Fast case 
      ----------------------------------------------------
  
6. Monte Carlo Statistical model
   Demo netlist
------------------------------------------------------------
|*SMIC model verification
|.options itl5=0 measdgt=5 post=2 nomod ingold=2
|.lib 'ms018_enhanced_v1p11.lib' mos_mc
|.temp 25
|* assume source at 0
|vg1 g1 0 1.8
|vd1 d1 0 1.8
|vd2 d2 0 1.8
|vb b 0 0
|m1 d1 g1 0 b n18 w=10u l=0.18u
|.dc  sweep  monte=100
|.print dc  id1=i(vd1)
|.end
---------------------------------------------------------------

7. Call mismatch Model;

  mismatch model flag:         
  mismod:     0 (default) disable mos mismatch model
              1           enable mos mismatch model
      mr:     stands for multiplicity factor. It means that 'mr' identical transistors are in parallel. It is equal to 'm'.

 Demo netlist 
---------------------------------------------------------------
 *SMIC model verification
 .options itl5=0 measdgt=5 post=2 nomod ingold=2
 .lib 'ms018_enhanced_v1p11.lib' tt
 .temp 25
 * assume source at 0
 vg1 g1 0 1.8
 vd1 d1 0 1.8
 vd2 d2 0 1.8
 vb b 0 0
 xm1 d1 g1 0 b n18_ckt w=10u l=0.18u mismod=1
 xm2 d2 g1 0 b n18_ckt w=10u l=0.18u mismod=1
.dc  sweep  monte=100
 .print dc  id1=i(vd1)  id1=i(vd2)
 .end
 ---------------------------------------------------------------
 8. Demo netlist For Resistor mismatch model (res_tt corner only)
**********************************************************
$ This is a test
.options  post=2 nomod ingold=2 
.lib 'ms018_enhanced_v1p11.lib' res_tt 
.temp 25
.param wr=4um lr=60um
Xnposab1 n1 n2 0 rnposab_3t_ckt w=wr l=lr mismod_res=1
Xnposab2 n3 n4 0 rnposab_3t_ckt w=wr l=lr mismod_res=1
vn1 n1 0 1  
vn2 n2 0 0
vn3 n3 0 1  
vn4 n4 0 0
.dc monte=100
.print dc res1=par('v(n1)/i(vn2)') res2=par('v(n3)/i(vn4)')
.end
              
