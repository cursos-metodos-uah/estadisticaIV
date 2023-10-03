

casen2022 <- Base_de_datos_Casen_2022_STATA %>% filter(id_persona==1) %>%
  select(id_vivienda,
         asistencia=hh_d_asis,
         rezago=hh_d_rez,
         escolaridad=hh_d_esc,
         malnutricion=hh_d_mal,
         sist_salud=hh_d_prevs,
         atencion=hh_d_acc,
         ocupacion=hh_d_act,
         seg_social=hh_d_cot,
         jubilacion=hh_d_jub,
         habitabilidad=hh_d_habitab,
         serv_basicos=hh_d_servbas,
         entorno=hh_d_entorno,
         ap_part_social=hh_d_appart,
         trato=hh_d_tsocial,
         seguridad=hh_d_seg,
         region,
         area) %>% as.data.frame()

casen2022 <- casen2022[sample(nrow(casen2022), size=10000), ]
save(casen2022,file = "files/data/casen2022.RData")
